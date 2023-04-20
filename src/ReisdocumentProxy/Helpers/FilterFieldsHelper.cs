using System.Reflection;

namespace ReisdocumentProxy.Helpers;

public static class FilterFieldsHelper
{
    public static ICollection<T>? FilterList<T>(this ICollection<T> list, IEnumerable<string> fields)
    {
        if (list == null)
        {
            return default;
        }

        var retval = Activator.CreateInstance(list.GetType()) as ICollection<T>;
        if (retval == null)
        {
            return default;
        }

        foreach (var entity in list)
        {
            var newEntity = entity.Filter(fields);
            if (newEntity != null)
            {
                retval.Add(newEntity);
            }
        }

        return retval;
    }

    public static T? Filter<T>(this T? entity, IEnumerable<string> fields)
    {
        if (entity == null)
        {
            return default;
        }

        var retval = Activator.CreateInstance(entity.GetType());

        foreach (var field in fields)
        {
            var fieldParts = field.Split('.');

            object? src = entity;
            object? dest = retval!;
            for (var index = 0; index < fieldParts.Length; index++)
            {
                var fieldPart = fieldParts[index];

                (var pi, var srcValue) = src.GetValue(fieldPart);
                if (pi == null || srcValue == null)
                {
                    // property of deel van de property heeft geen waarde. Stop met filteren van property
                    break;
                }

                if (index == fieldParts.Length - 1)
                {
                    pi.SetValue(dest, srcValue);
                }
                else
                {
                    var val = pi.GetValue(dest);
                    if (val == null)
                    {
                        pi.SetValue(dest, Activator.CreateInstance(srcValue != null ? srcValue.GetType() : pi.PropertyType));
                    }
                    dest = pi.GetValue(dest);
                }
                src = srcValue;
            }
        }

        return (T?)retval;
    }

    public static (PropertyInfo? pi, object? value) GetValue<T>(this T entity, string field)
    {
        if (entity == null) return (null, null);

        var pi = entity.GetType().GetProperty(field, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);
        if (pi == null) return (null, null);

        var val = pi.GetValue(entity);
        if (val == null) return (null, null);

        return (pi, val);
    }
}
