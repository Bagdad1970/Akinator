using System.Diagnostics;
using System.Text;

using Akinator.Models.Requests;
using Akinator.Models.Responses;

public class GameSession
{
    private readonly Process _prologProcess;
    private readonly StreamWriter _inputWriter;
    private readonly StreamReader _outputReader;
    private bool _sessionActive;

    public GameSession()
    {
        var akinPath = "akinator.pl";
        if (!File.Exists(akinPath))
            throw new InvalidOperationException("Prolog file not found");

        _prologProcess = new Process
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
        _prologProcess.Start();
        _inputWriter = _prologProcess.StandardInput;
        _outputReader = _prologProcess.StandardOutput;
        _sessionActive = false;
    }

    public (string Welcome, string Question) Start()
    {
        _inputWriter.WriteLineAsync("play.").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();
        _sessionActive = true;

        var welcome = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
        var question = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
        return (welcome ?? "Welcome to the game!", question ?? "No question available");
    }

    public ProcessResponse ProcessAnswer(string answer)
    {
        if (!_sessionActive || _prologProcess.HasExited)
            throw new InvalidOperationException("Game session not active");

        // Форматируем ответ для Prolog
        var formattedAnswer = (answer.ToLower() is "yes" or "no") ? answer.ToLower() : $"'{answer}'";
        _inputWriter.WriteLineAsync(formattedAnswer + ".").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();

        var response = new StringBuilder();
        bool isGuess = false;
        bool gameActive = true;

        while (true)
        {
            var line = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
            if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

            response.AppendLine(line);

            if (line.Contains("Предположение:"))
            {
                isGuess = true;
                break;
            }

            if (line.EndsWith("?") || line.Contains("Введите ответ:"))
            {
                break;
            }

            if (line.StartsWith("Отлично! Я угадал!") ||
                line.StartsWith("Игра завершена."))
            {
                gameActive = false;
                break;
            }

            if (line.Contains("Как называется ваше животное?") ||
                line.Contains("Пожалуйста, введите новый вопрос") ||
                line.Contains("Какой ответ для"))
            {
                break;
            }
        }

        return new ProcessResponse
        {
            Response = response.ToString().Trim(),
            GameActive = gameActive,
            IsGuess = isGuess
        };
    }

    public void End()
    {
        if (_prologProcess != null && !_prologProcess.HasExited)
        {
            _inputWriter.WriteLineAsync("halt.").GetAwaiter().GetResult();
            _prologProcess.Kill();
        }
        _sessionActive = false;
    }
}

public class ProcessResponse
{
    public string Response { get; set; }
    public bool GameActive { get; set; }
    public bool IsGuess { get; set; }
}