using System.ComponentModel.DataAnnotations;

namespace Akinator.Models.Requests;

public class AnswerRequest
{
    [Required]
    public string Answer { get; set; }
}