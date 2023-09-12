#language: nl

@gba
Functionaliteit: ZoekMetBurgerservicenummer van persoonslijst met opschorting bijhouding


Rule: Een reisdocument op een persoonslijst met reden opschorting bijhouding "W" (wissen) wordt niet geleverd

    Abstract Scenario: persoonslijst heeft opschorting bijhouding reden "W" en <fields> van het reisdocument wordt gevraagd
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | W                                    |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE3663258 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | <fields>                   |
      Dan heeft de response 0 reisdocumenten

      Voorbeelden:
      | fields                     |
      | reisdocumentnummer         |
      | soort                      |
      | houder.burgerservicenummer |

    Scenario: persoonslijst heeft opschorting bijhouding reden "W" en zelfde reisdocumentnummer is gebruikt op andere persoonslijst
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | W                                    |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE3663258 |
      En de persoon met burgerservicenummer '000000024' heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE8372664 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NE8372664 |


Rule: opschortingBijhouding wordt automatisch geleverd indien van toepassing

    Abstract Scenario: 'reden opschorting bijhouding (67.20)' met waarde '<opschorting>'
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230402                             | <opschorting>                        |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE3663258 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | houder.burgerservicenummer |
      Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
      | naam                                     | waarde         |
      | burgerservicenummer                      | 000000024      |
      | opschortingBijhouding.reden.code         | <opschorting>  |
      | opschortingBijhouding.reden.omschrijving | <omschrijving> |
      | opschortingBijhouding.datum              | 20230402       |

      Voorbeelden:
      | opschorting | omschrijving              |
      | O           | overlijden                |
      | E           | emigratie                 |
      | M           | ministerieel besluit      |
      | R           | pl is aangelegd in de rni |
      | F           | fout                      |
      | .           | onbekend                  |

    Abstract Scenario: Opschorting bijhouding wordt geleverd wanneer met fields is gevraagd om '<fields>'
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230402                             | O                                    |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | NE3663258 |
      | datum einde geldigheid reisdocument (35.50) | 20320506  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | <fields>                   |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam     | waarde     |
      | <veld 1> | <waarde 1> |
      | <veld 2> | <waarde 2> |
      En heeft het 'reisdocument' de volgende 'houder' gegevens
      | naam                                     | waarde     |
      | opschortingBijhouding.reden.code         | O          |
      | opschortingBijhouding.reden.omschrijving | overlijden |
      | opschortingBijhouding.datum              | 20230402   |

      Voorbeelden:
      | fields                           | veld 1                | waarde 1  | veld 2             | waarde 2           |
      | reisdocumentnummer               | reisdocumentnummer    | NE3663258 |                    |                    |
      | soort                            | soort.code            | PN        | soort.omschrijving | Nationaal paspoort |
      | datumEindeGeldigheid             | datumEindeGeldigheid  | 20320506  |                    |                    |
      | inhoudingOfVermissing.datum      | inhoudingOfVermissing |           |                    |                    |
      | inhoudingOfVermissing.aanduiding | inhoudingOfVermissing |           |                    |                    |
