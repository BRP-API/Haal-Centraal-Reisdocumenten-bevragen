using Elastic.Apm.SerilogEnricher;
using Elastic.CommonSchema.Serilog;
using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using ReisdocumentProxy.DelegatingHandlers;
using ReisdocumentProxy.Middlewares;
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
        .Enrich.WithElasticApmCorrelationInfo()
        .Enrich.WithExceptionDetails()
        .Enrich.FromLogContext()
        .Enrich.With<ActivityEnricher>()
        .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                         theme: AnsiConsoleTheme.Code)
        .WriteTo.File(new EcsTextFormatter(), context.Configuration["Ecs:Path"]!)
        .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]!);
});

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
