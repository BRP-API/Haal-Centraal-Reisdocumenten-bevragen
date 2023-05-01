using HaalCentraal.ReisdocumentService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.ReisdocumentService.Repositories;

public class ReisdocumentnummerSpecification : Specification<GbaReisdocument>
{
    private readonly IEnumerable<string> _reisdocumentnummers;

    public ReisdocumentnummerSpecification(IEnumerable<string> reisdocumentnummers)
    {
        _reisdocumentnummers = reisdocumentnummers;
    }

    public override Expression<Func<GbaReisdocument, bool>> ToExpression()
    {
        return reisdocument => _reisdocumentnummers.Contains(reisdocument.Reisdocumentnummer);
    }
}
