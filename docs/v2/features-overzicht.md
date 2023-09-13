---
layout: page-with-side-nav
title: Features
---

# {{ site.apiname }} Web API Features

De {{ site.apiname }} Web API maakt het mogelijk om gegevens van reisdocumenten in de basisregistratie personen (BRP) te raadplegen. De reisdocumenten worden opgezocht met behulp van hun reisdocumentnummer of met behulp van de burgerservicenummer van zijn houder.

## Algemene Verordening Gegevensbescherming (AVG)

De '{{ site.apiname }}' Web API is ontworpen conform de REST principes. Om ook aan de AVG te conformeren zijn er concessies gedaan met betrekking tot het toepassen van de REST principes. De belangrijkste concessie is dat de POST methode en niet de GET methode wordt gebruikt om reisdocumenten te bevragen. Dit zorgt er voor dat er geen [persoonlijk identificeerbare informatie (PII)](https://piwikpro.nl/blog/pii-niet-pii-en-persoonsgegevens/) terecht komen in de url van een request en daardoor ook niet in server logs.

## Zoeken van reisdocumenten

Reisdocumenten kunnen worden opgezocht met behulp van de burgerservicenummer van hun houder. Hiervoor wordt de volgende operatie gebruikt:

- zoek met burgerservicenummer
  - [overzicht](../features/zoek-met-burgerservicenummer/overzicht.feature)
  - [fout cases](../features/zoek-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operatie is een Reisdocument collectie/lijst.

## Raadplegen van reisdocumenten

Als het reisdocumentnummer van de te bevragen reisdocument bekend is, moet hiervoor de volgende operatie worden gebruikt:

- raadpleeg met reisdocumentnummer
    - [overzicht](../features/raadpleeg-met-reisdocumentnummer/overzicht.feature)
    - [fout cases](../features/raadpleeg-met-reisdocumentnummer/fout-cases.feature)

Het resultaat van deze operatie is een Reisdocument collectie/lijst.

## Filteren van de velden van de gevonden reisdocumenten

Bij elke bevraging moet de fields parameter verplicht worden gebruikt om aan te geven welke velden van de gevonden reisdocument(en) geleverd moet worden. Om de privacy van de houder van de gevraagde reisdocumenten te beschermen mag een afnemer alleen de velden vragen waarvoor hij doelbinding heeft en moet de gevraagde velden worden beperkt tot wat nodig is voor de uit te voeren taak.
Bijkomend voordeel van deze data minimalisatie is dat er ook wordt bijgedragen aan verduurzaming. Hoe minder velden er worden gevraagd, hoe minder de server en het netwerk worden belast.

Een veld wordt gevraagd door het volledig pad van het betreffende veld op te geven in de fields parameter. Het volledig pad van een veld is de samenvoeging van de naam van het veld en de namen van zijn 'ouder' velden met een '.' karakter tussen de veld namen. Voorbeelden van volledige paden:

- houder.burgerservicenummer (volledig pad van het burgerservicenummer veld van de houder van een reisdocument)

Zie de raadpleeg met reisdocumentnummer [fields](../features/raadpleeg-met-reisdocumentnummer/fields.feature), de zoek met burgerservicenummer [fields](../features/zoek-met-burgerservicenummer/fields.feature) en de [fields fout cases](../features/fields-fout-cases.feature) feature bestanden voor meer informatie en voorbeelden over het gebruik van veld paden en de fields parameter.

### Filteren van datum velden

De {{ site.apiname }} Web API kent de volgende datum types:

- VolledigeDatum
- DatumOnbekend
- JaarDatum
- JaarMaandDatum

en de volgende waardetabel type:

- Waardetabel (soort reisdocument, aanduiding inhouding of vermissing)

Bij het vragen van één of meerdere velden van deze types wordt altijd alle velden van het gevraagde type geleverd. In de raadpleeg met reisdocumentnummer [fields](../features/raadpleeg-met-reisdocumentnummer/fields.feature) en de zoek met burgerservicenummer [fields](../features/zoek-met-burgerservicenummer/fields.feature) feature bestanden zijn voorbeelden hiervan opgenomen.

### Standaard geleverde velden

De volgende velden worden automatisch geleverd, als de bijbehorende situatie van toepassing is:

- geheimhoudingPersoonsgegevens
- inOnderzoek
- opschortingBijhouding

Automatisch geleverde velden mogen niet worden gevraagd met de fields parameter. In de [fields](../features/fields-fout-cases.feature) feature bestand is onder [Rule: Automatisch geleverde velden mogen niet worden gevraagd](../features/fields-fout-cases.feature#rule-automatisch-geleverde-velden-mogen-niet-worden-gevraagd) voorbeelden hiervan opgenomen.

## Geen/null/false waarde en leeg object waarde

Om de payload van een response klein te houden, is er voor gekozen om velden met de volgende waarden niet te leveren in de response:

- niet gevraagde velden. Deze velden hebben _null_ als waarde.
- gevraagde velden die het gevraagde reisdocument niet heeft. Deze velden hebben _null_ als waarde. Voorbeeld: inhoudingOfVermissing.datum veld wordt gevraagd voor een reisdocument die niet is ingehouden of als vermist is opgegeven.
- gevraagde of automatisch geleverde velden hebben de _false_ waarde. Voorbeeld: geheimhoudingPersoonsgegevens velden wordt niet geleverd als de houder niet om geheimhouding heeft verzocht.
- gevraagde velden is een groep velden die de persoon niet heeft. Voorbeeld: inhoudingOfVermissing velden wordt gevraagd voor een reisdocument die niet is ingehouden of als vermist is opgegeven.
- gevraagde velden hebben geen aanduiding in onderzoek.
