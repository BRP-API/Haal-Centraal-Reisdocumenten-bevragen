﻿using Elastic.Apm.SerilogEnricher;
using Elastic.CommonSchema.Serilog;
using Microsoft.Extensions.Hosting;
using Serilog;
using Serilog.Enrichers.Span;
using Serilog.Exceptions;
using Serilog.Sinks.SystemConsole.Themes;
using System.Text;

namespace Reisdocument.Infrastructure.Logging;

public static class SerilogHelpers
{
    public static Action<HostBuilderContext, LoggerConfiguration> Configure(ILogger logger)
    {
        return (context, config) =>
        {
            config
                .ReadFrom.Configuration(context.Configuration)
                .Enrich.WithElasticApmCorrelationInfo()
                .Enrich.WithExceptionDetails()
                .Enrich.WithMachineName()
                .Enrich.WithProperty("AppVersion", VersionHelpers.AppVersion)
                .Enrich.WithProperty("ApiVersion", VersionHelpers.ApiVersion)
                .Enrich.WithProperty("ApplicationName", context.HostingEnvironment.ApplicationName)
                .Enrich.FromLogContext()
                .Enrich.With<ActivityEnricher>();

            var serilogLogLevel = context.Configuration["Serilog:MinimumLevel:Override:Serilog"];
            var serilogLogLevelIsDebug = !string.IsNullOrWhiteSpace(serilogLogLevel) && serilogLogLevel == "Debug";
            if (context.HostingEnvironment.IsDevelopment() || serilogLogLevelIsDebug)
            {
                StringBuilder sb = new();
                if (context.HostingEnvironment.IsDevelopment())
                {
                    sb.Append("Hosting Environment: Development");
                }
                if (serilogLogLevelIsDebug)
                {
                    if(sb.Length > 0) { sb.Append(", "); }
                    sb.Append("Log level: Debug");
                }

                logger.Information($"{sb}. Enable console logging");
                config.WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                                 theme: AnsiConsoleTheme.Code);

            }

            var ecsPath = context.Configuration["Ecs:Path"];
            if(!string.IsNullOrWhiteSpace(ecsPath))
            {
                logger.Information("Enable file logging using Elasticsearch Common Schema format. Path: {path}", ecsPath);
                config.WriteTo.File(new EcsTextFormatter(), ecsPath);
            }

            var seqServerUrl = context.Configuration["Seq:ServerUrl"];
            if (!string.IsNullOrWhiteSpace(seqServerUrl))
            {
                logger.Information("Enable logging to Seq. ServerUrl: {serverUrl}", seqServerUrl);
                config.WriteTo.Seq(seqServerUrl);
            }
        };
    }
}
