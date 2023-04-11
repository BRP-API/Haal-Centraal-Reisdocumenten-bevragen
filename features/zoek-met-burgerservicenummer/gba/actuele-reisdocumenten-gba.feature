#language: nl

@gba
Functionaliteit: zoeken van de actuele reisdocumenten van een persoon

  Rule: bij zoeken van reisdocumenten met burgerservicenummer worden alleen reisdocumenten geleverd die volgens de registratie nog in het bezit zijn van de persoon

    Abstract Scenario: de persoon heeft een <omschrijving> en heeft geen ander reisdocument
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                    | waarde       |
      | soort reisdocument (35.10)                                              | PN           |
      | nummer reisdocument (35.20)                                             | NE3663258    |
      | datum uitgifte Nederlands reisdocument (35.30)                          | 20221106     |
      | datum einde geldigheid reisdocument (35.50)                             | 20371106     |
      | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20221229     |
      | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.60) | <aanduiding> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                     |
      | type                    | ZoekMetBurgerservicenummer |
      | burgerservicenummer     | 000000152                  |
      | gemeenteVanInschrijving | 0800                       |
      | fields                  | reisdocumentnummer         |
      Dan heeft de response 0 reisdocumenten

      Voorbeelden:
      | aanduiding | omschrijving                                                |
      | I          | reisdocument ingeleverd                                     |
      | R          | van rechtswege vervallen reisdocument                       |
      | V          | vermist reisdocument                                        |
      | .          | vermist of ingehouden reisdocument met onbekende aanduiding |

    Scenario: de persoon heeft een reisdocument ingeleverd en heeft een ander reisdocument van dezelfde soort nog in bezit
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                    | waarde       |
      | soort reisdocument (35.10)                                              | PN           |
      | nummer reisdocument (35.20)                                             | NE3663258    |
      | datum uitgifte Nederlands reisdocument (35.30)                          | 20131106     |
      | datum einde geldigheid reisdocument (35.50)                             | 20231106     |
      | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20221229     |
      | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.60) | I            |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NWE45TN71 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20230317  |
      | datum einde geldigheid reisdocument (35.50)    | 20330317  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                     |
      | type                    | ZoekMetBurgerservicenummer |
      | burgerservicenummer     | 000000152                  |
      | gemeenteVanInschrijving | 0800                       |
      | fields                  | reisdocumentnummer         |
      Dan heeft de response 1 reisdocumenten
      En heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NWE45TN71 |

  Rule: een verwijderd reisdocument wordt niet geleverd

    Scenario: de persoon heeft een reisdocument dat is verwijderd via de signalering opname op Register paspoortsignaleringen
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                                   | waarde           |
      | Signalering met betrekking tot het verstrekken van een Nederlands reisdocument (36.10) | 1                |
      | gemeente document (82.10)                                                              | 0518             |
      | datum document (82.20)                                                                 | 20040105         |
      | beschrijving document (82.30)                                                          | D27894-2004-A782 |
      | ingangsdatum geldigheid (85.10)                                                        | 20031107         |
      | datum van opneming (86.10)                                                             | 20040112         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                     |
      | type                    | ZoekMetBurgerservicenummer |
      | burgerservicenummer     | 000000152                  |
      | gemeenteVanInschrijving | 0800                       |
      | fields                  | reisdocumentnummer         |
      Dan heeft de response 0 reisdocumenten
