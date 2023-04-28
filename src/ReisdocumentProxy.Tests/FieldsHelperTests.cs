using ReisdocumentProxy.Helpers;

namespace ReisdocumentProxy.Tests;

public class FieldsHelperTests
{
    [Fact]
    public void AddAlwaysReturnedFieldsVoegtAltijdGeleverdePropertypadenToe()
    {
        List<string> fields = new() { "reisdocumentnummer" };

        fields.AddAlwaysReturnedFields().Should().BeEquivalentTo(new List<string>
        {
            "reisdocumentnummer",
            "houder.geheimhoudingPersoonsgegevens",
            "houder.opschortingBijhouding"
        });
    }

    [InlineData(new[] { "datumEindeGeldigheid" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.type" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.datum" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.langFormaat" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.jaar" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.maand" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "datumEindeGeldigheid.onbekend" }, new[] { "datumEindeGeldigheid" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum" }, new[] { "inhoudingOfVermissing.datum" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum.datum" }, new[] { "inhoudingOfVermissing.datum" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum.langFormaat" }, new[] { "inhoudingOfVermissing.datum" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum.jaar" }, new[] { "inhoudingOfVermissing.datum" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum.maand" }, new[] { "inhoudingOfVermissing.datum" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum.onbekend" }, new[] { "inhoudingOfVermissing.datum" })]
    [Theory]
    public void PadenVanDatumPropertiesWordenVervangenDoorDatumPath(IEnumerable<string> input, IEnumerable<string> expected)
    {
        input.ReplaceDatumWaardetabelPropertyFieldPaths().Should().BeEquivalentTo(expected);
    }

    [InlineData(new[] { "soort" }, new[] { "soort" })]
    [InlineData(new[] { "soort.code" }, new[] { "soort" })]
    [InlineData(new[] { "soort.omschrijving" }, new[] { "soort" })]
    [InlineData(new[] { "inhoudingOfVermissing.aanduiding" }, new[] { "inhoudingOfVermissing.aanduiding" })]
    [InlineData(new[] { "inhoudingOfVermissing.aanduiding.code" }, new[] { "inhoudingOfVermissing.aanduiding" })]
    [InlineData(new[] { "inhoudingOfVermissing.aanduiding.omschrijving" }, new[] { "inhoudingOfVermissing.aanduiding" })]
    [Theory]
    public void PadenVanWaardetabelPropertiesWordenVervangenDoorWaardetabelPath(IEnumerable<string> input, IEnumerable<string> expected)
    {
        input.ReplaceDatumWaardetabelPropertyFieldPaths().Should().BeEquivalentTo(expected);
    }

    [InlineData(new[] { "reisdocumentnummer" },
                new[] { "reisdocumentnummer", "inOnderzoek.reisdocumentnummer", "inOnderzoek.datumIngangOnderzoek" })]
    [InlineData(new[] { "inhoudingOfVermissing" },
                new[] { "inhoudingOfVermissing", "inhoudingOfVermissing.inOnderzoek" })]
    [InlineData(new[] { "inhoudingOfVermissing.datum" },
                new[] { "inhoudingOfVermissing.datum", "inhoudingOfVermissing.inOnderzoek.datum", "inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek" })]
    [InlineData(new[] { "houder" },
                new[] { "houder", "houder.inOnderzoek" })]
    [InlineData(new[] { "houder.burgerservicenummer" },
                new[] { "houder.burgerservicenummer", "houder.inOnderzoek.burgerservicenummer", "houder.inOnderzoek.datumIngangOnderzoek" })]
    [Theory]
    public void PadenVanBijbehorendInOnderzoekPropertiesWordtToegevoegdVoorGevraagdeFields(IEnumerable<string> input, IEnumerable<string> expected)
    {
        input.AddInOnderzoekPropertyPaths().Should().BeEquivalentTo(expected);
    }
}
