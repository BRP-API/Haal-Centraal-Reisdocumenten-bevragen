using FluentValidation;
using Reisdocument.Validatie.Interfaces;

namespace Reisdocument.Validatie.Validators;

public class RaadpleegMetReisdocumentnummerQueryValidator : AbstractValidator<IRaadpleegMetReisdocumentnummerQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string ReisdocumentnummerPattern = @"^[A-Z0-9]{9}$";
    const string ReisdocumentnummerPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {ReisdocumentnummerPattern}.";
    const string GemeenteVanInschrijvingPattern = @"^[0-9]{4}$";
    const string GemeenteVanInschrijvingPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GemeenteVanInschrijvingPattern}.";

    public RaadpleegMetReisdocumentnummerQueryValidator()
    {
        RuleFor(x => x.Reisdocumentnummer)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Must(x => x.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
            .Must(x => x.Count <= 1).WithMessage(string.Format(MaxItemsErrorMessage, 1));

        RuleForEach(x => x.Reisdocumentnummer)
            .Matches(ReisdocumentnummerPattern).WithMessage(ReisdocumentnummerPatternErrorMessage);

        RuleFor(x => x.GemeenteVanInschrijving)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(GemeenteVanInschrijvingPattern).WithMessage(GemeenteVanInschrijvingPatternErrorMessage);
    }
}
