using Microsoft.AspNetCore.Mvc;
using Akinator.Services;
using Akinator.Models.Responses;

namespace Akinator.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController : ControllerBase
{
    private readonly AuthService _authService;

    public AuthController(AuthService authService)
    {
        _authService = authService;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterDto dto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var result = await _authService.RegisterAsync(dto);
        return result.Success
            ? Ok(new { result.Message, result.Username, result.userId })
            : BadRequest(new { result.Message });
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginDto dto)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        var result = await _authService.LoginAsync(dto);
        return result.Success
            ? Ok(new { result.Message, result.Username, result.userId, result.email })
            : Unauthorized(new { result.Message });
    }

    [HttpPost("logout")]
    public async Task<IActionResult> Logout([FromBody] LogoutDto dto)
    {
        await _authService.LogoutAsync(dto.Username, dto.Email);
        return Ok(new { Message = "Logged out successfully" });
    }
}