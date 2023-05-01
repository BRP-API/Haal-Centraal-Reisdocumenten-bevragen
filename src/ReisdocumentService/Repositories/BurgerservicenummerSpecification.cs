using HaalCentraal.ReisdocumentService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.ReisdocumentService.Repositories;

public class BurgerservicenummerSpecification : Specification<GbaReisdocument>
{
    private readonly string _bsn;

    public BurgerservicenummerSpecification(string bsn)
    {
        _bsn = bsn;
    }

    public override Expression<Func<GbaReisdocument, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                          persoon.Houder != null &&
                          !string.IsNullOrEmpty(persoon.Houder.Burgerservicenummer) &&
                          persoon.Houder.Burgerservicenummer == _bsn;
    }
}
