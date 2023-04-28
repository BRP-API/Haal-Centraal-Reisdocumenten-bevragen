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

    [Fact]
    public void FieldsMagNietNullZijn()
    {
        List<string>? fields = null;
        input.Setup(i => i.Fields).Returns(fields);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("required||Parameter is verplicht.");
    }

    [Fact]
    public void FieldsMagNietLeegZijn()
    {
        List<string>? fields = new();
        input.Setup(i => i.Fields).Returns(fields);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("minItems||Array bevat minder dan 1 items.");
    }

    [Fact]
    public void FieldsMagNietMeerDan25ItemsBevatten()
    {
        List<string>? fields = new() { "field1", "field2", "field3", "field4", "field5", "field6", "field7", "field8", "field9", "field10", "field11", "field12", "field13", "field14", "field15", "field16", "field17", "field18", "field19", "field20", "field21", "field22", "field23", "field24", "field25", "field26" };
        input.Setup(i => i.Fields).Returns(fields);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("maxItems||Array bevat meer dan 25 items.");
    }

    [InlineData("")]
    [InlineData("re*sdocumentnummer")]
    [InlineData("houder burger service nummer")]
    [Theory]
    public void FieldBevatAlleenAlfanummeriekePuntEnLaagStreepjeKarakters(string veldPad)
    {
        List<string>? fields = new() { veldPad };
        input.Setup(i => i.Fields).Returns(fields);

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("pattern||Waarde voldoet niet aan patroon ^[a-zA-Z0-9\\._]{1,200}$.");
    }

    [InlineData("inhoudingOfVermissing.inOnderzoek")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datum")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.aanduiding")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.type")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.datum")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.langFormaat")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.onbekend")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.jaar")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.maand")]
    [InlineData("houder.geheimhoudingPersoonsgegevens")]
    [InlineData("houder.opschortingBijhouding")]
    [InlineData("houder.opschortingBijhouding.datum")]
    [InlineData("houder.opschortingBijhouding.datum.type")]
    [InlineData("houder.opschortingBijhouding.datum.datum")]
    [InlineData("houder.opschortingBijhouding.datum.langFormaat")]
    [InlineData("houder.opschortingBijhouding.datum.onbekend")]
    [InlineData("houder.opschortingBijhouding.datum.jaar")]
    [InlineData("houder.opschortingBijhouding.datum.maand")]
    [InlineData("houder.opschortingBijhouding.reden")]
    [InlineData("houder.opschortingBijhouding.reden.code")]
    [InlineData("houder.opschortingBijhouding.reden.omschrijving")]
    [InlineData("houder.inOnderzoek")]
    [InlineData("houder.inOnderzoek.burgerservicenummer")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.type")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.datum")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.langFormaat")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.onbekend")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.jaar")]
    [InlineData("houder.inOnderzoek.datumIngangOnderzoek.maand")]
    [InlineData("inOnderzoek")]
    [InlineData("inOnderzoek.reisdocumentnummer")]
    [InlineData("inOnderzoek.soort")]
    [InlineData("inOnderzoek.datumEindeGeldigheid")]
    [InlineData("inOnderzoek.datumIngangOnderzoek")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.type")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.datum")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.langFormaat")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.onbekend")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.jaar")]
    [InlineData("inOnderzoek.datumIngangOnderzoek.maand")]
    [Theory]
    public void FieldsMagGeenAutomatischGeleverdeVeldnamenBevatten(string field)
    {
        input.Setup(i => i.Fields).Returns(new List<string> { field });

        var result = sut.TestValidate(input.Object);

        result.ShouldHaveValidationErrorFor(m => m.Fields)
            .WithErrorMessage("fields||Parameter bevat een niet toegestane veldnaam.");
    }
}
