using FluentValidation.TestHelper;
using Moq;
using Reisdocument.Validatie.Interfaces;
using Reisdocument.Validatie.Validators;

namespace Reisdocument.Validatie.Tests;

public class ZoekMetBurgerservicenummerQueryValidatorTests
{
    readonly ZoekMetBurgerservicenummerQueryValidator sut;
    readonly Mock<IZoekMetBurgerservicenummerQuery> input;

    public ZoekMetBurgerservicenummerQueryValidatorTests()
    {
        sut = new();
        input = new();
    }

    [Fact]
    public void BurgerservicenummerParameterMagNietNullZijn()
    {
        string? bsn = null;
        input.Setup(i => i.Burgerservicenummer).Returns(bsn!);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Burgerservicenummer)
            .WithErrorMessage("required||Parameter is verplicht.");
    }

    [InlineData("")]
    [InlineData("12345678")]
    [InlineData("1234567890")]
    [InlineData("12345678X")]
    [InlineData("<script>alert('Hello')</script>")]
    [Theory]
    public void BurgerservicenummerVoldoetNietAanPattern(string bsn)
    {
        input.Setup(i => i.Burgerservicenummer).Returns(bsn!);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Burgerservicenummer)
            .WithErrorMessage("pattern||Waarde voldoet niet aan patroon ^[0-9]{9}$.");
    }
}
