using Brp.Shared.Infrastructure.Json;
using HaalCentraal.ReisdocumentProxy.Generated;
using ReisdocumentProxy.Helpers;

namespace ReisdocumentProxy.Tests;

public class FilterFieldsHelperTests
{
    List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument> input;

    public FilterFieldsHelperTests()
    {
        input = new List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument>
        {
            new HaalCentraal.ReisdocumentProxy.Generated.Reisdocument
            {
                DatumEindeGeldigheid = new VolledigeDatum
                {
                    Datum = new DateTime(2024, 05, 06)
                },
                Reisdocumentnummer = "NE3663258",
                Soort = new Waardetabel
                {
                    Code = "PN",
                    Omschrijving = "Nationaal paspoort"
                },
                Houder = new Reisdocumenthouder
                {
                    Burgerservicenummer = "000000152",
                    GeheimhoudingPersoonsgegevens = true,
                    InOnderzoek = new ReisdocumenthouderInOnderzoek
                    {
                        Burgerservicenummer = true,
                        DatumIngangOnderzoek = new VolledigeDatum
                        {
                            Datum = new DateTime(2023, 04, 01),
                            LangFormaat = "1 april 2023"
                        }
                    }
                },
                InhoudingOfVermissing = new InhoudingOfVermissing
                {
                    Aanduiding = new Waardetabel
                    {
                        Code = "I",
                        Omschrijving = "ingehouden of ingeleverd"
                    },
                    Datum = new VolledigeDatum
                    {
                        Datum = new DateTime(2023, 04, 05)
                    }
                }
            }
        };
    }

    [Fact]
    public void FilterReisdocumentnummer()
    {
        input.FilterList(new[] { "reisdocumentnummer" })!.ToJson().Should().Be(
            new List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument>
            {
                new HaalCentraal.ReisdocumentProxy.Generated.Reisdocument
                {
                    Reisdocumentnummer = "NE3663258"
                }
            }.ToJson());
    }

    [Fact]
    public void FilterSoort()
    {
        input.FilterList(new[] { "soort" })!.ToJson().Should().Be(
            new List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument>
            {
                new HaalCentraal.ReisdocumentProxy.Generated.Reisdocument
                {
                    Soort = new Waardetabel
                    {
                        Code = "PN",
                        Omschrijving = "Nationaal paspoort"
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterHouder()
    {
        input.FilterList(new[] { "houder" })!.ToJson().Should().Be(
            new List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument>
            {
                new HaalCentraal.ReisdocumentProxy.Generated.Reisdocument
                {
                    Houder = new Reisdocumenthouder
                    {
                        Burgerservicenummer = "000000152",
                        GeheimhoudingPersoonsgegevens = true,
                        InOnderzoek = new ReisdocumenthouderInOnderzoek
                        {
                            Burgerservicenummer = true,
                            DatumIngangOnderzoek = new VolledigeDatum
                            {
                                Datum = new DateTime(2023, 04, 01),
                                LangFormaat = "1 april 2023"
                            }
                        }
                    }
                }
            }.ToJson());
    }

    [Fact]
    public void FilterHouderBurgerservicenummer()
    {
        input.FilterList(new[] { "houder.burgerservicenummer" })!.ToJson().Should().Be(
            new List<HaalCentraal.ReisdocumentProxy.Generated.Reisdocument>
            {
                new HaalCentraal.ReisdocumentProxy.Generated.Reisdocument
                {
                    Houder = new Reisdocumenthouder
                    {
                        Burgerservicenummer = "000000152"
                    }
                }
            }.ToJson());
    }
}
