using HaalCentraal.ReisdocumentService.Generated;
using System.Linq.Expressions;

namespace HaalCentraal.ReisdocumentService.Repositories
{
    public class GemeenteVanInschrijvingSpecification : Specification<GbaReisdocument>
    {
        private readonly string _gemeenteVanInschrijving;

        public GemeenteVanInschrijvingSpecification(string gemeenteVanInschrijving)
        {
            _gemeenteVanInschrijving = gemeenteVanInschrijving;
        }

        public override Expression<Func<GbaReisdocument, bool>> ToExpression()
        {
            return reisdocument => 
                reisdocument != null &&
                reisdocument.Houder != null &&
                reisdocument.Houder.GemeenteVanInschrijving != null &&
                reisdocument.Houder.GemeenteVanInschrijving.Code == _gemeenteVanInschrijving;
        }
    }
}
