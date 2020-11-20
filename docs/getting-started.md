---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'Bevraging reisdocumenten' Web API is gespecificeerd in [OpenAPI specifications (OAS)](https://swagger.io/specification/).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de functionaliteit en specificaties
2. Implementeer de API
3. Probeer en test de API

## Functionaliteit en specificaties
Met deze API kun je gegevens over een reisdocument ophalen met het reisdocumentnummer.

Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

Je kunt de [functionele documentatie](./features) vinden in de [features](./features).

## Implementeer de API

Je kunt code genereren op basis van de [genereervariant van de specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.
Voor enkele ontwikkelomgevingen is al [client code](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/tree/master/code){:target="_blank" rel="noopener"} gegenereerd.

## Probeer en test
Je kunt de Haal Centraal niet proberen in de demo-omgeving (www.haalcentraal.nl/haalcentraal/api/) omdat de achterliggende bron (GBA-V) op basis van de autorisatie die we gebruiken (autorisatietabel 35) geen autorisaties voor reisdocumenten bevat. Voorbeeldberichten zijn wel beschikbaar.

### Voorbeeldberichten
Onderstaande tabel bevat enkele voorbeeld antwoordberichten.

| reisdocumentnummer | situatie
| ---------------- | :-------  
| [NUR9J1JP7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/NUR9J1JP7.json){:target="_blank" rel="noopener"} | nationaal paspoort uitgegeven door gouverneur |
| [BD8P7H2C7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/BD8P7H2C7.json){:target="_blank" rel="noopener"} | vermist |
| [HPB1234HG](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/HPB1234HG.json){:target="_blank" rel="noopener"} | verlopen identiteitskaart |
| [BT6F58F32](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/BT6F58F32.json){:target="_blank" rel="noopener"} | uitgegeven door consulaire post |
| [RJR0JL7J7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/RJR0JL7J7.json){:target="_blank" rel="noopener"} | reisdocument voor vluchtelingen |
| [IX24PJ6B4](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/IX24PJ6B4.json){:target="_blank" rel="noopener"} | geheimhouding |
