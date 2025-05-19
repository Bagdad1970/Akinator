namespace Akinator.Models.Responses;

public class GameStateDto
{
    public string Question { get; set; }
    public bool GameOver { get; set; }
    public string Guess { get; set; }
    public bool IsCorrect { get; set; }
    public bool AwaitingAnimalName { get; set; }
    public bool AwaitingNewQuestion { get; set; }
    public bool AwaitingNewQuestionAnswer { get; set; }
}