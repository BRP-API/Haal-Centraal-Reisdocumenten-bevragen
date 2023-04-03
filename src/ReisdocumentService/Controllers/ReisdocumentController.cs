using HaalCentraal.ReisdocumentService.Generated;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.ReisdocumentService.Controllers;

[ApiController]
public class ReisdocumentController : Generated.ControllerBase
{
    private readonly ILogger<ReisdocumentController> _logger;

    public ReisdocumentController(ILogger<ReisdocumentController> logger)
    {
        _logger = logger;
    }

    public override async Task<ActionResult<ReisdocumentenQueryResponse>> Reisdocumenten([FromBody] ReisdocumentenQuery body)
    {
        _logger.LogDebug("Request headers: {@headers}", HttpContext.Request.Headers);
        _logger.LogDebug("Request body: {@body}", body);

        var retval = body switch
        {
            _ => new ReisdocumentenQueryResponse()
        };

        _logger.LogDebug("Response body: {@responsebody}", retval);

        return Ok(retval);
    }
}
