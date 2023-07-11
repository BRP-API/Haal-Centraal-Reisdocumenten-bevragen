using FluentValidation;
using Reisdocument.Validatie.Interfaces;

namespace Reisdocument.Validatie.Validators;

public class ReisdocumentenQueryValidator : AbstractValidator<IReisdocumentenQuery>
{
    readonly List<string> BestaandeVeldpaden = new()
    {
        "reisdocumentnummer",
        "soort",
        "soort.code",
        "soort.omschrijving",
        "datumEindeGeldigheid",
        "datumEindeGeldigheid.type",
        "datumEindeGeldigheid.datum",
        "datumEindeGeldigheid.langFormaat",
        "datumEindeGeldigheid.onbekend",
        "datumEindeGeldigheid.jaar",
        "datumEindeGeldigheid.maand",
        "inhoudingOfVermissing",
        "inhoudingOfVermissing.datum",
        "inhoudingOfVermissing.datum.type",
        "inhoudingOfVermissing.datum.datum",
        "inhoudingOfVermissing.datum.langFormaat",
        "inhoudingOfVermissing.datum.onbekend",
        "inhoudingOfVermissing.datum.jaar",
        "inhoudingOfVermissing.datum.maand",
        "inhoudingOfVermissing.aanduiding",
        "inhoudingOfVermissing.aanduiding.code",
        "inhoudingOfVermissing.aanduiding.omschrijving",
        "inhoudingOfVermissing.inOnderzoek",
        "inhoudingOfVermissing.inOnderzoek.datum",
        "inhoudingOfVermissing.inOnderzoek.aanduiding",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.type",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.datum",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.langFormaat",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.onbekend",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.jaar",
        "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.maand",
        "houder",
        "houder.geheimhoudingPersoonsgegevens",
        "houder.opschortingBijhouding",
        "houder.opschortingBijhouding.datum",
        "houder.opschortingBijhouding.datum.type",
        "houder.opschortingBijhouding.datum.datum",
        "houder.opschortingBijhouding.datum.langFormaat",
        "houder.opschortingBijhouding.datum.onbekend",
        "houder.opschortingBijhouding.datum.jaar",
        "houder.opschortingBijhouding.datum.maand",
        "houder.opschortingBijhouding.reden",
        "houder.opschortingBijhouding.reden.code",
        "houder.opschortingBijhouding.reden.omschrijving",
        "houder.inOnderzoek",
        "houder.inOnderzoek.burgerservicenummer",
        "houder.inOnderzoek.datumIngangOnderzoek",
        "houder.inOnderzoek.datumIngangOnderzoek.type",
        "houder.inOnderzoek.datumIngangOnderzoek.datum",
        "houder.inOnderzoek.datumIngangOnderzoek.langFormaat",
        "houder.inOnderzoek.datumIngangOnderzoek.onbekend",
        "houder.inOnderzoek.datumIngangOnderzoek.jaar",
        "houder.inOnderzoek.datumIngangOnderzoek.maand",
        "houder.burgerservicenummer",
        "inOnderzoek",
        "inOnderzoek.reisdocumentnummer",
        "inOnderzoek.soort",
        "inOnderzoek.datumEindeGeldigheid",
        "inOnderzoek.datumIngangOnderzoek",
        "inOnderzoek.datumIngangOnderzoek.type",
        "inOnderzoek.datumIngangOnderzoek.datum",
        "inOnderzoek.datumIngangOnderzoek.langFormaat",
        "inOnderzoek.datumIngangOnderzoek.onbekend",
        "inOnderzoek.datumIngangOnderzoek.jaar",
        "inOnderzoek.datumIngangOnderzoek.maand"
    };

    readonly List<string> PadAutomatischGeleverdeVelden = new()
    {
        "inhoudingOfVermissing.inOnderzoek",
        "houder.geheimhoudingPersoonsgegevens",
        "houder.inOnderzoek",
        "houder.opschortingBijhouding",
        "inOnderzoek"
    };

    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string MinItemsErrorMessage = "minItems||Array bevat minder dan {0} items.";
    const string MaxItemsErrorMessage = "maxItems||Array bevat meer dan {0} items.";
    const string FieldPattern = @"^[a-zA-Z0-9\._]{1,200}$";
    const string FieldPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {FieldPattern}.";
    const string FieldExistErrorMessage = "fields||Parameter bevat een niet bestaande veldnaam.";
    const string FieldAllowedErrorMessage = "fields||Parameter bevat een niet toegestane veldnaam.";

    public ReisdocumentenQueryValidator()
    {
        RuleFor(x => x.Fields)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Must(x => x!.Count > 0).WithMessage(string.Format(MinItemsErrorMessage, 1))
            .Must(x => x!.Count <= 25).WithMessage(string.Format(MaxItemsErrorMessage, 25));

        RuleForEach(x => x.Fields)
            .Cascade(CascadeMode.Stop)
            .Matches(FieldPattern).WithMessage(FieldPatternErrorMessage)
            .Must(x => BestaandeVeldpaden.Contains(x)).WithMessage(FieldExistErrorMessage)
            .Must(x => !PadAutomatischGeleverdeVelden.Any(padAutomatischGeleverdVeld => x.StartsWith(padAutomatischGeleverdVeld))).WithMessage(FieldAllowedErrorMessage);
    }
}
