namespace Akinator.Models.Entities;

public class GameStatistics
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public DateTime SessionStart { get; set; } = DateTime.UtcNow;
    public DateTime? SessionEnd { get; set; }
    public int TotalQuestionsAsked { get; set; } = 0;
    public string Answers { get; set; } = "[]";
    public string GuessedAnimal { get; set; }
    public string AddedAnimal { get; set; } 
    public bool? WasCorrectGuess { get; set; }
}