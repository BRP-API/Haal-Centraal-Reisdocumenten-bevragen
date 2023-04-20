using System.Text.RegularExpressions;

namespace ReisdocumentProxy.Helpers;

public static class FieldsHelper
{
    public static ICollection<string> AddExtraReisdocumentFields(this ICollection<string> fields)
    {
        var retval = fields
            .ReplaceDatumWaardetabelPropertyFieldPaths()
            .AddAlwaysReturnedFields()
            .AddInOnderzoekPropertyPaths();

        return retval;
    }

    public static ICollection<string> AddAlwaysReturnedFields(this IEnumerable<string> fields)
    {
        List<string> retval = new(fields);

        retval.AddRange(new[]
        {
            "houder.geheimhoudingPersoonsgegevens",
            "houder.opschortingBijhouding"
        });

        return retval;
    }

    public static ICollection<string> ReplaceDatumWaardetabelPropertyFieldPaths(this IEnumerable<string> fields)
    {
        List<string> retval = new();

        foreach (var field in fields)
        {
            switch (field)
            {
                case "inhoudingOfVermissing.datum":
                    retval.Add(field);
                    break;
                default:
                    retval.Add(
                        Regex.Replace(field,
                                      @"(\.type|\.datum|\.langFormaat|\.jaar|\.maand|\.onbekend|\.code|\.omschrijving)$", "",
                                      RegexOptions.None, TimeSpan.FromMilliseconds(100)));
                    break;
            }
        }

        return retval;
    }

    public static ICollection<string> AddInOnderzoekPropertyPaths(this IEnumerable<string> fields)
    {
        List<string> retval = new();

        foreach (var field in fields)
        {
            retval.Add(field);

            var fieldParts = field.Split('.');
            switch (fieldParts.Length)
            {
                case 1:
                    if (fieldParts[0] == "inhoudingOfVermissing" ||
                        fieldParts[0] == "houder")
                    {
                        retval.Add($"{fieldParts[0]}.inOnderzoek");
                    }
                    else
                    {
                        retval.Add($"inOnderzoek.{fieldParts[0]}");
                        retval.Add("inOnderzoek.datumIngangOnderzoek");
                    }
                    break;
                case 2:
                    retval.Add($"{fieldParts[0]}.inOnderzoek.{fieldParts[1]}");
                    retval.Add($"{fieldParts[0]}.inOnderzoek.datumIngangOnderzoek");
                    break;
                default:
                    break;
            }
        }

        return retval;
    }
}
