using AutoMapper;
using HaalCentraal.ReisdocumentProxy.Generated;
using HaalCentraal.ReisdocumentProxy.Generated.Gba;
using ReisdocumentProxy.Mappers;

namespace ReisdocumentProxy.Profiles;

public class ReisdocumenthouderInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, ReisdocumenthouderInOnderzoek?>
{
    public ReisdocumenthouderInOnderzoek? Convert(GbaInOnderzoek source, ReisdocumenthouderInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "010000" or
            "010100" or
            "010120" => new ReisdocumenthouderInOnderzoek
            {
                Burgerservicenummer = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null
        };
    }
}