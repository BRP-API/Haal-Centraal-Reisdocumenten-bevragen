---
layout: page-with-side-nav
title: Haal Centraal Reisdocumenten bevragen
---

# Haal Centraal Reisdocumenten bevragen

![lint oas](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/workflows/generate-postman-collection/badge.svg)

API voor het zoeken van een reisdocument met een burgerservicenummer en het raadplegen van een reisdocument met een reisdocumentnummer. 

## Planning en Roadmap
De BRP Reisdocumenten API is live sinds september 2023. 

## Aansluiten en voorwaarden
De BRP Reisdocumenten API kan voorlopig alleen worden gebruikt door gemeenten die deelnemen aan het [Experiment Dataminimalisatie](https://www.rijksoverheid.nl/documenten/besluiten/2023/08/28/experimentbesluit-brp-dataminimalisatie-amvb-nvt-versie-voorhang). Hiervoor wordt een convenant met RvIG gesloten waarin de afspraken voor deelname zijn vastgelegd. Voor de technische aansluiting is een API Gateway nodig. Aansluiten kan via Diginetwerk met gebruik van een TLS verbinding (PKIO certificaat) en een OAuth 2.0 token (OAuth 2.0 client credentials flow).

Stuur een mail naar info@RvIG voor een kennismakingmakingsgesprek en onboarding.

## Direct uitproberen?
* Bekijk de specificaties met [Swagger UI](swagger-ui) of [Redoc](redoc)
* Lees de [Getting started](getting-started)
* Download de [technische specificaties](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}

## Heb je meer nodig? 
Gebruik de Reisdocumenten bevragen API in combinatie met (een van de) andere BRP API’s:

* [Actuele BRP-gegevens bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [Historische BRP-gegevens bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [Bewoning en medebewoners bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bewoning){:target="_blank" rel="noopener"}
* [Landelijke tabellen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-tabellen-bevragen){:target="_blank" rel="noopener"}

## Bronnen

* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Bug Melden
  [Maak een bug issue aan >>](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Maak een verbeter issue aan >>](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [c.dingemanse@comites.nl](mailto:c.dingemanse@comites.nl)
* Designer: Johan Boer, [johan.boer@vng.nl](mailto:johan.boer@vng.nl)
* Designer: Robert Melskens, [robert.melskens@vng.nl](mailto:robert.melskens@vng.nl)
* Customer zero: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@iswish.nl)
* Tester: Frank Samwel, [frank.samwel@denhaag.nl](mailto:frank.samwel@rvig.nl)

## Licentie

Copyright &copy; VNG Realisatie 2020
Licensed under the [EUPL](https://github.com/BRP-API/Haal-Centraal-Reisdocumenten-bevragen/blob/master/LICENCE.md){:target="_blank" rel="noopener"}
