#language: nl

Functionaliteit: Fout cases bij zoeken en raadplegen van reisdocumenten

Rule: Er moet een valide zoek type worden opgegeven

  @fout-case
  Scenario: er zijn geen parameters opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam | waarde |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: de 'type' parameter is niet opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: een <omschrijving> is opgegeven als 'type' waarde
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam | waarde   |
    | type | <waarde> |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

    Voorbeelden:
    | omschrijving                          | waarde                     |
    | lege string                           |                            |
    | onbekend zoek type                    | ZoekMetGeslachtsnaam       |
    | geldig zoek type met verkeerde casing | zoekmetburgerservicenummer |