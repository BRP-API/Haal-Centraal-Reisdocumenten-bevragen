using AutoMapper;
using HaalCentraal.ReisdocumentProxy.Generated;
using HaalCentraal.ReisdocumentProxy.Generated.Gba;
using ReisdocumentProxy.Mappers;

namespace ReisdocumentProxy.Profiles;

public class ReisdocumentInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, ReisdocumentInOnderzoek?>
{
    public ReisdocumentInOnderzoek? Convert(GbaInOnderzoek source, ReisdocumentInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "120000" or
            "123500" => new ReisdocumentInOnderzoek
            {
                DatumEindeGeldigheid = true,
                Reisdocumentnummer = true,
                Soort = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "123510" => new ReisdocumentInOnderzoek
            {
                Soort = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "123520" => new ReisdocumentInOnderzoek
            {
                Reisdocumentnummer= true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "123550" => new ReisdocumentInOnderzoek
            {
                DatumEindeGeldigheid = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null
        };
    }
}