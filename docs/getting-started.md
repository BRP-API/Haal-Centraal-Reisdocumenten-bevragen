---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

##  Let op: Er worden geen nieuwe gemeenten aangesloten op de BRP Reisdocumenten API. Afnemers moeten binnen de met hen afsproken periode migreren naar een API van het reisdocumentenstelsel.

# Documentatie voor bestaande afnemers
De 'Bevraging reisdocumenten' Web API is gespecificeerd in [OpenAPI specifications (OAS)](https://swagger.io/specification/).
1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API Client](#implementeer-de-api-client)
3. [Probeer en test de API](#probeer-en-test-de-api)
 
## Functionaliteit en specificaties
Met deze API kun je gegevens over een reisdocument ophalen met het reisdocumentnummer.
Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI](redoc).
Je kunt de [functionele documentatie](features) vinden in de [features](features).

## Implementeer de API client
Client code kun je genereren met de "[genereervariant](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht met codegeneratoren kun je vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee je met [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kunt genereren in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kun je met `npm install` de benodigde packages installeren en kun je met npm run <script naam> één van de volgende scripts uitvoeren:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties kun je vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite van OpenAPI Generator is JAVA. Je moet een JAVA runtime installeren voordat je OpenAPI Generator kunt gebruiken
  
## Probeer en test de API
Je kunt deze Haal Centraal API niet proberen in de demo-omgeving (www.haalcentraal.nl/haalcentraal/api/) omdat de achterliggende bron (GBA-V obv autorisatietabel 35) geen autorisaties voor reisdocumenten bevat. Voorbeeldberichten zijn wel beschikbaar.

### Voorbeeldberichten
Onderstaande tabel bevat enkele voorbeeld antwoordberichten.

| reisdocumentnummer | situatie
| ---------------- | :-------  
| [NUR9J1JP7](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/NUR9J1JP7.json){:target="_blank" rel="noopener"} | nationaal paspoort uitgegeven door gouverneur |
| [BD8P7H2C7](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/BD8P7H2C7.json){:target="_blank" rel="noopener"} | vermist |
| [HPB1234HG](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/HPB1234HG.json){:target="_blank" rel="noopener"} | verlopen identiteitskaart |
| [BT6F58F32](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/BT6F58F32.json){:target="_blank" rel="noopener"} | uitgegeven door consulaire post |
| [RJR0JL7J7](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/RJR0JL7J7.json){:target="_blank" rel="noopener"} | reisdocument voor vluchtelingen |
| [IX24PJ6B4](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/test/IX24PJ6B4.json){:target="_blank" rel="noopener"} | geheimhouding |
