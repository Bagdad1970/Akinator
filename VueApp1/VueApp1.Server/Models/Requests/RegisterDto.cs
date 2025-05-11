using System.ComponentModel.DataAnnotations;

namespace Akinator.Models.Requests;

public class RegisterDto
{
    [Required]
    public string Username { get; set; }

    [Required, EmailAddress]
    public string Email { get; set; }

    [Required, MinLength(6)]
    public string Password { get; set; }
}