#language: nl

@proxy
Functionaliteit: Raadpleeg met reisdocumentnummer

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) |
    | 0800                 |
    En de persoon met burgerservicenummer '000000152' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |

Regel: voor het raadplegen van een reisdocument moet het reisdocumentnummer worden opgegeven

  Scenario: Raadpleeg een reisdocument
    Gegeven de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | reisdocumentnummer,houder      |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |
    En heeft het reisdocument de volgende 'houder' gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

  @geen-protocollering
  Scenario: Raadpleeg een niet bestaand reisdocument
    Gegeven de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663259                      |
    | fields             | reisdocumentnummer,houder      |
    Dan heeft de response 0 reisdocumenten

Regel: als een gevraagde veld in onderzoek is, dan wordt het bijbehorend inOnderzoek veld en datumIngangOnderzoek ook geleverd

  Scenario: 'soort reisdocument (35.10)' is in onderzoek en wordt gevraagd
    Gegeven de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    | aanduiding in onderzoek (83.10)             | 123510    |
    | datum ingang onderzoek (83.20)              | 20230201  |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | reisdocumentnummer,soort       |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam                                         | waarde             |
    | reisdocumentnummer                           | NE3663258          |
    | soort.code                                   | PN                 |
    | soort.omschrijving                           | Nationaal paspoort |
    | inOnderzoek.soort                            | true               |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum              |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2023-02-01         |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 februari 2023    |

  Scenario: 'soort reisdocument (35.10)' is in onderzoek en wordt niet gevraagd
    Gegeven de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    | aanduiding in onderzoek (83.10)             | 123510    |
    | datum ingang onderzoek (83.20)              | 20230201  |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam               | waarde                         |
    | type               | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer | NE3663258                      |
    | fields             | reisdocumentnummer             |
    Dan heeft de response een reisdocument met de volgende gegevens
    | naam               | waarde    |
    | reisdocumentnummer | NE3663258 |
