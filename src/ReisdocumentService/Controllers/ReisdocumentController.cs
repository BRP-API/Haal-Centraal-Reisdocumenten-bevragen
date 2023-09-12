using HaalCentraal.ReisdocumentService.Generated;
using HaalCentraal.ReisdocumentService.Repositories;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace HaalCentraal.ReisdocumentService.Controllers;

[ApiController]
public class ReisdocumentController : Generated.ControllerBase
{
    private readonly IDiagnosticContext _diagnosticContext;
    private readonly ReisdocumentRepository _repository;

    public ReisdocumentController(IDiagnosticContext diagnosticContext, ReisdocumentRepository repository)
    {
        _diagnosticContext = diagnosticContext;
        _repository = repository;
    }

    public override async Task<ActionResult<ReisdocumentenQueryResponse>> Reisdocumenten([FromBody] ReisdocumentenQuery body)
    {
        _diagnosticContext.Set("request.body", body, true);
        _diagnosticContext.Set("request.headers", HttpContext.Request.Headers);

        var retval = body switch
        {
            RaadpleegMetReisdocumentnummer q => await Handle(q),
            ZoekMetBurgerservicenummer q => await Handle(q),
            _ => new ReisdocumentenQueryResponse()
        };

        _diagnosticContext.Set("response.body", retval, true);

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
