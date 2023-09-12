using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.ReisdocumentService.Extensions;
using HaalCentraal.ReisdocumentService.Repositories;
using HaalCentraal.ReisdocumentService.Validators;
using Reisdocument.Infrastructure.Logging;
using Serilog;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .CreateLogger();

try
{
    Log.Information("Starting Reisdocument Mock");

    var builder = WebApplication.CreateBuilder(args);

    builder.Logging.ClearProviders();
    builder.Host.UseSerilog(SerilogHelpers.Configure(Log.Logger));

    // Add services to the container.

    builder.Services.AddControllers()
                    .ConfigureInvalidModelStateHandling()
                    .AddNewtonsoftJson();
    builder.Services.AddFluentValidationAutoValidation(options => options.DisableDataAnnotationsValidation = true)
                    .AddValidatorsFromAssemblyContaining<RaadpleegMetReisdocumentnummerValidator>();

    builder.Services.AddScoped<ReisdocumentRepository>();

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    app.UseSerilogRequestLogging();

    app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Reisdocument Mock terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
