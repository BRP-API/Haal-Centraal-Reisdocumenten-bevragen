using HaalCentraal.ReisdocumentService.Generated;

namespace HaalCentraal.ReisdocumentService.Repositories;

public static class ReisdocumentQueryExtensions
{
    public static Specification<GbaReisdocument> ToSpecification(this RaadpleegMetReisdocumentnummer query)
    {
        return new ReisdocumentnummerSpecification(query.Reisdocumentnummer)
            .And(new GemeenteVanInschrijvingSpecification(query.GemeenteVanInschrijving!))
            ;
    }

    public static Specification<GbaReisdocument> ToSpecification(this ZoekMetBurgerservicenummer query)
    {
        return new BurgerservicenummerSpecification(query.Burgerservicenummer)
            .And(new GemeenteVanInschrijvingSpecification(query.GemeenteVanInschrijving!))
            ;
    }
}
