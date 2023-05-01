using FluentValidation;
using Reisdocument.Validatie.Interfaces;

namespace Reisdocument.Validatie.Validators;

public class AdditionalPropertiesValidator : AbstractValidator<IAdditionalProperties>
{
    public AdditionalPropertiesValidator()
    {
        RuleForEach(x => x.AdditionalProperties.Keys)
            .Null().WithMessage("{PropertyValue}||unknownParam||Parameter is niet verwacht.")
            ;
    }
}
