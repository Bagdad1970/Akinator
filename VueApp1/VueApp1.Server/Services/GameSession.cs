using Akinator.Database;
using Akinator.Models.Entities;

namespace Akinator.Services;

public class GameSession
{
    private readonly AppDBContext _dbContext;
    private int _currentQuestionId;

    public GameSession(AppDBContext dbContext)
    {
        _dbContext = dbContext;
        _currentQuestionId = 1; // Start with the first question
    }

    public string GetCurrentQuestion()
    {
        var question = _dbContext.Questions.Find(_currentQuestionId);
        return question?.Text ?? "No question available";
    }

    public GameResponse ProcessAnswer(string answer)
    {
        var question = _dbContext.Questions.Find(_currentQuestionId);
        if (question == null)
            return new GameResponse { GameOver = true, NextQuestion = null };

        _currentQuestionId = answer.ToLower() == "yes"
            ? question.YesNextQuestionId ?? 0
            : question.NoNextQuestionId ?? 0;

        if (_currentQuestionId == 0 || question.Guess != null)
        {
            return new GameResponse
            {
                GameOver = true,
                GuessedCharacter = question.Guess,
                IsCorrect = false
            };
        }

        var nextQuestion = _dbContext.Questions.Find(_currentQuestionId);
        return new GameResponse
        {
            NextQuestion = nextQuestion?.Text,
            GameOver = false
        };
    }

    public class GameResponse
    {
        public string NextQuestion { get; set; }
        public bool GameOver { get; set; }
        public string GuessedCharacter { get; set; }
        public bool IsCorrect { get; set; }
    }
}