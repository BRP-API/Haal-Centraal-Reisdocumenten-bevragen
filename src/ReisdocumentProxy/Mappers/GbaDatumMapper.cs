using HaalCentraal.ReisdocumentProxy.Generated;
using System.Globalization;
using System.Text.RegularExpressions;

namespace ReisdocumentProxy.Mappers;

public static class GbaDatumMapper
{
    private static readonly Regex GbaDatumRegex = new("^(?<jaar>[0-9]{4})(?<maand>[0-9]{2})(?<dag>[0-9]{2})$", RegexOptions.None, TimeSpan.FromMilliseconds(100));

    public static AbstractDatum Map(this string datum)
    {
        if (!GbaDatumRegex.IsMatch(datum))
        {
            return new DatumOnbekend
            {
                LangFormaat = "onbekend"
            };
        }

        (int jaar, int maand, int dag) = datum.Parse();

        AbstractDatum retval = new DatumOnbekend();
        if(jaar != 0 && maand != 0 && dag != 0 )
        {
            retval = new VolledigeDatum { Datum = new DateTime(jaar, maand, dag) };
        }
        else if(jaar != 0 && maand != 0 && dag == 0 )
        {
            retval = new JaarMaandDatum { Jaar = jaar, Maand = maand };
        }
        else if (jaar != 0 && maand == 0 && dag == 0)
        {
            retval = new JaarDatum { Jaar = jaar };
        }

        retval.LangFormaat = retval.LangFormaat();
        return retval;
    }

    private static (int jaar, int maand, int dag) Parse(this string datum)
    {
        var match = GbaDatumRegex.Match(datum);

        return (
            int.Parse(match.Groups["jaar"].Value, CultureInfo.InvariantCulture),
            int.Parse(match.Groups["maand"].Value, CultureInfo.InvariantCulture),
            int.Parse(match.Groups["dag"].Value, CultureInfo.InvariantCulture)
            );
    }

    public static string? LangFormaat(this AbstractDatum datum)
    {
        var maand = new Dictionary<int, string>
        {
            {1, "januari" },
            {2, "februari" },
            {3, "maart" },
            {4, "april" },
            {5, "mei" },
            {6, "juni" },
            {7, "juli" },
            {8, "augustus" },
            {9, "september" },
            {10, "oktober" },
            {11, "november" },
            {12, "december" }
        };

        return datum switch
        {
            VolledigeDatum d => $"{d.Datum!.Value.Day} {maand[d.Datum!.Value.Month]} {d.Datum!.Value.Year}",
            JaarMaandDatum d => $"{maand[d.Maand]} {d.Jaar}",
            JaarDatum d => $"{d.Jaar}",
            DatumOnbekend => "onbekend",
            _ => null
        };
    }
}
