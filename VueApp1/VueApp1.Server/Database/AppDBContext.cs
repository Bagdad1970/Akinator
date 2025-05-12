using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;
using Akinator.Models.Entities;

namespace Akinator.Database;

public class AppDBContext : IdentityDbContext<IdentityUser, IdentityRole, string>
{
    public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

    public DbSet<Question> Questions { get; set; }

    public DbSet<Users> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // ???????????? ????????
        builder.Entity<Question>().HasData(
            new Question { Id = 1, Text = "Is your character real?", YesNextQuestionId = 2, NoNextQuestionId = 3 },
            new Question { Id = 2, Text = "Is your character a historical figure?", Guess = "Historical Figure" },
            new Question { Id = 3, Text = "Is your character from a movie?", Guess = "Fictional Character" }
        );
    }
}