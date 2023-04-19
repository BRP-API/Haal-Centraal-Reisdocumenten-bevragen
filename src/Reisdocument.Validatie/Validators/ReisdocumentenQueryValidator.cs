using FluentValidation;
using Reisdocument.Validatie.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Reisdocument.Validatie.Validators
{
    public class ReisdocumentenQueryValidator : AbstractValidator<IReisdocumentenQuery>
    {
        const string RequiredErrorMessage = "required||Parameter is verplicht.";
        const string GemeenteVanInschrijvingPattern = @"^[0-9]{4}$";
        const string GemeenteVanInschrijvingPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {GemeenteVanInschrijvingPattern}.";
        const string FieldAllowedErrorMessage = "fields||Parameter bevat een niet toegestane veldnaam.";

        public ReisdocumentenQueryValidator()
        {
            RuleFor(x => x.GemeenteVanInschrijving)
                .Cascade(CascadeMode.Stop)
                .NotNull().WithMessage(RequiredErrorMessage)
                .Matches(GemeenteVanInschrijvingPattern).WithMessage(GemeenteVanInschrijvingPatternErrorMessage);

            RuleForEach(x => x.Fields)
                .Cascade(CascadeMode.Stop)
                .Must(x => !x.Contains("houder.geheimhoudingPersoonsgegevens")).WithMessage(FieldAllowedErrorMessage);
        }
    }
}
