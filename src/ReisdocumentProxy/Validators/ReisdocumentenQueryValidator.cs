using HaalCentraal.ReisdocumentProxy.Generated;
using Newtonsoft.Json.Linq;
using Reisdocument.Validatie;

namespace ReisdocumentProxy.Validators;

public static class ReisdocumentenQueryValidator
{
    public static ValidationResult Validate(this ReisdocumentenQuery? reisdocumentenQuery, string requestBody)
    {
        var result = reisdocumentenQuery switch
        {
            RaadpleegMetReisdocumentnummer query => new RaadpleegMetReisdocumentnummerValidator().Validate(query),
            ZoekMetBurgerservicenummer query => new ZoekMetBurgerservicenummerValidator().Validate(query),
            _ => new ReisdocumentenQueryRequestBodyValidator().Validate(JObject.Parse(requestBody)),
        };

        return ValidationResult.CreateFrom(result);
    }
}
