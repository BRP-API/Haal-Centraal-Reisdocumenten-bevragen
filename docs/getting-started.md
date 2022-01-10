---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'Bevraging reisdocumenten' Web API is gespecificeerd in [OpenAPI specifications (OAS)](https://swagger.io/specification/).

Wil je de API gebruiken? Dit kun je doen:

1. [Bekijk de functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API](#bouw-de-api)
3. [Probeer en test de API](#probeer-en-test-de-api)

## Functionaliteit en specificaties
Met deze API kun je gegevens over een reisdocument ophalen met het reisdocumentnummer.

Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

Je kunt de [functionele documentatie](./features) vinden in de [features](./features).

## Bouw de API
Client code kan worden gegenereerd vanuit de "[genereervariant](https://github.com/VNG-Realisatie/Haal-Centraal-Reisdocumenten-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht van code generatoren is te vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee met behulp van [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kan worden gegenereerd in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kan met `npm install` de benodigde packages worden geïnstalleerd. Vervolgens kan met `npm run <script naam>` één van de volgende scripts worden uitgevoerd:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties is te vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite van OpenAPI Generator is JAVA. Een JAVA runtime moet worden geïnstalleerd voordat OpenAPI Generator kan worden gebruikt.

## Probeer en test de API
Je kunt deze Haal Centraal API niet proberen in de demo-omgeving (www.haalcentraal.nl/haalcentraal/api/) omdat de achterliggende bron (GBA-V obv autorisatietabel 35) geen autorisaties voor reisdocumenten bevat. Voorbeeldberichten zijn wel beschikbaar.

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
