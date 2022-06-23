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

  Rule: een reisdocumentnummer wordt niet opgenomen wanneer Datum einde geldigheid Nederlands reisdocument (35.50) vandaag is of in het verleden ligt
    - een reisdocument wordt alleen opgenomen wanneer Datum einde geldigheid Nederlands reisdocument leeg is, volledig onbekend is of in de toekommst ligt
    - wanneer alleen het jaar en de maand van Datum einde geldigheid Nederlands reisdocument bekend zijn, beschouwen we het reisdocument de hele maand als geldig
    - wanneer alleen het jaar van Datum einde geldigheid Nederlands reisdocument bekend is, beschouwen we het reisdocument het hele jaar als geldig

    @gba
    Abstract Scenario: Reisdocument heeft <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                                   | waarde             |
      | Soort Nederlands reisdocument (35.10)                  | NI                 |
      | Nummer Nederlands reisdocument (35.20)                 | NiK26q9aH          |
      | Datum uitgifte Nederlands reisdocument (35.30)         | 20190314           |
      | Autoriteit van afgifte Nederlands reisdocument (35.40) | B0518              |
      | Datum einde geldigheid Nederlands reisdocument (35.50) | <einde geldigheid> |
      Als personen op '5 juni 2022' wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | reisdocumentnummers             |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | reisdocumentnummers | NiK26q9aH |

      Voorbeelden:
      | titel                                                  | einde geldigheid |
      | einde geldigheid is morgen                             | 20220606         |
      | einde geldigheid is volledig onbekend                  | 00000000         |
      | einde geldigheid is dit jaar - maand en dag onbekend   | 20220000         |
      | einde geldigheid is deze maand - dag onbekend          | 20220600         |
      | geen einde geldigheid                                  |                  |

    @gba
    Abstract Scenario: Reisdocument heeft <titel>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                                   | waarde             |
      | Soort Nederlands reisdocument (35.10)                  | NI                 |
      | Nummer Nederlands reisdocument (35.20)                 | NiK26q9aH          |
      | Datum uitgifte Nederlands reisdocument (35.30)         | 20190314           |
      | Autoriteit van afgifte Nederlands reisdocument (35.40) | B0518              |
      | Datum einde geldigheid Nederlands reisdocument (35.50) | <einde geldigheid> |
      Als personen op '5 juni 2022' wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 555550002                               |
      | fields              | burgerservicenummer,reisdocumentnummers |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

      Voorbeelden:
      | titel                                                  | einde geldigheid |
      | einde geldigheid is gisteren                           | 20220606         |
      | einde geldigheid is vandaag                            | 20220605         |
      | einde geldigheid is volledig onbekend                  | 00000000         |
      | einde geldigheid is vorig jaar - maand en dag onbekend | 20210000         |
      | einde geldigheid is vorige maand - dag onbekend        | 20220500         |

  Rule: een reisdocumentnummer wordt niet opgenomen wanneer Aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) een waarde heeft
    - standaardwaarde "." beschouwen we hier als een waarde: het reisdocument wordt dan niet opgenomen

    @gba
    Abstract Scenario: Reisdocument heeft aanduiding inhouding <inhouding omschrijving>
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                    | waarde           |
      | Soort Nederlands reisdocument (35.10)                                   | NI               |
      | Nummer Nederlands reisdocument (35.20)                                  | NiK26q9aH        |
      | Datum uitgifte Nederlands reisdocument (35.30)                          | 20190314         |
      | Autoriteit van afgifte Nederlands reisdocument (35.40)                  | B0518            |
      | Datum einde geldigheid Nederlands reisdocument (35.50)                  | 20340314         |
      | Aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) | <inhouding code> |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                                  |
      | type                | RaadpleegMetBurgerservicenummer         |
      | burgerservicenummer | 555550003                               |
      | fields              | burgerservicenummer,reisdocumentnummers |
      Dan heeft de response een persoon met alleen de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

      Voorbeelden:
      | inhouding code | inhouding omschrijving   |
      | I              | ingehouden, ingeleverd   |
      | R              | van rechtswege vervallen |
      | V              | vermist                  |
      | .              | onbekend                 |
