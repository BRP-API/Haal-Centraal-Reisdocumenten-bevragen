using FluentValidation.TestHelper;
using Moq;
using Reisdocument.Validatie.Interfaces;
using Reisdocument.Validatie.Validators;

namespace Reisdocument.Validatie.Tests;

public class AdditionalPropertiesValidatorTests
{
    readonly AdditionalPropertiesValidator sut;
    readonly Mock<IAdditionalProperties> input;

    public AdditionalPropertiesValidatorTests()
    {
        sut = new();
        input = new();
    }

    [Fact]
    public void AdditionalPropertiesMoetLeegZijn()
    {
        input.Setup(i => i.AdditionalProperties).Returns(new Dictionary<string, object> { { "key1", "value" }, { "key2", "value" } });

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.AdditionalProperties.Keys)
            .WithErrorMessage("key1||unknownParam||Parameter is niet verwacht.");
        result.ShouldHaveValidationErrorFor(m => m.AdditionalProperties.Keys)
            .WithErrorMessage("key2||unknownParam||Parameter is niet verwacht.");
    }
}
