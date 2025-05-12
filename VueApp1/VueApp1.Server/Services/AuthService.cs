using Akinator.Database;
using Akinator.Models.Entities;
using Akinator.Models.Responses;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace Akinator.Services;

public class AuthService
{
    private readonly AppDBContext _dbContext; // ��� DbContext

    public AuthService(AppDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task<(bool Success, string Message)> RegisterAsync(RegisterDto request)
    {
        // ��������, ��� ������������ � ����� email ��� �� ����������
        if (await _dbContext.Users.AnyAsync(u => u.Email == request.Email))
            return (false, "Email already exists");

        // ����������� ������ (���������� �������, ����� ������������ PBKDF2 ��� BCrypt)
        var hashedPassword = HashPassword(request.Password);

        // �������� ������������
        var user = new Users
        {
            Login = request.Username,
            Email = request.Email,
            Password = hashedPassword // ��������� ���, � �� plain text!
        };

        // ���������� � ��
        await _dbContext.Users.AddAsync(user);
        await _dbContext.SaveChangesAsync();

        return (true, "User created successfully");
    }

    public async Task<(bool Success, string Message)> LoginAsync(LoginDto request)
    {
        // ����� ������������ �� email
        var user = await _dbContext.Users
            .FirstOrDefaultAsync(u => u.Email == request.Email);

        if (user == null)
            return (false, "Invalid email or password");

        // �������� ������
        var isPasswordValid = VerifyPassword(request.Password, user.Password);

        return isPasswordValid
            ? (true, "Logged in successfully")
            : (false, "Invalid email or password");
    }

    // ���������� ����� ����������� (� �������� ������� ����������� ����������!)
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
    public async Task LogoutAsync()
    {
        await Task.CompletedTask;
    }
}