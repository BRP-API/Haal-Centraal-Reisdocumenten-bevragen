using Brp.Shared.Infrastructure.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace Brp.Shared.Infrastructure.Utils;

public static class ServiceProviderExtensions
{
    public static T? GetServiceForRequestedResource<T>(this IServiceProvider serviceProvider, HttpRequest httpRequest)
    {
        var requestedResource = httpRequest.GetRequestedResource();

        return serviceProvider.GetKeyedService<T>(requestedResource);
    }
}
