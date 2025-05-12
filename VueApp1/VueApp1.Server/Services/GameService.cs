using Akinator.Models.Requests;
using Akinator.Models.Responses;
using System;

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
            GameOver = false,
            AwaitingAnimalName = false
        };
    }

    public GameStateDto ProcessAnswer(string answer, string userId)
    {
        if (!_activeGames.TryGetValue(userId, out var gameSession))
            throw new InvalidOperationException("Game not started");

        var response = gameSession.ProcessAnswer(answer);
        bool awaitingAnimalName = response.Response.Contains("Какое это животное?") ||
                                 response.Response.Contains("Назови животное");

        if (!response.GameActive && !awaitingAnimalName)
        {
            _activeGames.Remove(userId);
        }

        return new GameStateDto
        {
            Question = response.Response,
            GameOver = !response.GameActive && !awaitingAnimalName,
            Guess = response.IsGuess ? ExtractGuess(response.Response) : null,
            IsCorrect = response.Response.Contains("Отлично! Я угадал!"),
            AwaitingAnimalName = awaitingAnimalName
        };
    }

    public GameStateDto SubmitAnimal(string animalName, string userId)
    {
        if (!_activeGames.TryGetValue(userId, out var gameSession))
            throw new InvalidOperationException("Game not started");

        // Assuming GameSession has a method to handle animal submission
        var response = gameSession.SubmitAnimal(animalName);
        return new GameStateDto
        {
            Question = response.Response,
            GameOver = !response.GameActive,
            Guess = null,
            IsCorrect = false,
            AwaitingAnimalName = false
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