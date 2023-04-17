#language: nl

@gba
Functionaliteit: Reisdocument velden vragen met fields

  Achtergrond:
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                                                    | waarde    |
    | soort reisdocument (35.10)                                              | PN        |
    | nummer reisdocument (35.20)                                             | NE3663258 |
    | datum einde geldigheid reisdocument (35.50)                             | 20240506  |
    | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20230405  |
    | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) | I         |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |

  Scenario: 'nummer reisdocument (35.20)' wordt gevraagd met field pad 'reisdocumentnummer'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | reisdocumentnummer             |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |

  Abstract Scenario: 'soort reisdocument (35.10)' wordt gevraagd met field pad '<field>'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | <field>                        |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam               | waarde             |
    | soort.code         | PN                 |
    | soort.omschrijving | Nationaal paspoort |

    Voorbeelden:
    | field              |
    | soort              |
    | soort.code         |
    | soort.omschrijving |

  Abstract Scenario: 'datum einde geldigheid reisdocument (35.50)' wordt gevraagd met field pad '<field>'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | <field>                        |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam                 | waarde   |
    | datumEindeGeldigheid | 20240506 |

    Voorbeelden:
    | field                            |
    | datumEindeGeldigheid             |
    | datumEindeGeldigheid.type        |
    | datumEindeGeldigheid.datum       |
    | datumEindeGeldigheid.jaar        |
    | datumEindeGeldigheid.maand       |
    | datumEindeGeldigheid.onbekend    |
    | datumEindeGeldigheid.langFormaat |

  Abstract Scenario: 'datum inhouding dan wel vermissing Nederlands reisdocument (35.60)' wordt gevraagd met field pad 'inhoudingOfVermissing.<field>'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | inhoudingOfVermissing.<field>  |
    Dan heeft de response een 'reisdocument' met de volgende 'inhoudingOfVermissing' gegevens
    | naam  | waarde   |
    | datum | 20230405 |

    Voorbeelden:
    | field             |
    | datum             |
    | datum.type        |
    | datum.datum       |
    | datum.jaar        |
    | datum.maand       |
    | datum.onbekend    |
    | datum.langFormaat |

  Abstract Scenario: 'aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70)' wordt gevraagd met field pad 'inhoudingOfVermissing.<field>'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | inhoudingOfVermissing.<field>  |
    Dan heeft de response een 'reisdocument' met de volgende 'inhoudingOfVermissing' gegevens
    | naam                    | waarde                   |
    | aanduiding.code         | I                        |
    | aanduiding.omschrijving | ingehouden of ingeleverd |

    Voorbeelden:
    | field                   |
    | aanduiding              |
    | aanduiding.code         |
    | aanduiding.omschrijving |

  Scenario: 'burgerservicenummer' van houder wordt gevraagd met field pad 'houder.burgerservicenummer'
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | houder.burgerservicenummer     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |
