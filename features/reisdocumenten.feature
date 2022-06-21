# language: nl

Functionaliteit: Raadplegen van reisdocumenten op basis van een reisdocumentnummer
  Met het reisdocumentnummer als sleutel kan een reisdocument van een ingeschreven persoon worden geraadpleegd.

  In de resource ingeschrevenpersonen wordt een lijst van alle geldige reisdocumentnummers opgenomen.

  Scenario: gezochte reisdocument is geldig
    Gegeven het systeem heeft een reisdocument met de volgende gegevens
    | naam                           | waarde                          |
    | reisdocumentnummer             | 627947117                       |
    | soortReisdocument.code         | NI                              |
    | soortReisdocument.omschrijving | Nederlandse identiteitskaart    |
    | datumUitgifte                  | 20171102                        |
    | autoriteitAfgifte.code         | BI0518                          |
    | autoriteitAfgifte.omschrijving | Minister van Binnenlandse Zaken |
    | datumEindeGeldigheid           | 20271101                        |
    | burgerservicenummer            | 999999011                       |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde    |
    | reisdocumentnummer | 627947117 |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam                             | waarde                          |
    | reisdocumentnummer               | 627947117                       |
    | soortReisdocument.code           | NI                              |
    | soortReisdocument.omschrijving   | Nederlandse identiteitskaart    |
    | autoriteitAfgifte.code           | BI0518                          |
    | autoriteitAfgifte.omschrijving   | Minister van Binnenlandse Zaken |
    | datumUitgifte.type               | Datum                           |
    | datumUitgifte.datum              | 2017-11-02                      |
    | datumUitgifte.langFormaat        | 2 november 2017                 |
    | datumEindeGeldigheid.type        | Datum                           |
    | datumEindeGeldigheid.datum       | 2027-11-01                      |
    | datumEindeGeldigheid.langFormaat | 1 november 2027                 |
    | burgerservicenummer              | 999999011                       |

  Scenario: gezochte reisdocument is vermist
    Gegeven het systeem heeft een reisdocument met de volgende gegevens
    | naam                                 | waarde    |
    | reisdocumentnummer                   | 882936846 |
    | datumInhoudingOfVermissing           | 20110405  |
    | aanduidingInhoudingOfVermissing.code | V         |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde    |
    | reisdocumentnummer | 882936846 |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam                                   | waarde       |
    | reisdocumentnummer                     | 882936846    |
    | datumInhoudingOfVermissing.type        | Datum        |
    | datumInhoudingOfVermissing.datum       | 2011-04-05   |
    | datumInhoudingOfVermissing.langFormaat | 5 april 2011 |
    | aanduidingInhoudingOfVermissing.code   | V            |

  @fout-case
  Scenario: zoek met leeg reisdocumentnummer
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde |
    | reisdocumentnummer |        |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer.          |
    | code     | paramsCombination                                           |
    | instance | /reisdocumenten                                             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name               | reason                  |
    | required | reisdocumentnummer | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: zoek met invalide reisdocumentnummer
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde               |
    | reisdocumentnummer | <reisdocumentnummer> |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer.          |
    | code     | paramsCombination                                           |
    | instance | /reisdocumenten                                             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name               | reason                                            |
    | pattern | reisdocumentnummer | Waarde voldoet niet aan patroon ^[a-zA-Z0-9]{9}$. |

    Voorbeelden:
    | reisdocumentnummer           | toelichting                                       |
    | <script>hello world</script> | reisdocumentnummer bevat ongeldige karakters      |
    | abc123AB                     | reisdocumentnummer is minder dan 9 karakters lang |
    | abcd1234AB                   | reisdocumentnummer is meer dan 9 karakters lang   |