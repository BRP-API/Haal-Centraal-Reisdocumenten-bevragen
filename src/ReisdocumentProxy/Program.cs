using Ocelot.DependencyInjection;
using Ocelot.Middleware;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"))
                     .AddJsonFile(Path.Combine("configuration", $"ocelot.{builder.Environment.EnvironmentName}.json"), true)
                     .AddEnvironmentVariables();

// Add services to the container.

builder.Services.AddOcelot();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseOcelot().Wait();

app.Run();
