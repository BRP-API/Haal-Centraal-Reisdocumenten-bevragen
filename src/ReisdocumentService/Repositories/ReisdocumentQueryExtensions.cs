using HaalCentraal.ReisdocumentService.Generated;

namespace HaalCentraal.ReisdocumentService.Repositories;

public static class ReisdocumentQueryExtensions
{
    public static Specification<GbaReisdocument> ToSpecification(this RaadpleegMetReisdocumentnummer query)
    {
        return new ReisdocumentnummerSpecification(query.Reisdocumentnummer)
            ;
    }

    public static Specification<GbaReisdocument> ToSpecification(this ZoekMetBurgerservicenummer query)
    {
        return new BurgerservicenummerSpecification(query.Burgerservicenummer)
            ;
    }
}
