using Akinator.Models.Requests;
using System.Diagnostics;
using System.Text;
using Akinator.Models.Responses;

namespace Akinator.Services;

public class GameService
{
    private readonly Dictionary<string, GameSession> _activeGames = new();

    public GameStateDto StartNewGame(string userId)
    {
        var gameSession = new GameSession();
        _activeGames[userId] = gameSession;
        var (welcome, question) = gameSession.Start();
        return new GameStateDto
        {
            Question = $"{welcome}\n{question}",
            GameOver = false
        };
    }

    public GameStateDto ProcessAnswer(string answer, string userId)
    {
        if (!_activeGames.TryGetValue(userId, out var gameSession))
            throw new InvalidOperationException("Game not started");

        var response = gameSession.ProcessAnswer(answer);
        if (!response.GameActive)
        {
            _activeGames.Remove(userId);
        }

        return new GameStateDto
        {
            Question = response.Response,
            GameOver = !response.GameActive,
            Guess = response.IsGuess ? ExtractGuess(response.Response) : null,
            IsCorrect = response.Response.Contains("Отлично! Я угадал!")
        };
    }

    public void EndGame(string userId)
    {
        if (_activeGames.TryGetValue(userId, out var gameSession))
        {
            gameSession.End();
            _activeGames.Remove(userId);
        }
    }

    private string ExtractGuess(string response)
    {
        if (response.StartsWith("Предположение:"))
        {
            return response.Replace("Предположение: Это ", "").Replace("? (yes/no): ", "").Trim();
        }
        return null;
    }
}