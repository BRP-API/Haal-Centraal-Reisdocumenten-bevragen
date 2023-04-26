#language: nl

Functionaliteit: Zoek met burgerservicenummer - fout cases

Rule: De burgerservicenummer parameter is een verplichte parameter

  @fout-case
  Scenario: De burgerservicenummer parameter is niet opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | reisdocumentnummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |


Rule: Een burgerservicenummer is een string bestaande uit exact 9 cijfers

  @fout-case
  Abstract Scenario: <titel>
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | <burgerservicenummer>      |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | reisdocumentnummer         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                | reason                                      |
    | pattern | burgerservicenummer | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

    Voorbeelden:
    | burgerservicenummer | titel                                                                       |
    | 12345678            | De opgegeven burgerservicenummer is een string met minder dan negen cijfers |
    | 1234567890          | De opgegeven burgerservicenummer is een string met meer dan negen cijfers   |
    | 12345678X           | De opgegeven burgerservicenummer is een string met een letter               |


Rule: De gemeenteVanInschrijving parameter is een verplichte parameter

  @fout-case
  Scenario: De gemeenteVanInschrijving parameter is niet opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                | waarde                     |
    | type                | ZoekMetBurgerservicenummer |
    | burgerservicenummer | 123456789                  |
    | fields              | reisdocumentnummer         |
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
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 123456789                  |
    | gemeenteVanInschrijving | <gemeenteVanInschrijving>  |
    | fields                  | reisdocumentnummer         |
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
    | 123X                    | De opgegeven gemeenteVanInschrijving is een string met een letter              |
    | 12.4                    | De opgegeven gemeenteVanInschrijving bevat niet-cijfer                         |

Rule: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt

  @fout-case
  Abstract Scenario: <titel>
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 123456789                  |
    | gemeenteVanInschrijving | 0800                       |
    | <parameter>             | <waarde>                   |
    | fields                  | reisdocumentnummer         |
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
    | titel                                     | parameter          | waarde    |
    | zoeken met parameter uit ander zoektype   | reisdocumentnummer | AB1234567 |
    | zoeken met niet gespecificeerde parameter | geslachtsnaam      | Jansen    |
