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
  - [overzicht](./features/zoek-met-burgerservicenummer/overzicht.feature)
  - [fout cases](./features/zoek-met-burgerservicenummer/fout-cases.feature)

Het resultaat van deze operatie is een Reisdocument collectie/lijst.

## Raadplegen van reisdocumenten

Als het reisdocumentnummer van de te bevragen reisdocument bekend is, moet hiervoor de volgende operatie worden gebruikt:

- raadpleeg met reisdocumentnummer
    - [overzicht](./features/raadpleeg-met-reisdocumentnummer/overzicht.feature)
    - [fout cases](./features/raadpleeg-met-reisdocumentnummer/fout-cases.feature)

Het resultaat van deze operatie is een Reisdocument collectie/lijst.
