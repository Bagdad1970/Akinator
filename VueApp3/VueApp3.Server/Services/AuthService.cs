using Akinator.Database;
using Akinator.Models.Entities;
using Akinator.Models.Responses;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace Akinator.Services;

public class AuthService
{
    private readonly AppDBContext _dbContext;

    public AuthService(AppDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<(bool Success, string Message, string Username, int userId, string email)> RegisterAsync(RegisterDto request)
    {
        if (await _dbContext.Users.AnyAsync(u => u.Email == request.Email))
            return (false, "Email already exists", "Error", 0, "");

        var hashedPassword = HashPassword(request.Password);

        var user = new Users
        {
            Login = request.Username,
            Email = request.Email,
            Password = hashedPassword
        };

        await _dbContext.Users.AddAsync(user);
        await _dbContext.SaveChangesAsync();

        // Сохранение лога регистрации
        await LogAuthAction("Register", request.Username, request.Email);

        return (true, "User created successfully", user.Login, user.Id, user.Email);
    }

    public async Task<(bool Success, string Message, string Username, int userId, string email)> LoginAsync(LoginDto request)
    {
        var user = await _dbContext.Users
            .FirstOrDefaultAsync(u => u.Email == request.Email);

        if (user == null)
            return (false, "Invalid email or password", "Error", 0, "");

        var isPasswordValid = VerifyPassword(request.Password, user.Password);

        if (isPasswordValid)
        {
            // Сохранение лога входа
            await LogAuthAction("Login", user.Login, user.Email);
            return (true, "Logged in successfully", user.Login, user.Id, user.Email);
        }

        return (false, "Invalid email or password", "Error", 0, "");
    }

    public async Task LogoutAsync(string username, string email)
    {
        await LogAuthAction("Logout", username, email);
    }

    private async Task LogAuthAction(string action, string username, string email)
    {
        var log = new AuthLog
        {
            Action = action,
            Username = username,
            Email = email,
            CreatedAt = DateTime.UtcNow
        };

        await _dbContext.AuthLogs.AddAsync(log);
        await _dbContext.SaveChangesAsync();
    }

    private string HashPassword(string password)
    {
        using var sha256 = SHA256.Create();
        var bytes = Encoding.UTF8.GetBytes(password);
        var hash = sha256.ComputeHash(bytes);
        return Convert.ToBase64String(hash);
    }

    private bool VerifyPassword(string inputPassword, string storedHash)
    {
        var inputHash = HashPassword(inputPassword);
        return inputHash == storedHash;
    }
}