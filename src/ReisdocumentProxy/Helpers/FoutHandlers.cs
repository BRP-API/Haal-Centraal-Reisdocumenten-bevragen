using HaalCentraal.ReisdocumentProxy.Generated;
using Reisdocument.Infrastructure;
using Reisdocument.Infrastructure.Json;
using Reisdocument.Infrastructure.Stream;
using Reisdocument.Validatie;

namespace ReisdocumentProxy.Helpers;

public static class FoutHandlers
{
    private static void SetProperties(this HttpResponse response, Foutbericht foutbericht, Stream bodyStream)
    {
        response.StatusCode = foutbericht.Status!.Value;
        response.ContentLength = bodyStream.Length;
        response.ContentType = Constants.ProblemJsonContentType;
    }

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

        using var bodyStream = message.ToJson().ToMemoryStream(context.Response.Headers.ContentEncoding.Contains("gzip"));

        context.Response.SetProperties(message, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);
    }
}
