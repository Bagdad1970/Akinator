namespace AkinatorBackend.Models;

public record AnswerRequest(string Answer);
public record RegisterModel(string Username, string Email, string Password);
public record LoginModel(string Email, string Password, bool RememberMe = false);