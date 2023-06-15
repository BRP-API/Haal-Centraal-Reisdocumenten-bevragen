#language: nl

Functionaliteit: Raadpleeg met reisdocumentnummer - fout cases

Rule: De reisdocumentnummer parameter is een verplichte parameter

  @fout-case
  Scenario: De reisdocumentnummer parameter is niet opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam   | waarde                         |
    | type   | RaadpleegMetReisdocumentnummer |
    | fields | reisdocumentnummer             |
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
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer |                                |
    | fields             | reisdocumentnummer             |
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
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | <reisdocumentnummers>          |
    | fields             | reisdocumentnummer             |
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
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | AB1234567,BC8901234            |
    | fields             | reisdocumentnummer             |
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

Rule: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt

  @fout-case
  Abstract Scenario: <titel>
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | AB1234567                      |
    | <parameter>             | <waarde>                       |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code         | name        | reason                      |
    | unknownParam | <parameter> | Parameter is niet verwacht. |

    Voorbeelden:
    | titel                                     | parameter           | waarde    |
    | zoeken met parameter uit ander zoektype   | burgerservicenummer | 123456789 |
    | zoeken met niet gespecificeerde parameter | geslachtsnaam       | Jansen    |
