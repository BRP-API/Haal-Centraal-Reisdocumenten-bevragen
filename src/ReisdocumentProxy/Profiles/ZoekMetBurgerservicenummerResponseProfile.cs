using AutoMapper;
using HC = HaalCentraal.ReisdocumentProxy.Generated;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;

namespace ReisdocumentProxy.Profiles;

public class ZoekMetBurgerservicenummerResponseProfile : Profile
{
    public ZoekMetBurgerservicenummerResponseProfile()
    {
        CreateMap<Gba.ZoekMetBurgerservicenummerResponse, HC.ZoekMetBurgerservicenummerResponse>();
    }
}
