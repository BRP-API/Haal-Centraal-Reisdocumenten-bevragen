using FluentValidation;
using HaalCentraal.ReisdocumentProxy.Generated;

namespace ReisdocumentProxy.Validators;

public class ZoekMetBurgerservicenummerValidator : AbstractValidator<ZoekMetBurgerservicenummer>
{
    public ZoekMetBurgerservicenummerValidator()
    {
        Include(new Reisdocument.Validatie.Validators.ZoekMetBurgerservicenummerQueryValidator());
        Include(new Reisdocument.Validatie.Validators.ReisdocumentenQueryValidator());
    }
}
