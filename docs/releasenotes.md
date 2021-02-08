---
layout: page-with-side-nav
title: Haal Centraal Reisdocumenten bevragen
---
# Releasenotes Haal-Centraal-Reisdocumenten-Bevragen

## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-Reisdocumenten-bevragen API als release is uitgebracht is de specificatie het afgelopen jaar redelijk stabiel geweest. Die stand van zaken hebben we in release v0.9.0 vastgelegd.
Voor het uitbrengen van release v1.0.0 is besloten om de nieuwe inzichten die het afgelopen jaar zijn opgedaan op te nemen. Hier een globaal overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen hebben mogelijk impact op de provider implementatie of bij het (opnieuw) genereren van code ten opzichte van v0.9.0 .

We bieden nu ook SDK's aan met gegenereerde [plumbing-code](./code).
Daarnaast bieden we een[postman-collectie](./test) t.b.v. testen aan.

### Openapi.yaml :

- Base-url aangepast.
- Alle descriptions zijn omgezet naar markdown.
- Bij property reisdocumentnummer is de maxLength weggehaald.
- OperationId's zijn aangepast.
- Titles en descriptions bij de booleans van ReisdocumentInOnderzoek zijn verwijderd.
- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - AanduidingInhoudingVermissingReisdocument_enum --> AanduidingInhoudingVermissingReisdocumentEnum
  - Reisdocument_links --> ReisdocumentLinks


### Features:

- in_onderzoek.feature is toegevoegd.
