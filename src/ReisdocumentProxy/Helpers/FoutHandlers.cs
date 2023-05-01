using HaalCentraal.ReisdocumentProxy.Generated;
using Reisdocument.Infrastructure;
using Reisdocument.Infrastructure.Json;
using Reisdocument.Infrastructure.Stream;
using Reisdocument.Validatie;
using System.Text.RegularExpressions;

namespace ReisdocumentProxy.Helpers;

public static class FoutHandlers
{
    private static void SetProperties(this HttpResponse response, Foutbericht foutbericht, Stream bodyStream)
    {
        response.StatusCode = foutbericht.Status!.Value;
        response.ContentLength = bodyStream.Length;
        response.ContentType = Constants.ProblemJsonContentType;
    }

    private static bool UseGzip(this HttpResponse response) => response.Headers.ContentEncoding.Contains("gzip");

    public static BadRequestFoutbericht CreateBadRequestFoutbericht(this HttpContext context, string titel, string code, IEnumerable<InvalidParams> invalidParams)
    {
        return new BadRequestFoutbericht
        {
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Status = StatusCodes.Status400BadRequest,
            Title = titel,
            Type = new Uri(Constants.BadRequestIdentifier),
            Code = code,
            Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}.",
            InvalidParams = new List<InvalidParams>(invalidParams)
        };
    }

    public static async Task HandleValidationErrors(this HttpContext context, ValidationResult validationResult, Stream orgResponseBodyStream)
    {
        var message = context.CreateBadRequestFoutbericht(
            "Een of meerdere parameters zijn niet correct.",
            "paramsValidation",
            from error in validationResult.Errors
            select new InvalidParams { Code = error.Code, Name = error.Name, Reason = error.Reason });

        using var bodyStream = message.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetProperties(message, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);
    }

    private static Foutbericht CreateInternalServerErrorFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Status = StatusCodes.Status500InternalServerError,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Internal Server error.",
            Type = new Uri(Constants.InternalServerErrorIdentifier)
        };
    }

    public static async Task HandleUnhandledException(this HttpContext context, Stream orgResponseBodyStream)
    {
        var message = context.CreateInternalServerErrorFoutbericht();

        using var bodyStream = message.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetProperties(message, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);
    }

    private static Foutbericht CreateNotAcceptableFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Code = "notAcceptable",
            Detail = "Ondersteunde content type: application/json; charset=utf-8.",
            Status = StatusCodes.Status406NotAcceptable,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Gevraagde content type wordt niet ondersteund.",
            Type = new Uri(Constants.NotAcceptableIdentifier)
        };
    }

    public static async Task<bool> AcceptIsAllowed(this HttpContext context, Stream orgResponseBodyStream)
    {
        foreach (var acceptValue in context.Request.Headers.Accept)
        {
            if (!string.IsNullOrWhiteSpace(acceptValue) &&
                !new[]
                {
                    "*/*",
                    "*/*;charset=utf-8",
                    "application/json",
                    "application/json;charset=utf-8"
                }.Contains(acceptValue.ToLowerInvariant().RemoveAllWhitespace()))
            {
                var foutbericht = context.CreateNotAcceptableFoutbericht();

                using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

                context.Response.SetProperties(foutbericht, bodyStream);

                await bodyStream.CopyToAsync(orgResponseBodyStream);

                return false;
            }
        }
        return true;
    }

    private static Foutbericht CreateNotSupportedMediaTypeFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Code = "unsupportedMediaType",
            Detail = "Ondersteunde content type: application/json; charset=utf-8.",
            Status = StatusCodes.Status415UnsupportedMediaType,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Media Type wordt niet ondersteund.",
            Type = new Uri(Constants.UnsupportedMediaTypeIdentifier)
        };
    }

    public static async Task<bool> ContentTypeIsAllowed(this HttpContext context, Stream orgResponseBodyStream)
    {
        foreach(var contentType in context.Request.Headers.ContentType)
        {
            if (!string.IsNullOrWhiteSpace(contentType) &&
                !new[]
                {
                    "application/json",
                    "application/json;charset=utf-8"
                }.Contains(contentType.ToLowerInvariant().RemoveAllWhitespace()))
            {
                var foutbericht = context.CreateNotSupportedMediaTypeFoutbericht();

                using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

                context.Response.SetProperties(foutbericht, bodyStream);

                await bodyStream.CopyToAsync(orgResponseBodyStream);

                return false;
            }
        }
        return true;
    }

    private static Foutbericht CreateMethodNotAllowedFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Status = StatusCodes.Status405MethodNotAllowed,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Method not allowed.",
            Type = new Uri(Constants.MethodNotAllowedIdentifier)
        };
    }

    public static async Task<bool> MethodIsAllowed(this HttpContext context, Stream orgResponseBodyStream)
    {
        if (context.Request.Method == HttpMethod.Post.Method) return true;

        var foutbericht = context.CreateMethodNotAllowedFoutbericht();

        using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetProperties(foutbericht, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);

        return false;
    }

    private static readonly Regex UnexpectedCharacterEncounteredRegex = new(@"an unexpected character was encountered: (.*). Path '(?<name>.*)'");
    private static readonly Regex ErrorConvertingToTypeRegex = new(@"Error converting value ""(.*)""(.*). Path '(?<name>.*)'");
    private static readonly Regex NotValidClosingForArrayRegex = new(@"not valid for closing JsonType Array. Path '(?<name>.*)'");
    private static (string name, string code, string reason) Parse(this Exception ex)
    {
        var match = UnexpectedCharacterEncounteredRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "waarde is niet valide");
        }
        match = ErrorConvertingToTypeRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }
        match = NotValidClosingForArrayRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }

        return (string.Empty, string.Empty, string.Empty);
    }

    private static BadRequestFoutbericht CreateJsonExceptionFoutbericht(this HttpContext context, Exception ex)
    {
        (string name, string code, string reason) = ex.Parse();
        List<InvalidParams> invalidParams = new();
        if (!string.IsNullOrEmpty(name) ||
            !string.IsNullOrEmpty(code) ||
            !string.IsNullOrEmpty(reason))
        {
            invalidParams.Add(new InvalidParams { Name = name, Code = code, Reason = reason });
        }

        return new BadRequestFoutbericht
        {
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Status = StatusCodes.Status400BadRequest,
            Title = "Een of meerdere parameters zijn niet correct.",
            Type = new Uri(Constants.BadRequestIdentifier),
            Code = "paramsValidation",
            Detail = $"De foutieve parameter(s) zijn: {name}.",
            InvalidParams = invalidParams
        };
    }

    public static async Task HandleJsonException(this HttpContext context, Exception ex, Stream orgResponseBodyStream)
    {
        var foutbericht = context.CreateJsonExceptionFoutbericht(ex);

        using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetProperties(foutbericht, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);
    }
}
