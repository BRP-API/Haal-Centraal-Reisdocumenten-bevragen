namespace Reisdocument.Validatie.Interfaces;

public interface IReisdocumentenQuery
{
    List<string>? Fields { get; }
    string? GemeenteVanInschrijving { get; }
}
