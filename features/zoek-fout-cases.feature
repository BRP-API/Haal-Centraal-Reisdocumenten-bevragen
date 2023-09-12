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
    | naam | waarde      |
    | type | <zoek type> |
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
    | omschrijving                          | zoek type                  |
    | lege string                           |                            |
    | onbekend zoek type                    | ZoekMetGeslachtsnaam       |
    | geldig zoek type met verkeerde casing | zoekmetburgerservicenummer |

Rule: Voor de response body wordt als content type en charset respectievelijk alleen application/json en utf-8 ondersteund

  @fout-case
  Abstract Scenario: 'application/xml' is opgegeven als Accept content type
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam             | waarde             |
    | type             | <zoek type>        |
    | <naam parameter> | <waarde parameter> |
    | fields           | reisdocumentnummer |
    | header: Accept   | application/xml    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde content type wordt niet ondersteund.              |
    | detail   | Ondersteunde content type: application/json; charset=utf-8. |
    | code     | notAcceptable                                               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |

  Abstract Scenario: '<accept media type>' wordt opgegeven als Accept content type
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                | waarde                     |
    | type                | ZoekMetBurgerservicenummer |
    | burgerservicenummer | 000000024                  |
    | fields              | houder.burgerservicenummer |
    | header: Accept      | <accept media type>        |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter | accept media type               |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | */*                             |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | */*; charset=utf-8              |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | */*;charset=utf-8               |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json                |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/json; charset=utf-8 |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json;charset=utf-8  |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | */*;charset=UTF-8               |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json;charset=Utf-8  |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/json; charset=UTF-8 |

Rule: Voor de response body is application/json de default Accept waarde en is utf-8 de default charset waarde

  Abstract Scenario: Er is geen Accept header met waarde opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam             | waarde                     |
    | type             | <zoek type>                |
    | <naam parameter> | <waarde parameter>         |
    | fields           | houder.burgerservicenummer |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        |

  Abstract Scenario: Er is een lege waarde opgegeven voor de Accept header
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam             | waarde                     |
    | type             | <zoek type>                |
    | <naam parameter> | <waarde parameter>         |
    | fields           | houder.burgerservicenummer |
    | header: Accept   |                            |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        |

Rule: Voor de request body wordt als content type en charset respectievelijk alleen application/json en utf-8 ondersteund

  @fout-case
  Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                 | waarde             |
    | type                 | <zoek type>        |
    | <naam parameter>     | <waarde parameter> |
    | fields               | reisdocumentnummer |
    | header: Content-Type | <media type>       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
    | title    | Media Type wordt niet ondersteund.                           |
    | detail   | Ondersteunde content type: application/json; charset=utf-8.  |
    | code     | unsupportedMediaType                                         |
    | status   | 415                                                          |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten              |

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter | media type                       |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/xml                  |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | text/csv                         |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/json; charset=cp1252 |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | */*                              |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | */*; charset=utf-8               |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | */*;charset=utf-8                |

  Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | <zoek type>                |
    | <naam parameter>        | <waarde parameter>         |
    | fields                  | houder.burgerservicenummer |
    | header: Content-Type    | <media type>               |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter | media type                      |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json                |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/json;charset=utf-8  |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json; charset=utf-8 |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        | application/json;charset=Utf-8  |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        | application/json; charset=UTF-8 |

Rule: Voor de request body is application/json de default Content-Type waarde en is utf-8 de default charset waarde

  Abstract Scenario: Er is geen Content-Type header met waarde opgegeven
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam             | waarde                     |
    | type             | <zoek type>                |
    | <naam parameter> | <waarde parameter>         |
    | fields           | houder.burgerservicenummer |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        |

  Abstract Scenario: Er is een lege waarde opgegeven voor de Content-Type header
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                 | waarde                     |
    | type                 | <zoek type>                |
    | <naam parameter>     | <waarde parameter>         |
    | fields               | houder.burgerservicenummer |
    | header: Content-Type |                            |
    Dan heeft de response 0 reisdocumenten

    Voorbeelden:
    | zoek type                      | naam parameter      | waarde parameter |
    | RaadpleegMetReisdocumentnummer | reisdocumentnummer  | NE3663258        |
    | ZoekMetBurgerservicenummer     | burgerservicenummer | 000000024        |

Rule: Om privacy en security redenen moet een bevraging van reisdocumenten worden gedaan met behulp van de POST aanroep

  @fout-case
  Abstract Scenario: reisdocumenten wordt gezocht met een '<aanroep type>' aanroep
    Als reisdocumenten wordt gezocht met een '<aanroep type>' aanroep
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.5 |
    | title    | Gebruikte bevragingsmethode is niet toegestaan.             |
    | status   | 405                                                         |
    | code     | methodNotAllowed                                            |
    | instance | /haalcentraal/api/reisdocumenten/reisdocumenten             |

    Voorbeelden:
    | aanroep type |
    | GET          |
    | PUT          |
    | PATCH        |
    | DELETE       |
  # | CONNECT      | een CONNECT aanroep wordt niet gebruikt om te bevragen
  # | HEAD         | een HEAD response bevat geen body
    | OPTIONS      |
    | TRACE        |
