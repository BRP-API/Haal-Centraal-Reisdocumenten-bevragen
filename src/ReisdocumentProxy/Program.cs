using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using ReisdocumentProxy.DelegatingHandlers;
using ReisdocumentProxy.Middlewares;

var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"))
                     .AddJsonFile(Path.Combine("configuration", $"ocelot.{builder.Environment.EnvironmentName}.json"), true)
                     .AddEnvironmentVariables();

// Add services to the container.
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
builder.Services.AddOcelot()
                .AddDelegatingHandler<X509Handler>(global: true);

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseMiddleware<OverwriteResponseBodyMiddleware>();
app.UseOcelot().Wait();

app.Run();
