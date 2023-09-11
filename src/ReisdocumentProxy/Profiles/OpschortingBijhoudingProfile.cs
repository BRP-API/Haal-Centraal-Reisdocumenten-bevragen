using AutoMapper;
using ReisdocumentProxy.Mappers;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;
using HC = HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Profiles;

public class OpschortingBijhoudingProfile : Profile
{
    public OpschortingBijhoudingProfile()
    {
        CreateMap<Gba.GbaOpschortingBijhouding, HC.OpschortingBijhouding>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()))
            ;
    }
}
