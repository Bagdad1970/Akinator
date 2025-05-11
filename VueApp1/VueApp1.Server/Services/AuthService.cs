using Microsoft.AspNetCore.Identity;
using Akinator.Models.Responses;

namespace Akinator.Services;

public class AuthService
{
    private readonly UserManager<IdentityUser> _userManager;
    private readonly SignInManager<IdentityUser> _signInManager;

    public AuthService(
        UserManager<IdentityUser> userManager,
        SignInManager<IdentityUser> signInManager)
    {
        _userManager = userManager;
        _signInManager = signInManager;
    }

    public async Task<(bool Success, string Message)> RegisterAsync(RegisterDto request)
    {
        var user = new IdentityUser { UserName = request.Username, Email = request.Email };
        var result = await _userManager.CreateAsync(user, request.Password);

        return result.Succeeded
            ? (true, "User created successfully")
            : (false, string.Join(", ", result.Errors.Select(e => e.Description)));
    }

    public async Task<(bool Success, string Message)> LoginAsync(LoginDto request)
    {
        var user = await _userManager.FindByEmailAsync(request.Email);
        if (user == null)
            return (false, "Invalid email or password");

        var result = await _signInManager.PasswordSignInAsync(
            user.UserName, request.Password, request.RememberMe, false);

        return result.Succeeded
            ? (true, "Logged in successfully")
            : (false, "Invalid email or password");
    }

    public async Task LogoutAsync()
    {
        await _signInManager.SignOutAsync();
    }
}