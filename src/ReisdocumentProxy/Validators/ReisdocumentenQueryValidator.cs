using HaalCentraal.ReisdocumentProxy.Generated;
using Reisdocument.Validatie;

namespace ReisdocumentProxy.Validators;

public static class ReisdocumentenQueryValidator
{
    public static ValidationResult Validate(this ReisdocumentenQuery reisdocumentenQuery)
    {
        var result = reisdocumentenQuery switch
        {
            RaadpleegMetReisdocumentnummer query => new RaadpleegMetReisdocumentnummerValidator().Validate(query),
            _ => null
        };

        return result != null ? ValidationResult.CreateFrom(result) : null;
    }
}
