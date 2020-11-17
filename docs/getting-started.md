---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'Bevraging reisdocumenten' Web API is gespecificeerd in [OpenAPI specifications (OAS)](https://swagger.io/specification/).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de [functionaliteit en specificaties](#Functionaliteit-en-specificaties)
2. [Implementeer](#Implementeer-de-API) de API
3. [Probeer en test](#Probeer-en-test) de API

## Functionaliteit en specificaties
Met deze API kunnen de gegevens van een reisdocument worden opgehaald met het reisdocumentnummer.

Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc/).

Je kunt de [functionele documentatie]({{ site.baseurl }}/features) lezen, met specificaties en voorbeelden.

De 'Bevraging Reisdocumenten' Web API maakt gebruik van de HAL (Hypertext Application Language) standaard om bij een resource links op te nemen naar gerelateerde resources.  

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
| [NUR9J1JP7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/NUR9J1JP7.json) | nationaal paspoort uitgegeven door gouverneur |
| [BD8P7H2C7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/BD8P7H2C7.json) | vermist |
| [HPB1234HG](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/HPB1234HG.json) | verlopen identiteitskaart |
| [BT6F58F32](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/BT6F58F32.json) | uitgegeven door consulaire post |
| [RJR0JL7J7](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/RJR0JL7J7.json) | reisdocument voor vluchtelingen |
| [IX24PJ6B4](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/test/IX24PJ6B4.json) | geheimhouding |
