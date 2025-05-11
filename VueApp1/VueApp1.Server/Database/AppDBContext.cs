using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Akinator.Models.Entities;

namespace Akinator.Database;

public class AppDBContext : IdentityDbContext
{
    public AppDBContext(DbContextOptions<AppDBContext> options) : base(options) { }

    public DbSet<Question> Questions { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        // Seed initial questions
        builder.Entity<Question>().HasData(
            new Question { Id = 1, Text = "Is your character real?", YesNextQuestionId = 2, NoNextQuestionId = 3 },
            new Question { Id = 2, Text = "Is your character a historical figure?", YesNextQuestionId = null, NoNextQuestionId = null, Guess = "Historical Figure" },
            new Question { Id = 3, Text = "Is your character from a movie?", YesNextQuestionId = null, NoNextQuestionId = null, Guess = "Fictional Character" }
        );
    }
}