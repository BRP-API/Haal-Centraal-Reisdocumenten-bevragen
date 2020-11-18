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
Met deze API kunnen de gegevens van een reisdocument worden opgehaald met het reisdocumentnummer.

Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

Je kunt de [functionele documentatie](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/features/reisdocumenten.feature){:target="_blank" rel="noopener"} lezen, met specificaties en voorbeelden.

## Implementeer de API

Je kunt code genereren op basis van de [genereervariant van de specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.
Voor enkele ontwikkelomgevingen is al [client code](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/tree/master/code){:target="_blank" rel="noopener"} gegenereerd.

## Probeer en test
De Haal Centraal demo-omgeving (www.haalcentraal.nl/haalcentraal/api/) heeft geen reisdocumenten API beschikbaar. Reden hiervoor is dat de Haal Centraal omgeving GBA-V gebruikt volgens de GBA-V tabel 35 autorisatietabel. Daarin zijn er geen autorisaties voor reisdocumenten.

Er is wel een aantal voorbeeldberichten beschikbaar.

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
