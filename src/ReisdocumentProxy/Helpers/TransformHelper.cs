using AutoMapper;
using HaalCentraal.ReisdocumentProxy.Generated;
using Gba = HaalCentraal.ReisdocumentProxy.Generated.Gba;
using Newtonsoft.Json;
using Reisdocument.Infrastructure.Json;

namespace ReisdocumentProxy.Helpers;

public static class TransformHelper
{
    public static string Transform(this string payload, IMapper mapper, List<string> fields)
    {
        var response = JsonConvert.DeserializeObject<Gba.ReisdocumentenQueryResponse>(payload);

        var fieldsToReturn = fields.AddExtraReisdocumentFields();

        ReisdocumentenQueryResponse retval = response switch
        {
            Gba.RaadpleegMetReisdocumentnummerResponse r => mapper.Map<RaadpleegMetReisdocumentnummerResponse>(r).Filter(fieldsToReturn),
            Gba.ZoekMetBurgerservicenummerResponse r => mapper.Map<ZoekMetBurgerservicenummerResponse>(r).Filter(fieldsToReturn),
            _ => throw new NotSupportedException(),
        };

        return retval.ToJsonWithoutNullAndDefaultValues();
    }

    private static RaadpleegMetReisdocumentnummerResponse Filter(this RaadpleegMetReisdocumentnummerResponse src, IEnumerable<string> fields)
    {
        return new RaadpleegMetReisdocumentnummerResponse
        {
            Reisdocumenten = src.Reisdocumenten.FilterList(fields)?.ToList()
        };
    }

    private static ZoekMetBurgerservicenummerResponse Filter(this ZoekMetBurgerservicenummerResponse src, IEnumerable<string> fields)
    {
        return new ZoekMetBurgerservicenummerResponse
        {
            Reisdocumenten = src.Reisdocumenten.FilterList(fields)?.ToList()
        };
    }
}
