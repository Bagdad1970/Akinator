using Akinator.Database;
using Akinator.Services;
using Akinator.Models.Requests;
using System.Text.Json;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using System.Diagnostics;
using System.Text;
using Akinator.Models.Entities;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "Akinator API", Version = "v1" });
});

// Identity with DB context
builder.Services.AddDbContext<AppDBContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("Default")));

builder.Services.AddIdentityCore<IdentityUser>(options =>
{
    options.User.RequireUniqueEmail = true;
    options.Password.RequiredLength = 6;
})
.AddRoles<IdentityRole>()
.AddEntityFrameworkStores<AppDBContext>()
.AddDefaultTokenProviders();

builder.Services.AddIdentity<IdentityUser, IdentityRole>()
    .AddEntityFrameworkStores<AppDBContext>()
    .AddDefaultTokenProviders();

// Services
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<GameService>();

// Register Prolog service as singleton (maintains single process)
builder.Services.AddSingleton<PrologService>();

// CORS (configure properly for production)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowAll");
app.UseAuthentication();
app.UseAuthorization();

// Add minimal API endpoints for Prolog interaction
var prolog = app.Services.GetRequiredService<PrologService>();

app.MapGet("/check", () =>
{
    try
    {
        var exists = File.Exists(prolog.AkinPath);
        var content = exists ? File.ReadAllText(prolog.AkinPath) : "File not found";
        return Results.Ok(new { exists, content });
    }
    catch (Exception ex)
    {
        return Results.Problem($"Error checking file: {ex.Message}");
    }
});

app.MapPost("/start", async () =>
{
    try
    {
        var (welcome, question) = await prolog.StartSession();
        return Results.Ok(new { welcome, question });
    }
    catch (Exception ex)
    {
        return Results.Problem($"Start error: {ex.Message}");
    }
});

app.MapPost("/answer", async (AnswerRequest request) =>
{
    try
    {
        var (response, gameActive) = await prolog.ProcessAnswer(request.Answer);
        return Results.Ok(new { response, gameActive });
    }
    catch (Exception ex)
    {
        return Results.Problem($"Answer error: {ex.Message}");
    }
});

app.MapPost("/end", async (
    [FromBody] GameStatistics stats,
    [FromServices] AppDBContext dbContext) =>
{
    // Проверка входных данных
    if (stats == null)
    {
        Console.WriteLine("Ошибка: stats равен null");
        return Results.BadRequest("Входные данные отсутствуют");
    }

    Console.WriteLine($"Получены данные: {System.Text.Json.JsonSerializer.Serialize(stats)}");

    try
    {
        // Проверка, что dbContext инициализирован
        if (dbContext == null)
        {
            Console.WriteLine("Ошибка: dbContext равен null");
            return Results.Problem("Контекст базы данных не инициализирован");
        }

        var gameStatistics = new GameStatistics
        {
            UserId = stats.UserId,
            SessionStart = stats.SessionStart,
            SessionEnd = stats.SessionEnd ?? DateTime.UtcNow,
            TotalQuestionsAsked = stats.TotalQuestionsAsked,
            Answers = stats.Answers ?? "[]",
            GuessedAnimal = stats.GuessedAnimal,
            AddedAnimal = stats.AddedAnimal,
            WasCorrectGuess = stats.WasCorrectGuess
        };

        await dbContext.GameStatistics.AddAsync(gameStatistics);
        await dbContext.SaveChangesAsync();

        // Проверка prolog (если он нужен)
        try
        {
            prolog?.EndSession(); // Используем ?. для безопасного вызова, если prolog может быть null
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Ошибка в prolog.EndSession: {ex.Message}");
            // Игнорируем ошибку prolog, если она не критична
        }

        return Results.Ok("Статистика игры успешно сохранена");
    }
    catch (Exception ex)
    {
        Console.WriteLine($"Ошибка сохранения: {ex.Message}, Inner: {ex.InnerException?.Message}");
        return Results.Problem("Не удалось сохранить статистику игры");
    }
});

app.MapControllers();

// Seed initial data
await SeedData.Initialize(app.Services);

app.Run();

// Prolog Service Implementation
public class PrologService : IDisposable
{
    private Process _prologProcess;
    private StreamWriter _inputWriter;
    private StreamReader _outputReader;
    public string AkinPath { get; }
    private bool _sessionActive;

    public PrologService(IConfiguration configuration)
    {
        AkinPath = Path.Combine(Directory.GetCurrentDirectory(), "akinator.pl");
    }

    public async Task<(string Welcome, string Question)> StartSession()
    {
        CleanupPrologProcess();

        if (!File.Exists(AkinPath))
            throw new FileNotFoundException($"Prolog file not found at {AkinPath}");

        _prologProcess = new Process
        {
            StartInfo = new ProcessStartInfo
            {
                FileName = "swipl",
                Arguments = $"-q -f \"{AkinPath}\"",
                RedirectStandardInput = true,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                UseShellExecute = false,
                StandardOutputEncoding = Encoding.UTF8,
                CreateNoWindow = true
            }
        };

        _prologProcess.ErrorDataReceived += (sender, e) =>
            Console.WriteLine($"Prolog Error: {e.Data}");

        _prologProcess.Start();
        _prologProcess.BeginErrorReadLine();

        _inputWriter = _prologProcess.StandardInput;
        _outputReader = _prologProcess.StandardOutput;

        await _inputWriter.WriteLineAsync("play.");
        await _inputWriter.FlushAsync();

        _sessionActive = true;

        var welcomeMessage = await _outputReader.ReadLineAsync();
        var firstQuestion = await _outputReader.ReadLineAsync();

        return (welcomeMessage ?? "Welcome to Akinator!",
                firstQuestion ?? "Is your character real?");
    }

    public async Task<(string Response, bool GameActive)> ProcessAnswer(string answer)
    {
        if (!_sessionActive || _prologProcess == null || _prologProcess.HasExited)
            throw new InvalidOperationException("Session not active");

        await _inputWriter.WriteLineAsync(answer + ".");
        await _inputWriter.FlushAsync();

        var response = new StringBuilder();
        string line;
        while ((line = await _outputReader.ReadLineAsync()) != null)
        {
            if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

            if (line.StartsWith("Я думаю, вы загадали:") ||
                line.StartsWith("Ни одно животное") ||
                line.StartsWith("Вопросы закончились") ||
                line.StartsWith("Возможные варианты:"))
            {
                _sessionActive = false;
                response.AppendLine(line);
                break;
            }

            if (line.EndsWith("?") || line.Contains("Введите ответ:"))
            {
                response.AppendLine(line);
                break;
            }

            response.AppendLine(line);
        }

        return (response.ToString().Trim(), _sessionActive);
    }

    public void EndSession()
    {
        if (_prologProcess != null && !_prologProcess.HasExited)
        {
            _inputWriter?.WriteLine("halt.");
            _prologProcess.Kill();
        }
        _sessionActive = false;
    }

    private void CleanupPrologProcess()
    {
        try
        {
            if (_prologProcess != null && !_prologProcess.HasExited)
            {
                _inputWriter?.WriteLine("halt.");
                _prologProcess.Kill();
                _prologProcess.Dispose();
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error cleaning up Prolog process: {ex.Message}");
        }
    }

    public void Dispose()
    {
        CleanupPrologProcess();
        _inputWriter?.Dispose();
        _outputReader?.Dispose();
        GC.SuppressFinalize(this);
    }
}

public static class SeedData
{
    public static async Task Initialize(IServiceProvider services)
    {
        using var scope = services.CreateScope();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();
        var configuration = scope.ServiceProvider.GetRequiredService<IConfiguration>();

        if (!userManager.Users.Any())
        {
            var admin = new IdentityUser { UserName = "admin", Email = "admin@example.com" };
            var adminPassword = configuration["SeedData:AdminPassword"]
                ?? throw new InvalidOperationException("Admin password not configured");
            await userManager.CreateAsync(admin, adminPassword);
        }
    }
}