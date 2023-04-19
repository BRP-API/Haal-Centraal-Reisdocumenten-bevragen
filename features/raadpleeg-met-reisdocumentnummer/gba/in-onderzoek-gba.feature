#language: nl

@gba
Functionaliteit: Reisdocument velden zijn in onderzoek

  Abstract Scenario: '<type>' is in onderzoek en één of meerdere reisdocument velden wordt gevraagd
    Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
    | naam                                                                    | waarde                    |
    | soort reisdocument (35.10)                                              | PN                        |
    | nummer reisdocument (35.20)                                             | NE3663258                 |
    | datum einde geldigheid reisdocument (35.50)                             | 20240506                  |
    | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20230405                  |
    | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) | I                         |
    | aanduiding in onderzoek (83.10)                                         | <aanduiding in onderzoek> |
    | datum ingang onderzoek (83.20)                                          | 20230506                  |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | gemeente van inschrijving (09.10) |
    | 0800                              |
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                                        |
    | type                    | RaadpleegMetReisdocumentnummer                |
    | reisdocumentnummer      | NE3663258                                     |
    | gemeenteVanInschrijving | 0800                                          |
    | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid |
    Dan heeft de response een 'reisdocument' met de volgende gegevens
    | naam                                      | waarde                    |
    | reisdocumentnummer                        | NE3663258                 |
    | soort.code                                | PN                        |
    | soort.omschrijving                        | Nationaal paspoort        |
    | datumEindeGeldigheid                      | 20240506                  |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20230506                  |

    Voorbeelden:
    | aanduiding in onderzoek | type                                                    |
    | 120000                  | hele categorie reisdocument                             |
    | 123500                  | hele groep Nederlands reisdocument                      |
    | 123510                  | soort Nederlands reisdocument                           |
    | 123520                  | nummer Nederlands reisdocument                          |
    | 123530                  | datum uitgifte Nederlands reisdocument                  |
    | 123540                  | autoriteit van uitgifte Nederlands reisdocument         |
    | 123550                  | datum einde geldigheid Nederlands reisdocument          |
    | 123560                  | datum inhouding/vermissing Nederlands reisdocument      |
    | 123570                  | aanduiding inhouding/vermissing Nederlands reisdocument |

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
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | houder                         |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                                      | waarde                    |
    | burgerservicenummer                       | 000000152                 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20230201                  |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010100                  | hele groep persoon     |
    | 010120                  | burgerservicenummer    |
    | 010300                  | hele groep geboorte    |
    | 010410                  | geslachtsaanduiding    |

  Abstract Scenario: '<type>' is in onderzoek en het burgerservicenummer veld van de houder wordt gevraagd
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
    Als gba reisdocumenten wordt gezocht met de volgende parameters
    | naam                    | waarde                         |
    | type                    | RaadpleegMetReisdocumentnummer |
    | reisdocumentnummer      | NE3663258                      |
    | gemeenteVanInschrijving | 0800                           |
    | fields                  | houder.burgerservicenummer     |
    Dan heeft de response een 'reisdocument' met de volgende 'houder' gegevens
    | naam                                      | waarde                    |
    | burgerservicenummer                       | 000000152                 |
    | inOnderzoek.aanduidingGegevensInOnderzoek | <aanduiding in onderzoek> |
    | inOnderzoek.datumIngangOnderzoek          | 20230201                  |

    Voorbeelden:
    | aanduiding in onderzoek | type                   |
    | 010000                  | hele categorie persoon |
    | 010100                  | hele groep persoon     |
    | 010120                  | burgerservicenummer    |
    | 010300                  | hele groep geboorte    |
    | 010410                  | geslachtsaanduiding    |
