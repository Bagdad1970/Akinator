using System.Diagnostics;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options => options.AddPolicy("AllowAll", policy =>
    policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));

var app = builder.Build();
app.UseCors("AllowAll");

var akinPath = "/akinator.pl";
Process prologProcess = null;
StreamWriter inputWriter = null;
StreamReader outputReader = null;
bool sessionActive = false;

// Проверка загрузки файла
app.MapGet("/check", () =>
{
    var exists = File.Exists(akinPath);
    var content = exists ? File.ReadAllText(akinPath) : "Файл не найден";
    return Results.Ok(new { exists, content });
});

app.MapPost("/start", async () =>
{
    if (prologProcess != null && !prologProcess.HasExited)
    {
        prologProcess.Kill();
    }

    prologProcess = new Process
    {
        StartInfo = new ProcessStartInfo
        {
            FileName = "swipl",
            Arguments = $"-q -f \"{akinPath}\"",
            RedirectStandardInput = true,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            UseShellExecute = false,
            StandardOutputEncoding = Encoding.UTF8,
            CreateNoWindow = true
        }
    };

    prologProcess.Start();
    inputWriter = prologProcess.StandardInput;
    outputReader = prologProcess.StandardOutput;

    // Запускаем игру
    await inputWriter.WriteLineAsync("start.");
    await inputWriter.FlushAsync();

    sessionActive = true;

    // Читаем приветственное сообщение и первый вопрос
    var welcomeMessage = await outputReader.ReadLineAsync();
    var firstQuestion = await outputReader.ReadLineAsync();

    return Results.Ok(new
    {
        welcome = welcomeMessage,
        question = firstQuestion
    });
});

app.MapPost("/answer", async (AnswerRequest request) =>
{
    if (!sessionActive || prologProcess == null || prologProcess.HasExited)
    {
        return Results.BadRequest("Сначала запустите сессию через /start");
    }

    // Отправляем ответ (1/0/2 в зависимости от вопроса)
    await inputWriter.WriteLineAsync(request.Answer + ".");
    await inputWriter.FlushAsync();

    // Читаем ответ Prolog (следующий вопрос или результат)
    var response = new StringBuilder();
    string line;
    while ((line = await outputReader.ReadLineAsync()) != null)
    {
        // Пропускаем пустые строки и приглашения Prolog
        if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

        // Проверяем на конец игры
        if (line.StartsWith("Я думаю, вы загадали:") ||
            line.StartsWith("Ни одно животное") ||
            line.StartsWith("Вопросы закончились") ||
            line.StartsWith("Возможные варианты:"))
        {
            sessionActive = false;
            response.AppendLine(line);
            break;
        }

        // Если это новый вопрос
        if (line.EndsWith("?") || line.Contains("Введите ответ:"))
        {
            response.AppendLine(line);
            break;
        }

        response.AppendLine(line);
    }

    return Results.Ok(new
    {
        response = response.ToString().Trim(),
        gameActive = sessionActive
    });
});

app.MapPost("/end", () =>
{
    if (prologProcess != null && !prologProcess.HasExited)
    {
        inputWriter?.WriteLine("halt.");
        prologProcess.Kill();
    }
    sessionActive = false;
    return Results.Ok("Сессия завершена");
});

app.Lifetime.ApplicationStopping.Register(() =>
{
    if (prologProcess != null && !prologProcess.HasExited)
    {
        prologProcess.Kill();
    }
});

app.Run();

record AnswerRequest(string Answer);