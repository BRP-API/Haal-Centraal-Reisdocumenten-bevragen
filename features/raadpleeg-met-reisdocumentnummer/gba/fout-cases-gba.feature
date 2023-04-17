#language: nl

@gba
Functionaliteit: Raadpleeg met reisdocumentnummer - fout cases

Rule: De reisdocumentnummer parameter is een verplichte parameter

  @fout-case
  Scenario: De reisdocumentnummer parameter is niet opgegeven
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer.          |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name               | reason                  |
    | required | reisdocumentnummer | Parameter is verplicht. |

Rule: De reisdocumentnummer parameter bevat een lijst met minimaal één reisdocumentnummer

  @fout-case
  Abstract Scenario: De reisdocumentnummer parameter bevat een lege lijst
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      |                                |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer.          |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name               | reason                          |
    | minItems | reisdocumentnummer | Array bevat minder dan 1 items. |

Rule: Een reisdocumentnummer is een string bestaande uit exact 9 cijfers en hoofdletters

  @fout-case
  Abstract Scenario: <titel>
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | <reisdocumentnummers>          |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer[0].       |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                  | reason                                         |
    | pattern | reisdocumentnummer[0] | Waarde voldoet niet aan patroon ^[A-Z0-9]{9}$. |

    Voorbeelden:
    | reisdocumentnummers        | titel                                                                            |
    | 12345678                   | De opgegeven reisdocumentnummer is een string met minder dan negen cijfers       |
    | 1234567890                 | De opgegeven reisdocumentnummer is een string met meer dan negen cijfers         |
    | ABCDEFGHi                  | De opgegeven reisdocumentnummer is een string met één of meerdere kleine letters |
    | <script>ABCDE6789</script> | De opgegeven reisdocumentnummer bevat niet-cijfer en niet-hoofdletter karakters  |

Rule: De reisdocumentnummer parameter bevat een lijst van maximaal 1 reisdocumentnummer

  @fout-case
  Scenario: De reisdocumentnummer parameter bevat meer dan 1 reisdocumentnummer
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | AB1234567,BC8901234            |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: reisdocumentnummer.          |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name               | reason                        |
    | maxItems | reisdocumentnummer | Array bevat meer dan 1 items. |

Rule: De gemeenteVanInschrijving parameter is een verplichte parameter

  @fout-case
  Scenario: De gemeenteVanInschrijving parameter is niet opgegeven
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                    | reason                  |
    | required | gemeenteVanInschrijving | Parameter is verplicht. |

Rule: Een gemeenteVanInschrijving is een string bestaande uit exact 4 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | <gemeenteVanInschrijving>      |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                    | reason                                      |
    | pattern | gemeenteVanInschrijving | Waarde voldoet niet aan patroon ^[0-9]{4}$. |

    Voorbeelden:
    | gemeenteVanInschrijving | titel                                                                          |
    | 123                     | De opgegeven gemeenteVanInschrijving is een string met minder dan vier cijfers |
    | 12345                   | De opgegeven gemeenteVanInschrijving is een string met meer dan vier cijfers   |
    | 123O                    | De opgegeven gemeenteVanInschrijving is een string met een letter              |
    | 12.4                    | De opgegeven gemeenteVanInschrijving bevat niet-cijfer                         |
