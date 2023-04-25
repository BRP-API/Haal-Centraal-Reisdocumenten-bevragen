using AutoMapper;
using HC = HaalCentraal.ReisdocumentProxy.Generated;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;
using ReisdocumentProxy.Mappers;
using HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Profiles;

public class ReisdocumentProfile : Profile
{
    public ReisdocumentProfile()
    {
        CreateMap<Gba.GbaReisdocument, HC.Reisdocument>()
            .BeforeMap((src, dest) =>
            {
                if(src.InhoudingOfVermissing != null && src.InOnderzoek != null)
                {
                    src.InhoudingOfVermissing.InOnderzoek = src.InOnderzoek;
                }
            })
            .ForMember(dest => dest.DatumEindeGeldigheid, opt => opt.MapFrom(src => src.DatumEindeGeldigheid.Map()))
            .ForMember(dest => dest.Reisdocumentnummer, opt =>
            {
                opt.PreCondition(src => !string.IsNullOrEmpty(src.Reisdocumentnummer) && src.Reisdocumentnummer != ".........");
            })
            .ForMember(dest => dest.Soort, opt =>
            {
                opt.PreCondition(src => src.Soort?.Code != "..");
            })
            ;

        CreateMap<Gba.GbaInOnderzoek, ReisdocumentInOnderzoek?>().ConvertUsing<ReisdocumentInOnderzoekConverter>();
    }
}
