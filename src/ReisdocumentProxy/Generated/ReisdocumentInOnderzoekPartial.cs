namespace HaalCentraal.ReisdocumentProxy.Generated
{
    public partial class ReisdocumentInOnderzoek
    {
        public bool ShouldSerialize() =>
            DatumEindeGeldigheid.HasValue ||
            Reisdocumentnummer.HasValue ||
            Soort.HasValue
            ;
    }
}
