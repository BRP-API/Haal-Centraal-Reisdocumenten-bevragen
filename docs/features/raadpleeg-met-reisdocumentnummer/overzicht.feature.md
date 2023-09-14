---
layout: page-with-side-nav
title: Raadpleeg met reisdocumentnummer
---
#language: nl  


# Functionaliteit: Raadpleeg met reisdocumentnummer


## Rule: voor het raadplegen van een reisdocument moet het reisdocumentnummer worden opgegeven


### Scenario: Raadpleeg een reisdocument

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens

  | naam                                        | waarde    |
  |---------------------------------------------|-----------|
  | soort reisdocument (35.10)                  | PN        |
  | nummer reisdocument (35.20)                 | NE3663258 |
  | datum einde geldigheid reisdocument (35.50) | 20240506  |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0800                              |
* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam               | waarde                         |
  |--------------------|--------------------------------|
  | type               | RaadpleegMetReisdocumentnummer |
  | reisdocumentnummer | NE3663258                      |
  | fields             | reisdocumentnummer,houder      |
* __Dan__ heeft de response een 'reisdocument' met de volgende gegevens

  | naam               | waarde    |
  |--------------------|-----------|
  | reisdocumentnummer | NE3663258 |
* __En__ heeft het 'reisdocument' de volgende 'houder' gegevens

  | naam                | waarde    |
  |---------------------|-----------|
  | burgerservicenummer | 000000152 |

### Scenario: Raadpleeg een niet bestaand reisdocument

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens

  | naam                                        | waarde    |
  |---------------------------------------------|-----------|
  | soort reisdocument (35.10)                  | PN        |
  | nummer reisdocument (35.20)                 | NE3663258 |
  | datum einde geldigheid reisdocument (35.50) | 20240506  |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0800                              |
* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam               | waarde                         |
  |--------------------|--------------------------------|
  | type               | RaadpleegMetReisdocumentnummer |
  | reisdocumentnummer | NE3663259                      |
  | fields             | reisdocumentnummer,houder      |
* __Dan__ heeft de response 0 reisdocumenten

## Rule: als een gevraagde veld in onderzoek is, dan wordt het bijbehorend inOnderzoek veld en datumIngangOnderzoek ook geleverd


### Scenario: 'soort reisdocument (35.10)' is in onderzoek en wordt gevraagd

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens

  | naam                                        | waarde    |
  |---------------------------------------------|-----------|
  | soort reisdocument (35.10)                  | PN        |
  | nummer reisdocument (35.20)                 | NE3663258 |
  | datum einde geldigheid reisdocument (35.50) | 20240506  |
  | aanduiding in onderzoek (83.10)             | 123510    |
  | datum ingang onderzoek (83.20)              | 20230201  |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0800                              |
* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam               | waarde                         |
  |--------------------|--------------------------------|
  | type               | RaadpleegMetReisdocumentnummer |
  | reisdocumentnummer | NE3663258                      |
  | fields             | reisdocumentnummer,soort       |
* __Dan__ heeft de response een 'reisdocument' met de volgende gegevens

  | naam                                         | waarde             |
  |----------------------------------------------|--------------------|
  | reisdocumentnummer                           | NE3663258          |
  | soort.code                                   | PN                 |
  | soort.omschrijving                           | Nationaal paspoort |
  | inOnderzoek.soort                            | true               |
  | inOnderzoek.datumIngangOnderzoek.type        | Datum              |
  | inOnderzoek.datumIngangOnderzoek.datum       | 2023-02-01         |
  | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 februari 2023    |

### Scenario: 'soort reisdocument (35.10)' is in onderzoek en wordt niet gevraagd

* __Gegeven__ de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens

  | naam                                        | waarde    |
  |---------------------------------------------|-----------|
  | soort reisdocument (35.10)                  | PN        |
  | nummer reisdocument (35.20)                 | NE3663258 |
  | datum einde geldigheid reisdocument (35.50) | 20240506  |
  | aanduiding in onderzoek (83.10)             | 123510    |
  | datum ingang onderzoek (83.20)              | 20230201  |
* __En__ de persoon heeft de volgende 'verblijfplaats' gegevens

  | gemeente van inschrijving (09.10) |
  |-----------------------------------|
  | 0800                              |
* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam               | waarde                         |
  |--------------------|--------------------------------|
  | type               | RaadpleegMetReisdocumentnummer |
  | reisdocumentnummer | NE3663258                      |
  | fields             | reisdocumentnummer             |
* __Dan__ heeft de response een 'reisdocument' met de volgende gegevens

  | naam               | waarde    |
  |--------------------|-----------|
  | reisdocumentnummer | NE3663258 |

