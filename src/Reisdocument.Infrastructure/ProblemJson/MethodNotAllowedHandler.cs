using Microsoft.AspNetCore.Http;
using Reisdocument.Infrastructure.Http;
using Reisdocument.Infrastructure.Json;
using Reisdocument.Infrastructure.Stream;

namespace Reisdocument.Infrastructure.ProblemJson;

public static class MethodNotAllowedHandler
{
    private static Foutbericht CreateMethodNotAllowedFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Status = StatusCodes.Status405MethodNotAllowed,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Gebruikte bevragingsmethode is niet toegestaan.",
            Code = "methodNotAllowed",
            Type = new Uri(StatusCodeIdentifiers.MethodNotAllowedIdentifier)
        };
    }

    public static async Task<Foutbericht?> MethodIsAllowed(this HttpContext context, System.IO.Stream orgResponseBodyStream)
    {
        if (context.Request.Method == HttpMethod.Post.Method) return null;

        var foutbericht = context.CreateMethodNotAllowedFoutbericht();

        using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetHeaderPropertiesFrom(foutbericht, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);

        return foutbericht;
    }
}
