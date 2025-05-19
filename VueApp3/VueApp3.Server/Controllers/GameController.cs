using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Akinator.Services;
using Akinator.Models.Requests;
using Akinator.Models.Entities;

namespace Akinator.Controllers;

[ApiController]
[Route("api/game")]
[Authorize]
public class GameController : ControllerBase
{
    private readonly GameService _gameService;

    public GameController(GameService gameService)
    {
        _gameService = gameService;
    }

    [HttpPost("start")]
    public IActionResult StartGame()
    {
        var gameState = _gameService.StartNewGame(User.Identity.Name);
        return Ok(gameState);
    }

    [HttpPost("answer")]
    public IActionResult SubmitAnswer([FromBody] AnswerRequest request)
    {
        if (!ModelState.IsValid)
            return BadRequest(ModelState);

        try
        {
            var response = _gameService.ProcessAnswer(request.Answer, User.Identity.Name);
            return Ok(response);
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(new { Message = ex.Message });
        }
    }
}