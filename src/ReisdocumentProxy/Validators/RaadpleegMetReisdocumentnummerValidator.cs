using FluentValidation;
using HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Validators;

public class RaadpleegMetReisdocumentnummerValidator : AbstractValidator<RaadpleegMetReisdocumentnummer>
{
    public RaadpleegMetReisdocumentnummerValidator()
    {
        Include(new Reisdocument.Validatie.Validators.RaadpleegMetReisdocumentnummerQueryValidator());
        Include(new Reisdocument.Validatie.Validators.ReisdocumentenQueryValidator());
        Include(new Reisdocument.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
