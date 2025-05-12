namespace Akinator.Models.Entities;

public class Question
{
    public int Id { get; set; }
    public string Text { get; set; }
    public int? YesNextQuestionId { get; set; }
    public int? NoNextQuestionId { get; set; }
    public string? Guess { get; set; } // Добавлен модификатор ?
}