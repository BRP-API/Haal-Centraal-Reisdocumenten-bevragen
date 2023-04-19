using AutoMapper;
using HC = HaalCentraal.ReisdocumentProxy.Generated;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;
using HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Profiles;

public class ReisdocumenthouderProfile : Profile
{
    public ReisdocumenthouderProfile()
    {
        CreateMap<Gba.GbaReisdocumenthouder, HC.Reisdocumenthouder>();

        CreateMap<Gba.GbaInOnderzoek, ReisdocumenthouderInOnderzoek?>().ConvertUsing<ReisdocumenthouderInOnderzoekConverter>();
    }
}
