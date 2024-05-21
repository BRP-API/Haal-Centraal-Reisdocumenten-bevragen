#language: nl

@proxy
Functionaliteit: ZoekMetBurgerservicenummer van persoonslijst met opschorting bijhouding

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) |
    | 0800                 |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |

Regel: opschortingBijhouding wordt automatisch geleverd indien van toepassing

    Abstract Scenario: 'reden opschorting bijhouding (67.20)' met waarde '<opschorting>'
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230402                             | <opschorting>                        |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE3663258 |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | houder.burgerservicenummer |
      Dan heeft de response een reisdocument met de volgende 'houder' gegevens
      | naam                                     | waarde         |
      | burgerservicenummer                      | 000000024      |
      | opschortingBijhouding.reden.code         | <opschorting>  |
      | opschortingBijhouding.reden.omschrijving | <omschrijving> |
      | opschortingBijhouding.datum.type         | Datum          |
      | opschortingBijhouding.datum.datum        | 2023-04-02     |
      | opschortingBijhouding.datum.langFormaat  | 2 april 2023   |

      Voorbeelden:
      | opschorting | omschrijving              |
      | O           | overlijden                |
      | E           | emigratie                 |
      | M           | ministerieel besluit      |
      | R           | pl is aangelegd in de rni |
      | .           | onbekend                  |

    Abstract Scenario: Opschorting bijhouding wordt geleverd wanneer met fields is gevraagd om '<fields>'
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230402                             | O                                    |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | NE3663258 |
      | datum einde geldigheid reisdocument (35.50) | 20320506  |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | <fields>                   |
      Dan heeft de response een reisdocument met de volgende gegevens
      | naam     | waarde     |
      | <veld 1> | <waarde 1> |
      | <veld 2> | <waarde 2> |
      | <veld 3> | <waarde 3> |
      En heeft het reisdocument de volgende 'houder' gegevens
      | naam                                     | waarde       |
      | opschortingBijhouding.reden.code         | O            |
      | opschortingBijhouding.reden.omschrijving | overlijden   |
      | opschortingBijhouding.datum.type         | Datum        |
      | opschortingBijhouding.datum.datum        | 2023-04-02   |
      | opschortingBijhouding.datum.langFormaat  | 2 april 2023 |

      Voorbeelden:
      | fields                           | veld 1                    | waarde 1  | veld 2                     | waarde 2           | veld 3                           | waarde 3   |
      | reisdocumentnummer               | reisdocumentnummer        | NE3663258 |                            |                    |                                  |            |
      | soort                            | soort.code                | PN        | soort.omschrijving         | Nationaal paspoort |                                  |            |
      | datumEindeGeldigheid             | datumEindeGeldigheid.type | Datum     | datumEindeGeldigheid.datum | 2032-05-06         | datumEindeGeldigheid.langFormaat | 6 mei 2032 |
      | inhoudingOfVermissing.datum      | inhoudingOfVermissing     |           |                            |                    |                                  |            |
      | inhoudingOfVermissing.aanduiding | inhoudingOfVermissing     |           |                            |                    |                                  |            |
