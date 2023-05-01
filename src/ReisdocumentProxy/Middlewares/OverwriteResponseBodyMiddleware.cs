using AutoMapper;
using HaalCentraal.ReisdocumentProxy.Generated;
using Newtonsoft.Json;
using Reisdocument.Infrastructure.Http;
using Reisdocument.Infrastructure.Stream;
using ReisdocumentProxy.Helpers;
using ReisdocumentProxy.Validators;

namespace ReisdocumentProxy.Middlewares;

public class OverwriteResponseBodyMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
    private readonly IMapper _mapper;

    public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper)
    {
        _next = next;
        _logger = logger;
        _mapper = mapper;
    }

    public async Task Invoke(HttpContext context)
    {
        _logger.LogDebug("TimeZone: {@localTimeZone}. Now: {@now}", TimeZoneInfo.Local.StandardName, DateTime.Now);

        var orgBodyStream = context.Response.Body;
        string requestBody = string.Empty;
        try
        {
            _logger.LogDebug("request headers: {@requestHeaders}", context.Request.Headers);
            if(!await context.MethodIsAllowed(orgBodyStream))
            {
                _logger.LogWarning("method not allowed: {@request.method}", context.Request.Method);
                return;
            }
            if(!await context.AcceptIsAllowed(orgBodyStream))
            {
                _logger.LogWarning("Not supported Accept value: {@request.header}", context.Request.Headers.Accept);
                return;
            }
            if(!await context.ContentTypeIsAllowed(orgBodyStream))
            {
                _logger.LogWarning("Not supported Content-Type value: {@request.header}", context.Request.Headers.ContentType);
                return;
            }

            requestBody = await context.Request.ReadBodyAsync();

            ReisdocumentenQuery? reisdocumentenQuery = null;
            //try
            //{
                reisdocumentenQuery = JsonConvert.DeserializeObject<ReisdocumentenQuery>(requestBody);
        //}
        //catch (Exception ex)
        //{
        //}

            var validationResult = reisdocumentenQuery.Validate(requestBody);
            if(!validationResult.IsValid)
            {
                await context.HandleValidationErrors(validationResult, orgBodyStream);
                return;
            }

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _logger.LogDebug("original response body: {response.body}", body);

            var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                ? body.Transform(_mapper, reisdocumentenQuery.Fields)
                : body;

            _logger.LogDebug("transformed response body: {response.body}", modifiedBody);

            using var bodyStream = modifiedBody.ToMemoryStream(context.Response.Headers.ContentEncoding.Contains("gzip"));

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "request body: {@request.body} headers: {@request.headers}", requestBody, context.Request.Headers);
            await context.HandleUnhandledException(orgBodyStream);
        }
    }
}
