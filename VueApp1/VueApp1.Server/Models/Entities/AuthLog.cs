namespace Akinator.Models.Entities;

public class AuthLog
{
    public int Id { get; set; }
    public string Action { get; set; } 
    public string Username { get; set; }
    public string Email { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}