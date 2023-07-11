namespace HaalCentraal.ReisdocumentProxy.Generated;

[Newtonsoft.Json.JsonConverter(typeof(JsonInheritanceConverter), "type")]
[JsonInheritanceAttribute("RaadpleegMetReisdocumentnummer", typeof(RaadpleegMetReisdocumentnummer))]
[JsonInheritanceAttribute("ZoekMetBurgerservicenummer", typeof(ZoekMetBurgerservicenummer))]
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.18.2.0 (NJsonSchema v10.8.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class ReisdocumentenQuery
{
    [Newtonsoft.Json.JsonProperty("fields", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Collections.Generic.List<string>? Fields { get; set; } = default!;

    private System.Collections.Generic.IDictionary<string, object> _additionalProperties = default!;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}
