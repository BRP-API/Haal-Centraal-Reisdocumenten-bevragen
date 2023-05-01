#language: nl

Functionaliteit: Reisdocument velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en de velden reisdocumentnummer, soort en datumEindeGeldigheid worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                                                    | waarde                    |
    | soort reisdocument (35.10)                                              | PN                        |
    | nummer reisdocument (35.20)                                             | NE3663258                 |
    | datum einde geldigheid reisdocument (35.50)                             | 20240506                  |
    | aanduiding in onderzoek (83.10)                                         | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)                                          | 20230506                  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                                        |
    | type                    | ZoekMetBurgerservicenummer                    |
    | burgerservicenummer     | 000000152                                     |
    | gemeenteVanInschrijving | 0800                                          |
    | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam                                         | waarde                      |
    | reisdocumentnummer                           | NE3663258                   |
    | soort.code                                   | PN                          |
    | soort.omschrijving                           | Nationaal paspoort          |
    | datumEindeGeldigheid.type                    | Datum                       |
    | datumEindeGeldigheid.datum                   | 2024-05-06                  |
    | datumEindeGeldigheid.langFormaat             | 6 mei 2024                  |
    | inOnderzoek.reisdocumentnummer               | <reisdocumentnummer io>     |
    | inOnderzoek.soort                            | <soort reisdocument io>     |
    | inOnderzoek.datumEindeGeldigheid             | <datum einde geldigheid io> |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2023-05-06                  |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 6 mei 2023                  |

    Voorbeelden:
    | aanduiding in onderzoek | reisdocumentnummer io | soort reisdocument io | datum einde geldigheid io | type                                           |
    | 120000                  | true                  | true                  | true                      | hele categorie reisdocument                    |
    | 123500                  | true                  | true                  | true                      | hele groep Nederlands reisdocument             |
    | 123510                  |                       | true                  |                           | soort Nederlands reisdocument                  |
    | 123520                  | true                  |                       |                           | nummer Nederlands reisdocument                 |
    | 123550                  |                       |                       | true                      | datum einde geldigheid Nederlands reisdocument |

  Abstract Scenario: '<type>' is in onderzoek en de velden reisdocumentnummer, soort en datumEindeGeldigheid worden gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                                                    | waarde                    |
    | soort reisdocument (35.10)                                              | PN                        |
    | nummer reisdocument (35.20)                                             | NE3663258                 |
    | datum einde geldigheid reisdocument (35.50)                             | 20240506                  |
    | aanduiding in onderzoek (83.10)                                         | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)                                          | 20230506                  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                                        |
    | type                    | ZoekMetBurgerservicenummer                    |
    | burgerservicenummer     | 000000152                                     |
    | gemeenteVanInschrijving | 0800                                          |
    | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam                             | waarde             |
    | reisdocumentnummer               | NE3663258          |
    | soort.code                       | PN                 |
    | soort.omschrijving               | Nationaal paspoort |
    | datumEindeGeldigheid.type        | Datum              |
    | datumEindeGeldigheid.datum       | 2024-05-06         |
    | datumEindeGeldigheid.langFormaat | 6 mei 2024         |

    Voorbeelden:
    | aanduiding in onderzoek | type                                                    | opmerking                                    |
    | 123530                  | datum uitgifte Nederlands reisdocument                  | geen veld van reisdocument resource          |
    | 123540                  | autoriteit van uitgifte Nederlands reisdocument         | geen veld van reisdocument resource          |
    | 123560                  | datum inhouding/vermissing Nederlands reisdocument      | niet gevraagd veld van reisdocument resource |
    | 123570                  | aanduiding inhouding/vermissing Nederlands reisdocument | niet gevraagd veld van reisdocument resource |

  Abstract Scenario: '<type>' is in onderzoek en de houder velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens 
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20230201                  |
    En de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 000000152                  |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | houder                     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                                         | waarde          |
    | burgerservicenummer                          | 000000152       |
    | inOnderzoek.burgerservicenummer              | true            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2023-02-01      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 februari 2023 |

    Voorbeelden:
    | aanduiding in onderzoek | type                            |
    | 010000                  | hele categorie persoon          |
    | 010100                  | hele groep identificatienummers |
    | 010120                  | burgerservicenummer             |

  Abstract Scenario: 'persoon' is in onderzoek en de <fields> wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens 
    | naam                            | waarde   |
    | aanduiding in onderzoek (83.10) | 010000   |
    | datum ingang onderzoek (83.20)  | 20230201 |
    En de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 000000152                  |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | <fields>                   |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                                         | waarde          |
    | burgerservicenummer                          | 000000152       |
    | inOnderzoek.burgerservicenummer              | true            |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum           |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2023-02-01      |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 1 februari 2023 |

    Voorbeelden:
    | fields                     |
    | houder                     |
    | houder.burgerservicenummer |

  Abstract Scenario: '<type>' is in onderzoek en de houder velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende gegevens
    | naam                            | waarde                    |
    | aanduiding in onderzoek (83.10) | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)  | 20230201                  |
    En de persoon heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde    |
    | soort reisdocument (35.10)                  | PN        |
    | nummer reisdocument (35.20)                 | NE3663258 |
    | datum einde geldigheid reisdocument (35.50) | 20240506  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 000000152                  |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | houder                     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | aanduiding in onderzoek | type                | opmerking                     |
    | 010300                  | hele groep geboorte | geen veld van houder resource |
    | 010410                  | geslachtsaanduiding | geen veld van houder resource |

  Abstract Scenario: '<type>' is in onderzoek en de houder velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                        | waarde                    |
    | soort reisdocument (35.10)                  | PN                        |
    | nummer reisdocument (35.20)                 | NE3663258                 |
    | datum einde geldigheid reisdocument (35.50) | 20240506                  |
    | aanduiding in onderzoek (83.10)             | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)              | 20230201                  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                     |
    | type                    | ZoekMetBurgerservicenummer |
    | burgerservicenummer     | 000000152                  |
    | gemeenteVanInschrijving | 0800                       |
    | fields                  | houder                     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                | waarde    |
    | burgerservicenummer | 000000152 |

    Voorbeelden:
    | aanduiding in onderzoek | type                           | opmerking                                    |
    | 123510                  | soort Nederlands reisdocument  | niet gevraagd veld van reisdocument resource |
    | 123520                  | nummer Nederlands reisdocument | niet gevraagd veld van reisdocument resource |
