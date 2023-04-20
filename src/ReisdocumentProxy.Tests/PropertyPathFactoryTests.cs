using ReisdocumentProxy.Helpers;

namespace ReisdocumentProxy.Tests;

public class PropertyPathFactoryTests
{
    List<string> actual;

    public PropertyPathFactoryTests()
    {
        actual = typeof(HaalCentraal.ReisdocumentProxy.Generated.Reisdocument).GetPropertyPaths("HaalCentraal");
    }

    [InlineData("reisdocumentnummer")]
    [InlineData("soort")]
    [InlineData("datumEindeGeldigheid")]
    [InlineData("inhoudingOfVermissing")]
    [InlineData("houder")]
    [InlineData("inOnderzoek")]
    [Theory]
    public void BepaalPropertyPathVoorReisdocumentProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("inOnderzoek.reisdocumentnummer")]
    [InlineData("inOnderzoek.soort")]
    [InlineData("inOnderzoek.datumEindeGeldigheid")]
    [InlineData("inOnderzoek.datumIngangOnderzoek")]
    [Theory]
    public void BepaalPropertyPathVoorReisdocumentInOnderzoekProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("soort.code")]
    [InlineData("soort.omschrijving")]
    [Theory]
    public void BepaalPropertyPathVoorWaardetabelProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("inhoudingOfVermissing.aanduiding")]
    [InlineData("inhoudingOfVermissing.aanduiding.code")]
    [InlineData("inhoudingOfVermissing.aanduiding.omschrijving")]
    [InlineData("inhoudingOfVermissing.datum")]
    [InlineData("inhoudingOfVermissing.inOnderzoek")]
    [Theory]
    public void BepaalPropertyPathVoorInhoudingOfVermissingProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("inhoudingOfVermissing.inOnderzoek.datum")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.aanduiding")]
    [InlineData("inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek")]
    [Theory]
    public void BepaalPropertyPathVoorInhoudingOfVermissingInOnderzoekProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("houder.burgerservicenummer")]
    [InlineData("houder.geheimhoudingPersoonsgegevens")]
    [InlineData("houder.opschortingBijhouding")]
    [InlineData("houder.inOnderzoek")]
    [Theory]
    public void BepaalPropertyPathVoorHouderProperties(string expected)
    {
        actual.Contains(expected).Should().BeTrue();
    }

    [InlineData("AdditionalProperties")]
    [InlineData("additionalProperties")]
    [InlineData("inhoudingOfVermissing.additionalProperties")]
    [InlineData("houder.additionalProperties")]
    [Theory]
    public void GetPropertyPathsVoorReisdocumentTypeBevatGeenPadenVanAdditionalPropertiesProperties(string expected)
    {
        actual.Contains(expected).Should().BeFalse();
    }
}