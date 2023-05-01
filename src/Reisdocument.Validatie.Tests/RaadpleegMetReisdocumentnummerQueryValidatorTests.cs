using FluentValidation.TestHelper;
using Moq;
using Reisdocument.Validatie.Interfaces;
using Reisdocument.Validatie.Validators;

namespace Reisdocument.Validatie.Tests;

public class RaadpleegMetReisdocumentnummerQueryValidatorTests
{
    readonly RaadpleegMetReisdocumentnummerQueryValidator sut;
    readonly Mock<IRaadpleegMetReisdocumentnummerQuery> input;

    public RaadpleegMetReisdocumentnummerQueryValidatorTests()
    {
        sut = new();
        input = new();
    }

    [Fact]
    public void ReisdocumentnummerParameterMagNietNullZijn()
    {
        List<string>? list = null;
        input.Setup(i => i.Reisdocumentnummer).Returns(list!);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Reisdocumentnummer)
            .WithErrorMessage("required||Parameter is verplicht.");
    }

    [Fact]
    public void ReisdocumentnummerParameterMagNietLeegZijn()
    {
        input.Setup(m => m.Reisdocumentnummer).Returns(new List<string>());

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Reisdocumentnummer)
            .WithErrorMessage("minItems||Array bevat minder dan 1 items.");
    }

    [Fact]
    public void ReisdocumentnummerParameterMagNietMeerDan1ItemBevatten()
    {
        input.Setup(m => m.Reisdocumentnummer).Returns(new List<string> { "1", "2"});

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Reisdocumentnummer)
            .WithErrorMessage("maxItems||Array bevat meer dan 1 items.");
    }

    [InlineData("12345678")]
    [InlineData("1234567890")]
    [InlineData("a23456789")]
    [InlineData("<script>alert('Hello')</script>")]
    [Theory]
    public void ReisdocumentnummerVoldoetNietAanPattern(string reisdocumentnummer)
    {
        input.Setup(m => m.Reisdocumentnummer).Returns(new List<string> { reisdocumentnummer });

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Reisdocumentnummer)
            .WithErrorMessage("pattern||Waarde voldoet niet aan patroon ^[A-Z0-9]{9}$.");
    }
}