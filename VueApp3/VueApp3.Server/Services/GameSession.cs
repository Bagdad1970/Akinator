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
            throw new InvalidOperationException("Файл Prolog не найден");

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
        return (welcome ?? "Добро пожаловать в игру!", question ?? "Вопрос недоступен");
    }

    public ProcessResponse ProcessAnswer(string answer)
    {
        if (!_sessionActive || _prologProcess.HasExited)
            throw new InvalidOperationException("Игровая сессия не активна");

        // Форматируем ответ для Prolog
        var formattedAnswer = (answer.ToLower() is "yes" or "no") ? answer.ToLower() : $"'{answer}'";
        _inputWriter.WriteLineAsync(formattedAnswer + ".").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();

        var response = new StringBuilder();
        bool isGuess = false;
        bool gameActive = true;
        bool awaitingAnimalName = false;
        bool awaitingNewQuestion = false;
        bool awaitingNewQuestionAnswer = false;

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

            if (line.Contains("Сообщение: Как называется ваше животное"))
            {
                awaitingAnimalName = true;
                break;
            }

            if (line.Contains("Пожалуйста, введите новый вопрос"))
            {
                awaitingNewQuestion = true;
                break;
            }

            if (line.Contains("Какой ответ для"))
            {
                awaitingNewQuestionAnswer = true;
                break;
            }

            if (line.StartsWith("Отлично! Я угадал!") ||
                line.StartsWith("Игра завершена.") ||
                line.StartsWith("Спасибо! Я"))
            {
                gameActive = false;
                break;
            }
        }

        return new ProcessResponse
        {
            Response = response.ToString().Trim(),
            GameActive = gameActive,
            IsGuess = isGuess,
            AwaitingAnimalName = awaitingAnimalName,
            AwaitingNewQuestion = awaitingNewQuestion,
            AwaitingNewQuestionAnswer = awaitingNewQuestionAnswer
        };
    }

    public ProcessResponse SubmitAnimal(string animalName)
    {
        if (!_sessionActive || _prologProcess.HasExited)
            throw new InvalidOperationException("Игровая сессия не активна");

        // Форматируем имя животного для Prolog (в одинарных кавычках)
        var formattedAnimal = $"'{animalName}'";
        _inputWriter.WriteLineAsync(formattedAnimal + ".").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();

        var response = new StringBuilder();
        bool gameActive = true;
        bool awaitingNewQuestion = false;
        bool awaitingNewQuestionAnswer = false;
        bool isGuess = false;

        while (true)
        {
            var line = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
            if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;


            if (line.StartsWith("Спасибо! Я") ||
                line.StartsWith("Игра завершена."))
            {
                gameActive = false;
                break;
            }
        }

        return new ProcessResponse
        {
            Response = response.ToString().Trim(),
            GameActive = gameActive,
            IsGuess = isGuess,
            AwaitingAnimalName = false,
            AwaitingNewQuestion = awaitingNewQuestion,
            AwaitingNewQuestionAnswer = awaitingNewQuestionAnswer
        };
    }
    public ProcessResponse SubmitNewQuestion(string questionText)
    {
        if (!_sessionActive || _prologProcess.HasExited)
            throw new InvalidOperationException("Игровая сессия не активна");

        // Форматируем текст вопроса для Prolog
        var formattedQuestion = $"'{questionText}'";
        _inputWriter.WriteLineAsync(formattedQuestion + ".").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();

        var response = new StringBuilder();
        bool gameActive = true;
        bool awaitingNewQuestionAnswer = false;

        while (true)
        {
            var line = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
            if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

            response.AppendLine(line);

            if (line.Contains("Какой ответ для"))
            {
                awaitingNewQuestionAnswer = true;
                break;
            }

            if (line.StartsWith("Спасибо! Я") ||
                line.StartsWith("Игра завершена."))
            {
                gameActive = false;
                break;
            }
        }

        return new ProcessResponse
        {
            Response = response.ToString().Trim(),
            GameActive = gameActive,
            IsGuess = false,
            AwaitingAnimalName = false,
            AwaitingNewQuestion = false,
            AwaitingNewQuestionAnswer = awaitingNewQuestionAnswer
        };
    }

    public ProcessResponse SubmitNewQuestionAnswer(string answer)
    {
        if (!_sessionActive || _prologProcess.HasExited)
            throw new InvalidOperationException("Игровая сессия не активна");

        // Форматируем ответ для Prolog
        var formattedAnswer = answer.ToLower();
        _inputWriter.WriteLineAsync(formattedAnswer + ".").GetAwaiter().GetResult();
        _inputWriter.FlushAsync().GetAwaiter().GetResult();

        var response = new StringBuilder();
        bool gameActive = false;

        while (true)
        {
            var line = _outputReader.ReadLineAsync().GetAwaiter().GetResult();
            if (string.IsNullOrWhiteSpace(line) || line == "|:") continue;

            response.AppendLine(line);

            if (line.StartsWith("Спасибо! Я") ||
                line.StartsWith("Игра завершена."))
            {
                break;
            }
        }

        return new ProcessResponse
        {
            Response = response.ToString().Trim(),
            GameActive = gameActive,
            IsGuess = false,
            AwaitingAnimalName = false,
            AwaitingNewQuestion = false,
            AwaitingNewQuestionAnswer = false
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
    public bool AwaitingAnimalName { get; set; }
    public bool AwaitingNewQuestion { get; set; }
    public bool AwaitingNewQuestionAnswer { get; set; }
}