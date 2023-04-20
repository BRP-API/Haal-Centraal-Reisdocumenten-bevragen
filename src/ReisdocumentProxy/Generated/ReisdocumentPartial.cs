namespace HaalCentraal.ReisdocumentProxy.Generated;

public partial class Reisdocument
{
    public bool ShouldSerializeInOnderzoek() =>
        InOnderzoek != null && InOnderzoek.ShouldSerialize();
}
