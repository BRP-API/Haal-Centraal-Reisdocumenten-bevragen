---
layout: page-with-side-nav
title: Fout cases bij vragen van reisdocument velden met fields
---
#language: nl  


# Functionaliteit: Fout cases bij vragen van reisdocument velden met fields


## Rule: De fields parameter is een verplichte parameter


`@fout-case`
### Abstract Scenario: De fields parameter ontbreekt

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde             |
  |------------------|--------------------|
  | type             | \<zoek type\>        |
  | \<parameter naam\> | <parameter waarde> |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: fields.                      |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code     | name   | reason                  |
  |----------|--------|-------------------------|
  | required | fields | Parameter is verplicht. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde |
  |--------------------------------|---------------------|------------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |

## Rule: De fields parameter bevat een lijst met minimaal één veld pad


`@fout-case`
### Abstract Scenario: De fields parameter bevat een lege lijst

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde             |
  |------------------|--------------------|
  | type             | \<zoek type\>        |
  | \<parameter naam\> | <parameter waarde> |
  | fields           |                    |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: fields.                      |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code     | name   | reason                          |
  |----------|--------|---------------------------------|
  | minItems | fields | Array bevat minder dan 1 items. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde |
  |--------------------------------|---------------------|------------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |

## Rule: De fields parameter bevat een lijst met maximaal 25 veld paden


`@fout-case`
### Scenario: De fields parameter bevat meer dan 25 veld paden

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
  |------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | type             | \<zoek type\>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
  | \<parameter naam\> | <parameter waarde>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
  | fields           | reisdocumentnummer,soort,soort.code,soort.omschrijving,datumEindeGeldigheid,datumEindeGeldigheid.type,datumEindeGeldigheid.datum,houder,houder.burgerservicenummer,inhoudingOfVermissing,inhoudingOfVermissing.aanduiding,inhoudingOfVermissing.datum,reisdocumentnummer,soort,soort.code,soort.omschrijving,datumEindeGeldigheid,datumEindeGeldigheid.type,datumEindeGeldigheid.datum,houder,houder.burgerservicenummer,inhoudingOfVermissing,inhoudingOfVermissing.aanduiding,inhoudingOfVermissing.datum,reisdocumentnummer,reisdocumentnummer |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: fields.                      |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code     | name   | reason                         |
  |----------|--------|--------------------------------|
  | maxItems | fields | Array bevat meer dan 25 items. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde |
  |--------------------------------|---------------------|------------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |

## Rule: De fields parameter bevat veld paden die verwijzen naar een bestaand veld. Een veld pad is een string bestaande uit minimaal 1 en maximaal 200 karakters. Deze karakters kunnen zijn:

- kleine letters (a-z)  
- hoofdletters (A-Z)  
- cijfers (0-9)  
- punt (.) en de laag streepje teken (_)  

`@fout-case`
### Abstract Scenario: De fields parameter bevat één of meerdere veld paden met ongeldige karakters

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde             |
  |------------------|--------------------|
  | type             | \<zoek type\>        |
  | \<parameter naam\> | <parameter waarde> |
  | fields           | \<fields\>           |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: \<index veld pad\>.            |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code    | name             | reason                                                   |
  |---------|------------------|----------------------------------------------------------|
  | pattern | \<index veld pad\> | Waarde voldoet niet aan patroon ^[a-zA-Z0-9\._]{1,200}$. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde | fields                                         | index veld pad |
  |--------------------------------|---------------------|------------------|------------------------------------------------|----------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | reisd*cumentnummer                             | fields[0]      |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder burger service nummer                   | fields[0]      |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | reisdocumentnummer,,houder.burgerservicenummer | fields[1]      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | reisd*cumentnummer                             | fields[0]      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder burger service nummer                   | fields[0]      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | reisdocumentnummer,,houder.burgerservicenummer | fields[1]      |

`@fout-case`
### Abstract Scenario: De fields parameter bevat één of meerdere niet bestaande (onjuiste case) veld paden

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde             |
  |------------------|--------------------|
  | type             | \<zoek type\>        |
  | \<parameter naam\> | <parameter waarde> |
  | fields           | \<fields\>           |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: \<index veld pad\>.            |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code   | name             | reason                                       |
  |--------|------------------|----------------------------------------------|
  | fields | \<index veld pad\> | Parameter bevat een niet bestaande veldnaam. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde | fields                                 | index veld pad |
  |--------------------------------|---------------------|------------------|----------------------------------------|----------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | reisDocumentNummer                     | fields[0]      |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | reisdocumentnummer,burgerservicenummer | fields[1]      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | reisDocumentNummer                     | fields[0]      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | reisdocumentnummer,burgerservicenummer | fields[1]      |

## Rule: Automatisch geleverde velden mogen niet worden gevraagd


`@fout-case`
### Abstract Scenario: De fields parameter bevat één of meerdere paden van automatisch geleverde velden

* __Als__ reisdocumenten wordt gezocht met de volgende parameters

  | naam             | waarde             |
  |------------------|--------------------|
  | type             | \<zoek type\>        |
  | \<parameter naam\> | <parameter waarde> |
  | fields           | \<fields\>           |
* __Dan__ heeft de response een object met de volgende gegevens

  | naam     | waarde                                                      |
  |----------|-------------------------------------------------------------|
  | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
  | title    | Een of meerdere parameters zijn niet correct.               |
  | status   | 400                                                         |
  | detail   | De foutieve parameter(s) zijn: fields[0].                   |
  | code     | paramsValidation                                            |
  | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
* __En__ heeft het object de volgende 'invalidParams' gegevens

  | code   | name      | reason                                        |
  |--------|-----------|-----------------------------------------------|
  | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

#### Voorbeelden:


  | zoek type                      | parameter naam      | parameter waarde | fields                                                             |
  |--------------------------------|---------------------|------------------|--------------------------------------------------------------------|
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inhoudingOfVermissing.inOnderzoek                                  |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inhoudingOfVermissing.inOnderzoek.datum                            |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inhoudingOfVermissing.inOnderzoek.aanduiding                       |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek             |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.type        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.datum       |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.langFormaat |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.onbekend    |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.jaar        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inhoudingOfVermissing.inOnderzoek.datumIngangOnderzoek.maand       |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.geheimhoudingPersoonsgegevens                               |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding                                       |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.opschortingBijhouding.datum                                 |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding.datum.type                            |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.opschortingBijhouding.datum.datum                           |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding.datum.langFormaat                     |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.opschortingBijhouding.datum.onbekend                        |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding.datum.jaar                            |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.opschortingBijhouding.datum.maand                           |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding.reden                                 |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.opschortingBijhouding.reden.code                            |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.opschortingBijhouding.reden.omschrijving                    |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.inOnderzoek                                                 |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.inOnderzoek.burgerservicenummer                             |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.inOnderzoek.datumIngangOnderzoek                            |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.inOnderzoek.datumIngangOnderzoek.type                       |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.inOnderzoek.datumIngangOnderzoek.datum                      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.inOnderzoek.datumIngangOnderzoek.langFormaat                |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.inOnderzoek.datumIngangOnderzoek.onbekend                   |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | houder.inOnderzoek.datumIngangOnderzoek.jaar                       |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | houder.inOnderzoek.datumIngangOnderzoek.maand                      |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek                                                        |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inOnderzoek.reisdocumentnummer                                     |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek.soort                                                  |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inOnderzoek.datumEindeGeldigheid                                   |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek.datumIngangOnderzoek                                   |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inOnderzoek.datumIngangOnderzoek.type                              |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek.datumIngangOnderzoek.datum                             |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inOnderzoek.datumIngangOnderzoek.langFormaat                       |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek.datumIngangOnderzoek.onbekend                          |
  | ZoekMetBurgerservicenummer     | burgerservicenummer | 999999321        | inOnderzoek.datumIngangOnderzoek.jaar                              |
  | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | inOnderzoek.datumIngangOnderzoek.maand                             |

