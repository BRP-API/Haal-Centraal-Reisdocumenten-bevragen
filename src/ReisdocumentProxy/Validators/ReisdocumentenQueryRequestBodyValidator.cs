using FluentValidation;
using Newtonsoft.Json.Linq;

namespace ReisdocumentProxy.Validators;

public class ReisdocumentenQueryRequestBodyValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "type||required||Parameter is verplicht.";
    const string TypePattern = @"^ZoekMetBurgerservicenummer|RaadpleegMetReisdocumentnummer$";
    const string TypePatternErrorMessage = "type||value||Waarde is geen geldig zoek type.";

    public ReisdocumentenQueryRequestBodyValidator()
    {
        RuleFor(x => x.Value<string>("type"))
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(TypePattern).WithMessage(TypePatternErrorMessage);
    }
}
