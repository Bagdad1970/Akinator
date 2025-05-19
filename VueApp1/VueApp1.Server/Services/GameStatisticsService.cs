using Akinator.Database;
using Akinator.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace Akinator.Services;

public class GameStatisticsService
{
    private readonly AppDBContext _dbContext;

    public GameStatisticsService(AppDBContext dbContext)
    {
        _dbContext = dbContext;
    }

    public async Task SaveGameStatisticsAsync(GameStatistics statistics)
    {
        await _dbContext.GameStatistics.AddAsync(statistics);
        await _dbContext.SaveChangesAsync();
    }

    public async Task<int> GetUserIdByUsernameAsync(string username)
    {
        var user = await _dbContext.Users
            .FirstOrDefaultAsync(u => u.Login == username);
        if (user == null)
            throw new InvalidOperationException($"User with username {username} not found");
        return user.Id;
    }
}