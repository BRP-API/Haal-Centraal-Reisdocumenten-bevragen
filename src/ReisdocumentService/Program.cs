using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.ReisdocumentService.Extensions;
using HaalCentraal.ReisdocumentService.Repositories;
using HaalCentraal.ReisdocumentService.Validators;
using Serilog;
using Serilog.Enrichers.Span;
using Serilog.Exceptions;
using Serilog.Sinks.SystemConsole.Themes;

var builder = WebApplication.CreateBuilder(args);

builder.Logging.ClearProviders();
builder.Host.UseSerilog((context, config) =>
{
    config
        .ReadFrom.Configuration(context.Configuration)
        .Enrich.WithExceptionDetails()
        .Enrich.FromLogContext()
        .Enrich.With<ActivityEnricher>()
        .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                         theme: AnsiConsoleTheme.Code)
        .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]);
});

// Add services to the container.

builder.Services.AddControllers()
                .ConfigureInvalidModelStateHandling()
                .AddNewtonsoftJson();
builder.Services.AddFluentValidationAutoValidation(options => options.DisableDataAnnotationsValidation = true)
                .AddValidatorsFromAssemblyContaining<RaadpleegMetReisdocumentnummerValidator>();

builder.Services.AddScoped<ReisdocumentRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapControllers();

app.Run();