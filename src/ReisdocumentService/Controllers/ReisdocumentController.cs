using HaalCentraal.ReisdocumentService.Generated;
using HaalCentraal.ReisdocumentService.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.ReisdocumentService.Controllers;

[ApiController]
public class ReisdocumentController : Generated.ControllerBase
{
    private readonly ILogger<ReisdocumentController> _logger;
    private readonly ReisdocumentRepository _repository;

    public ReisdocumentController(ILogger<ReisdocumentController> logger, ReisdocumentRepository repository)
    {
        _logger = logger;
        _repository = repository;
    }

    public override async Task<ActionResult<ReisdocumentenQueryResponse>> Reisdocumenten([FromBody] ReisdocumentenQuery body)
    {
        _logger.LogDebug("Request headers: {@headers}", HttpContext.Request.Headers);
        _logger.LogDebug("Request body: {@body}", body);

        var retval = body switch
        {
            RaadpleegMetReisdocumentnummer q => await Handle(q),
            ZoekMetBurgerservicenummer q => await Handle(q),
            _ => new ReisdocumentenQueryResponse()
        };

        _logger.LogDebug("Response body: {@responsebody}", retval);

        return Ok(retval);
    }

    private async Task<ReisdocumentenQueryResponse> Handle(RaadpleegMetReisdocumentnummer query)
    {
        var retval = await _repository.Zoek<RaadpleegMetReisdocumentnummer>(query);

        return retval;
    }

    private async Task<ReisdocumentenQueryResponse> Handle(ZoekMetBurgerservicenummer query)
    {
        var retval = await _repository.Zoek<ZoekMetBurgerservicenummer>(query);

        return retval;
    }
}
