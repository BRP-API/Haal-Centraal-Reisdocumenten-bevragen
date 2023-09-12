namespace Reisdocument.Infrastructure.Json;

public static class JsonStringHelpers
{
    public static string Sanitize(this string json) =>
        !string.IsNullOrEmpty(json)
            ? json.Replace(Environment.NewLine, "")
                  .Replace("<", "&lt;")
                  .Replace(">", "&gt;")
            : json;
}
