using HaalCentraal.ReisdocumentService.Generated;
using Newtonsoft.Json;

namespace HaalCentraal.ReisdocumentService.Repositories;

public class ReisdocumentRepository
{
    private readonly IWebHostEnvironment _environment;

    public ReisdocumentRepository(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<ReisdocumentenQueryResponse> Zoek<T>(T query)
    {
        var path = Path.Combine(_environment.ContentRootPath, "Data", "test-data.json");
        if(!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);
        return query switch
        {
            RaadpleegMetReisdocumentnummer f => new RaadpleegMetReisdocumentnummerResponse
            {
                Reisdocumenten = JsonConvert.DeserializeObject<List<GbaReisdocument>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            ZoekMetBurgerservicenummer f => new ZoekMetBurgerservicenummerResponse
            {
                Reisdocumenten = JsonConvert.DeserializeObject<List<GbaReisdocument>>(data)?
                    .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList()
            },
            _ => throw new NotSupportedException($"{query}")
        };
    }
}
