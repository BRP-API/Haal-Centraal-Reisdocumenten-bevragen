#language: nl

Functionaliteit: Reisdocument velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                                 | waarde    |
    | soort reisdocument (35.10)                           | PN        |
    | nummer reisdocument (35.20)                          | NE3663258 |
    | datum einde geldigheid reisdocument (35.50)          | 20240506  |
    | datum inhouding/vermissing reisdocument (35.60)      | 20230405  |
    | aanduiding inhouding/vermissing reisdocument (35.70) | I         |

  Scenario: 'nummer reisdocument (35.20)' wordt gevraagd met field pad 'reisdocumentnummer'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | reisdocumentnummer             |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |

  Abstract Scenario: 'soort reisdocument (35.10)' wordt gevraagd met field pad '<field>'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | <field>                        |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam               | waarde             |
    | soort.code         | PN                 |
    | soort.omschrijving | Nationaal paspoort |

    Voorbeelden:
    | field              |
    | soort              |
    | soort.code         |
    | soort.omschrijving |

  Abstract Scenario: 'datum einde geldigheid reisdocument (35.50)' wordt gevraagd met field pad '<field>'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | <field>                        |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam                             | waarde     |
    | datumEindeGeldigheid.type        | Datum      |
    | datumEindeGeldigheid.datum       | 2024-05-06 |
    | datumEindeGeldigheid.langFormaat | 6 mei 2024 |

    Voorbeelden:
    | field                            |
    | datumEindeGeldigheid             |
    | datumEindeGeldigheid.type        |
    | datumEindeGeldigheid.datum       |
    | datumEindeGeldigheid.jaar        |
    | datumEindeGeldigheid.maand       |
    | datumEindeGeldigheid.onbekend    |
    | datumEindeGeldigheid.langFormaat |

  Abstract Scenario: 'datum inhouding/vermissing reisdocument (35.60)' wordt gevraagd met field pad 'inhoudingOfVermissing.<field>'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | inhoudingOfVermissing.<field>  |
    Dan heeft de response een 'reisdocument' met de volgende 'inhoudingOfVermissing' gegevens
    | naam              | waarde       |
    | datum.type        | Datum        |
    | datum.datum       | 2023-04-05   |
    | datum.langFormaat | 5 april 2023 |

    Voorbeelden:
    | field             |
    | datum             |
    | datum.type        |
    | datum.datum       |
    | datum.jaar        |
    | datum.maand       |
    | datum.onbekend    |
    | datum.langFormaat |

  Abstract Scenario: 'aanduiding inhouding/vermissing reisdocument (35.70)' wordt gevraagd met field pad 'inhoudingOfVermissing.<field>'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | inhoudingOfVermissing.<field>  |
    Dan heeft de response een 'reisdocument' met de volgende 'inhoudingOfVermissing' gegevens
    | naam               | waarde                   |
    | soort.code         | I                        |
    | soort.omschrijving | ingehouden of ingeleverd |

    Voorbeelden:
    | field                   |
    | aanduiding              |
    | aanduiding.code         |
    | aanduiding.omschrijving |

  Scenario: 'burgerservicenummer' van houder wordt gevraagd met field pad 'houder.burgerservicenummer'
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | houder.burgerservicenummer     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
