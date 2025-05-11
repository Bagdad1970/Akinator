using Akinator.Database;
using Akinator.Models.Responses;
using Microsoft.EntityFrameworkCore;

namespace Akinator.Services;

public class GameService
{
    private readonly AppDBContext _dbContext;
    private readonly Dictionary<string, GameSession> _activeGames = new();

    public GameService(AppDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public GameStateDto StartNewGame(string userId)
    {
        var gameSession = new GameSession(_dbContext);
        _activeGames[userId] = gameSession;

        return new GameStateDto
        {
            Question = gameSession.GetCurrentQuestion(),
            GameOver = false
        };
    }

    public GameStateDto ProcessAnswer(string answer, string userId)
    {
        if (!_activeGames.TryGetValue(userId, out var gameSession))
            throw new InvalidOperationException("Game not started");

        if (!IsValidAnswer(answer))
            throw new InvalidOperationException("Invalid answer. Use 'yes' or 'no'.");

        var response = gameSession.ProcessAnswer(answer);

        return new GameStateDto
        {
            Question = response.NextQuestion ?? "",
            GameOver = response.GameOver,
            Guess = response.GuessedCharacter,
            IsCorrect = response.IsCorrect
        };
    }

    public void EndGame(string userId)
    {
        if (!_activeGames.Remove(userId))
            throw new InvalidOperationException("No active game found");
    }

    private bool IsValidAnswer(string answer)
    {
        return answer.ToLower() is "yes" or "no";
    }
}