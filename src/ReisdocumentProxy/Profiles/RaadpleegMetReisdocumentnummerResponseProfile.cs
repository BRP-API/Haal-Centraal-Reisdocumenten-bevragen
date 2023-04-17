using AutoMapper;
using HC = HaalCentraal.ReisdocumentProxy.Generated;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;

namespace ReisdocumentProxy.Profiles;

public class RaadpleegMetReisdocumentnummerResponseProfile : Profile
{
    public RaadpleegMetReisdocumentnummerResponseProfile()
    {
        CreateMap<Gba.RaadpleegMetReisdocumentnummerResponse, HC.RaadpleegMetReisdocumentnummerResponse>();
    }
}
