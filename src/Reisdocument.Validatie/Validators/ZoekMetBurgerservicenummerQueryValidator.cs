using FluentValidation;
using Reisdocument.Validatie.Interfaces;

namespace Reisdocument.Validatie.Validators;

public class ZoekMetBurgerservicenummerQueryValidator : AbstractValidator<IZoekMetBurgerservicenummerQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string BsnPattern = @"^[0-9]{9}$";
    const string BsnPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {BsnPattern}.";

    public ZoekMetBurgerservicenummerQueryValidator()
    {
        RuleFor(x => x.Burgerservicenummer)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(BsnPattern).WithMessage(BsnPatternErrorMessage)
            ;
    }
}
