namespace Reisdocument.Validatie.Interfaces;

public interface IRaadpleegMetReisdocumentnummerQuery
{
    List<string> Reisdocumentnummer { get; set; }
    string? GemeenteVanInschrijving { get; set; }
}
