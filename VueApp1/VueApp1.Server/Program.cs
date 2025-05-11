using System.Diagnostics;
using System.Text;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options => options.AddPolicy("AllowAll", policy =>
    policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));

var app = builder.Build();
app.UseCors("AllowAll");

var akinPath = "akinator.pl";
Process prologProcess = null;
StreamWriter inputWriter = null;
StreamReader outputReader = null;
bool sessionActive = false;
bool awaitingAnimalName = false;
bool awaitingQuestionText = false;
bool awaitingQuestionAnswer = false;

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

    await inputWriter.WriteLineAsync("play.");
    await inputWriter.FlushAsync();

    sessionActive = true;
    awaitingAnimalName = false;
    awaitingQuestionText = false;
    awaitingQuestionAnswer = false;

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

    var answer = request.Answer;
    if (awaitingAnimalName || awaitingQuestionText)
    {
        answer = $"'{answer}'"; // Оборачиваем в кавычки для Prolog
    }
    await inputWriter.WriteLineAsync(answer + ".");
    await inputWriter.FlushAsync();

    var response = new StringBuilder();
    string line;
    awaitingAnimalName = false;
    awaitingQuestionText = false;
    awaitingQuestionAnswer = false;

    while ((line = await outputReader.ReadLineAsync()) != null)
    {
        if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

        if (line.Contains("Как называется ваше животное?"))
        {
            awaitingAnimalName = true;
            response.AppendLine(line);
            break;
        }

        if (line.Contains("Пожалуйста, введите новый вопрос"))
        {
            awaitingQuestionText = true;
            response.AppendLine(line);
            break;
        }

        if (line.Contains("Какой ответ для"))
        {
            awaitingQuestionAnswer = true;
            response.AppendLine(line);
            break;
        }

        if (line.StartsWith("Отлично! Я угадал!") ||
            line.StartsWith("Спасибо! Я") ||
            line.StartsWith("Игра завершена."))
        {
            sessionActive = false;
            response.AppendLine(line);
            break;
        }

        if (line.StartsWith("Предположение:"))
        {
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

    return Results.Ok(new
    {
        response = response.ToString().Trim(),
        gameActive = sessionActive,
        awaitingAnimalName,
        awaitingQuestionText,
        awaitingQuestionAnswer
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
    awaitingAnimalName = false;
    awaitingQuestionText = false;
    awaitingQuestionAnswer = false;
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