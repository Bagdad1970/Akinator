using Microsoft.AspNetCore.Identity;

namespace Akinator;

public static class SeedData
{
    public static async Task Initialize(IServiceProvider services)
    {
        using var scope = services.CreateScope();
        var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();
        var configuration = scope.ServiceProvider.GetRequiredService<IConfiguration>();

        if (!userManager.Users.Any())
        {
            var admin = new IdentityUser { UserName = "admin", Email = "admin@example.com" };
            var adminPassword = configuration["SeedData:AdminPassword"];
            await userManager.CreateAsync(admin, adminPassword);
        }
    }
}