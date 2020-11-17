---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'Bevraging reisdocumenten' Web API is gespecificeerd met behulp van de [OpenAPI specifications (OAS)](https://swagger.io/specification/).

## Specificaties

Een visuele representatie van de specificatie kan worden gegenereerd met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc/).

De (resolved) OAS3 is hier te downloaden: [openapi.yaml](https://github.com/VNG-Realisatie{{ site.baseurl }}/blob/master/specificatie/genereervariant/openapi.yaml).


## Functionaliteit
Met deze API kunnen de gegevens van een reisdocument worden opgehaald met het reisdocumentnummer.

De 'Bevraging Reisdocumenten' Web API maakt gebruik van de HAL (Hypertext Application Language) standaard om bij een resource links op te nemen naar gerelateerde resources.  

## Probeer en test de API
De Haal Centraal demo-omgeving (www.haalcentraal.nl/haalcentraal/api/) heeft geen reisdocumenten API beschikbaar. Reden hiervoor is dat de Haal Centraal omgeving GBA-V gebruikt volgens de GBA-V tabel 35 autorisatietabel. Daarin zijn er geen autorisaties voor reisdocumenten.

Er is wel een aantal voorbeeldberichten beschikbaar.

### Voorbeeldberichten
Onderstaand tabel bevat enkele voorbeeld antwoordberichten.

| reisdocumentnummer | situatie
| ---------------- | :-------  
| [NUR9J1JP7](../test/NUR9J1JP7.json) | nationaal paspoort uitgegeven door gouverneur |
| [BD8P7H2C7](../test/BD8P7H2C7.json) | vermist |
| [HPB1234HG](../test/HPB1234HG.json) | verlopen identiteitskaart |
| [BT6F58F32](../test/BT6F58F32.json) | uitgegeven door consulaire post |
| [RJR0JL7J7](../test/RJR0JL7J7.json) | reisdocument voor vluchtelingen |
| [IX24PJ6B4](../test/IX24PJ6B4.json) | geheimhouding |
