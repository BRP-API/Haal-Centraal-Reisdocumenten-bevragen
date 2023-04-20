using AutoMapper;
using HaalCentraal.ReisdocumentProxy.Generated;
using HaalCentraal.ReisdocumentProxy.Generated.Gba;
using ReisdocumentProxy.Mappers;

namespace ReisdocumentProxy.Profiles;

public class InhoudingOfVermissingInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, InhoudingOfVermissingInOnderzoek?>
{
    public InhoudingOfVermissingInOnderzoek? Convert(GbaInOnderzoek source, InhoudingOfVermissingInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "120000" or
            "123500" => new InhoudingOfVermissingInOnderzoek
            {
                Aanduiding = true,
                Datum = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "123560" => new InhoudingOfVermissingInOnderzoek
            {
                Datum = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            "123570" => new InhoudingOfVermissingInOnderzoek
            {
                Aanduiding = true,
                DatumIngangOnderzoek = source?.DatumIngangOnderzoek?.Map()
            },
            _ => null
        };
    }
}
