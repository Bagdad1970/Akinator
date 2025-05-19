using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Akinator.Models.Entities;
using System.Reflection.Emit;

namespace Akinator.Database;

public class AppDBContext : IdentityDbContext<IdentityUser, IdentityRole, string>
{
    public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

    public DbSet<Question> Questions { get; set; }

    public DbSet<Users> Users { get; set; }

    public DbSet<Animals> Animals { get; set; }

    public DbSet<AuthLog> AuthLogs { get; set; }

    public DbSet<GameStatistics> GameStatistics { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
    }
}