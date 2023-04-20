using AutoMapper;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;
using ReisdocumentProxy.Mappers;
using HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Profiles;

public class InhoudingOfVermissingProfile : Profile
{
    public InhoudingOfVermissingProfile()
    {
        CreateMap<Gba.GbaInhoudingOfVermissing, InhoudingOfVermissing>()
            .ForMember(dest => dest.Datum, opt => opt.MapFrom(src => src.Datum.Map()))
            ;

        CreateMap<Gba.GbaInOnderzoek, InhoudingOfVermissingInOnderzoek?>().ConvertUsing<InhoudingOfVermissingInOnderzoekConverter>();
    }
}
