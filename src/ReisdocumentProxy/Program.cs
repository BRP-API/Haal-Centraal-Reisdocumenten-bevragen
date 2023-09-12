using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using Reisdocument.Infrastructure.Logging;
using Reisdocument.Infrastructure.mTls;
using ReisdocumentProxy.Middlewares;
using Serilog;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .CreateLogger();

try
{
    Log.Information("Starting Reisdocument Proxy");

    var builder = WebApplication.CreateBuilder(args);

    builder.Logging.ClearProviders();
    builder.Host.UseSerilog(SerilogHelpers.Configure(Log.Logger));

    builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"))
                         .AddJsonFile(Path.Combine("configuration", $"ocelot.{builder.Environment.EnvironmentName}.json"), true)
                         .AddEnvironmentVariables();

    // Add services to the container.
    builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
    builder.Services.AddOcelot()
                    .AddDelegatingHandler<X509Handler>(global: true);

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    app.UseSerilogRequestLogging();

    app.UseMiddleware<OverwriteResponseBodyMiddleware>();
    app.UseOcelot().Wait();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Reisdocument Proxy terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
