using FluentValidation.TestHelper;
using Moq;
using Reisdocument.Validatie.Interfaces;
using Reisdocument.Validatie.Validators;

namespace Reisdocument.Validatie.Tests;

public class ReisdocumentenQueryValidatorTests
{
    readonly ReisdocumentenQueryValidator sut;
    readonly Mock<IReisdocumentenQuery> input;

    public ReisdocumentenQueryValidatorTests()
    {
        sut = new();
        input = new();
    }

    [Fact]
    public void GemeenteVanInschrijvingMagNietNullZijn()
    {
        string? gemeenteVanInschrijving = null;
        input.Setup(i => i.GemeenteVanInschrijving).Returns(gemeenteVanInschrijving!);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.GemeenteVanInschrijving)
            .WithErrorMessage("required||Parameter is verplicht.");
    }

    [InlineData("")]
    [InlineData("0")]
    [InlineData("01234")]
    [InlineData("O518")]
    [InlineData("05l8")]
    [Theory]
    public void GemeenteVanInschrijvingVoldoetNietAanPattern(string gemeenteVanInschrijving)
    {
        input.Setup(i => i.GemeenteVanInschrijving).Returns(gemeenteVanInschrijving!);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.GemeenteVanInschrijving)
            .WithErrorMessage("pattern||Waarde voldoet niet aan patroon ^[0-9]{4}$.");
    }

    [InlineData("houder.geheimhoudingPersoonsgegevens")]
    [Theory]
    public void FieldsMagGeenAutomatischGeleverdeVeldnamenBevatten(string field)
    {
        input.Setup(i => i.Fields).Returns(new List<string> { field });

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("fields||Parameter bevat een niet toegestane veldnaam.");
    }
}
