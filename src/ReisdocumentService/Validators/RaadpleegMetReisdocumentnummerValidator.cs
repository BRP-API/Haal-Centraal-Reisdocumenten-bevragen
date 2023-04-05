using FluentValidation;
using HaalCentraal.ReisdocumentService.Generated;

namespace HaalCentraal.ReisdocumentService.Validators;

public class RaadpleegMetReisdocumentnummerValidator : AbstractValidator<RaadpleegMetReisdocumentnummer>
{
    public RaadpleegMetReisdocumentnummerValidator()
    {
        Include(new Reisdocument.Validatie.Validators.RaadpleegMetReisdocumentnummerQueryValidator());
    }
}
