﻿using Microsoft.AspNetCore.Mvc;
using Reisdocument.Infrastructure;
using Reisdocument.Infrastructure.Http;
using Reisdocument.Infrastructure.Json;

namespace HaalCentraal.ReisdocumentService.Extensions;

public static class InvalidModelStateResponseFactory
{
    public static IMvcBuilder ConfigureInvalidModelStateHandling(this IMvcBuilder builder)
    {
        return builder.ConfigureApiBehaviorOptions(options =>
        {
            options.InvalidModelStateResponseFactory = context => InvalidModelStateResponseFactory.CreateProblemDetails(context);
        });
    }

    private static IActionResult CreateProblemDetails(ActionContext context)
    {
        var invalidParams = (from kvp in context.ModelState
                             from error in kvp.Value.Errors
                             select new Generated.InvalidParams
                             {
                                 Name = $"{char.ToLowerInvariant(kvp.Key[0])}{kvp.Key[1..]}",
                                 Code = error.ErrorMessage.Contains("||")
                                     ? error.ErrorMessage.Split("||")[0]
                                     : null,
                                 Reason = error.ErrorMessage.Contains("||")
                                     ? error.ErrorMessage.Split("||")[1]
                                     : error.ErrorMessage
                             }).ToList();
        var titel = "Een of meerdere parameters zijn niet correct.";
        var code = "paramsValidation";
        var foutbericht = new Generated.BadRequestFoutbericht
        {
            Instance = new Uri(context.HttpContext.Request.Path, UriKind.Relative),
            Status = StatusCodes.Status400BadRequest,
            Title = titel,
            Type = new Uri(StatusCodeIdentifiers.BadRequestIdentifier),
            Code = code,
            InvalidParams = invalidParams,
            Detail = $"De foutieve parameter(s) zijn: {string.Join(", ", invalidParams.Select(x => x.Name))}."
        };

        var requestBody = context.HttpContext.Request.ReadBodyAsync().Result;

        var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<Program>>();
        logger.LogWarning("Bad request. request body: {requestBody} response body: {@responseBody}", requestBody.Sanitize(), foutbericht);

        return new BadRequestObjectResult(foutbericht)
        {
            ContentTypes = { ContentTypes.ProblemJson }
        };
    }
}
