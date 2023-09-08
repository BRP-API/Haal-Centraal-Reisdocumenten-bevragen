#language: nl

Functionaliteit: RaadpleegMetReisdocumentnummer van persoonslijst met opschorting bijhouding

  Rule: opschortingBijhouding wordt automatisch geleverd indien van toepassing

    Abstract Scenario: 'reden opschorting bijhouding (67.20)' met waarde '<opschorting>'
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220829                             | <opschorting>                        |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | PN        |
      | nummer reisdocument (35.20) | NE3663258 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam               | waarde                         |
      | type               | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer | NE3663258                      |
      | fields             | houder.burgerservicenummer     |
      Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
      | naam                                     | waarde           |
      | burgerservicenummer                      | 000000024        |
      | opschortingBijhouding.reden.code         | <opschorting>    |
      | opschortingBijhouding.reden.omschrijving | <omschrijving>   |
      | opschortingBijhouding.datum.type         | Datum            |
      | opschortingBijhouding.datum .datum       | 2022-08-29       |
      | opschortingBijhouding.langFormaat        | 29 augustus 2022 |

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
      | naam                                                                    | waarde    |
      | soort reisdocument (35.10)                                              | PN        |
      | nummer reisdocument (35.20)                                             | NE3663258 |
      | datum einde geldigheid reisdocument (35.50)                             | 20240506  |
      | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20230305  |
      | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) | I         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam               | waarde                         |
      | type               | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer | NE3663258                      |
      | fields             | <fields>                       |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam     | waarde     |
      | <veld 1> | <waarde 1> |
      | <veld 2> | <waarde 2> |
      En heeft het 'reisdocument' de volgende 'houder' gegevens
      | naam                                     | waarde       |
      | opschortingBijhouding.reden.code         | O            |
      | opschortingBijhouding.reden.omschrijving | overlijden   |
      | opschortingBijhouding.datum.type         | Datum        |
      | opschortingBijhouding.datum .datum       | 2023-04-02   |
      | opschortingBijhouding.langFormaat        | 2 april 2023 |

      Voorbeelden:
      | fields                           | veld 1                                | waarde 1  | veld 2                                        | waarde 2                 |
      | reisdocumentnummer               | reisdocumentnummer                    | NE3663258 |                                               |                          |
      | soort                            | soort.code                            | PN        | soort.omschrijving                            | Nationaal paspoort       |
      | inhoudingOfVermissing.aanduiding | inhoudingOfVermissing.aanduiding.code | I         | inhoudingOfVermissing.aanduiding.omschrijving | ingehouden of ingeleverd |
