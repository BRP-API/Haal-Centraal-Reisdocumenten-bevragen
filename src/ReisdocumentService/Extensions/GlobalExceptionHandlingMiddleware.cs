using Newtonsoft.Json;
using Reisdocument.Validatie;

namespace HaalCentraal.ReisdocumentService.Extensions;

public class GlobalExceptionHandlingMiddleware
{

    private readonly RequestDelegate _next;
    private readonly ILogger<GlobalExceptionHandlingMiddleware> _logger;

    public GlobalExceptionHandlingMiddleware(RequestDelegate next, ILogger<GlobalExceptionHandlingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            if (!context.Request.Body.CanSeek)
            {
                context.Request.EnableBuffering();
            }

            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleException(context, ex);
        }
    }

    private Task HandleException(HttpContext context, Exception ex)
    {
        _logger.LogError(ex, message: "Internal Server Error");

        var foutbericht = new Generated.Foutbericht
        {
            Status = StatusCodes.Status500InternalServerError,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Internal Server error.",
            Type = new Uri(Constants.InternalServerErrorIdentifier),
            AdditionalProperties = null
        };

        context.Response.StatusCode = foutbericht.Status!.Value;
        context.Response.ContentType = Constants.ProblemJsonContentType;
        return context.Response.WriteAsync(JsonConvert.SerializeObject(foutbericht, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore,
            DefaultValueHandling = DefaultValueHandling.Ignore
        }));
    }
}
