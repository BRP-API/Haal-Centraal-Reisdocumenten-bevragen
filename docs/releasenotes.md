---
layout: page-with-side-nav
title: Haal Centraal Reisdocumenten bevragen
---
# Releasenotes Haal-Centraal-Reisdocumenten-Bevragen

## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-Reisdocumenten-bevragen API als release is uitgebracht is de specificatie het afgelopen jaar redelijk stabiel geweest.
Voor het uitbrengen van release v1.0.0 is besloten om de nieuwe inzichten die het afgelopen jaar zijn opgedaan op te nemen. Hier een globaal (en niet limitatief) overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen zijn breaking ten opzichte van v0.9.0 .

We bieden nu ook SDK's aan met gegenereerde [plumbing-code](./code).
Daarnaast bieden we een[postman-collectie](./test) t.b.v. testen aan.

### Openapi.yaml :

- Base-url aangepast. (Breaking)
- Alle descriptions zijn omgezet naar markdown.
- Bij property reisdocumentnummer is de maxLength weggehaald.
- OperationId's zijn aangepast. (Breaking)
- Titles en descriptions bij de booleans van ReisdocumentInOnderzoek zijn verwijderd.
- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - Hal-componenten die alleen _links bevatten zijn omgenoemd van xxxHal naar xxxHalBasis
  - AanduidingInhoudingVermissingReisdocument_enum --> AanduidingInhoudingVermissingReisdocumentEnum
  - Reisdocument_links --> ReisdocumentLinks


### Features:

- fields_extensie.feature is toegevoegd
- in_onderzoe.feature is toegevoegd.
