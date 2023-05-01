using HaalCentraal.ReisdocumentProxy.Generated;
using Newtonsoft.Json;
using System.Reflection;

namespace ReisdocumentProxy.Helpers;

public static class PropertyPathFactory
{
    public static List<string> GetPropertyPaths(this Type type, string baseNamespace, string path = "")
    {
        List<string> retval = new();

        var attributes = type.GetCustomAttributes(false);
        foreach (var attribute in attributes)
        {
            switch (attribute)
            {
                case JsonConverterAttribute a:
                    var prop = a.ConverterParameters?[0] as string;
                    if (!string.IsNullOrWhiteSpace(prop))
                    {
                        retval.Add(prop.ToFullPath(path));
                    }
                    break;
                case JsonInheritanceAttribute a:
                    retval.AddRange(a.Type.GetPropertyPaths(baseNamespace, path));
                    break;
                default:
                    break;
            }
        }
        foreach (var property in type.GetProperties())
        {
            var name = property.JsonName();
            if (string.IsNullOrWhiteSpace(name))
            {
                continue;
            }
            if (name != "AdditionalProperties")
            {
                retval.Add(name.ToFullPath(path));
            }
            if (property.PropertyType.FullNameStartsWith(baseNamespace))
            {
                retval.AddRange(property.PropertyType.GetPropertyPaths(baseNamespace, name.ToFullPath(path)));
            }
            if (property.PropertyType.IsGenericType)
            {
                var genericType = property.PropertyType.GetGenericArguments()[0];
                if (genericType.FullNameStartsWith(baseNamespace))
                {
                    retval.AddRange(genericType.GetPropertyPaths(baseNamespace, name.ToFullPath(path)));
                }
            }
        }

        return retval;
    }

    private static string? JsonName(this PropertyInfo? property)
    {
        if (property == null) return null;

        var jsonProperty = property.GetCustomAttribute<JsonPropertyAttribute>();

        return jsonProperty != null
            ? jsonProperty.PropertyName
            : property.Name;
    }

    private static bool FullNameStartsWith(this Type? type, string baseNamespace)
    {
        return type != null &&
               !string.IsNullOrWhiteSpace(type.FullName) &&
               type.FullName.StartsWith(baseNamespace);
    }

    private static string ToFullPath(this string name, string path)
    {
        return string.IsNullOrWhiteSpace(path)
                ? name
                : $"{path}.{name}";
    }
}