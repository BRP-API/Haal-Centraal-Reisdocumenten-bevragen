# language: nl

@gba
Functionaliteit: Soort reisdocument

  Rule: Soort reisdocument wordt geleverd als code plus de bijbehorende omschrijving uit tabel 48 Nederlands Reisdocument

    Abstract Scenario: soort reisdocument heeft de waarde <code>
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'reisdocument' met de volgende gegevens
      | naam                        | waarde    |
      | soort reisdocument (35.10)  | <code>    |
      | nummer reisdocument (35.20) | NE3663258 |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                         |
      | type                    | RaadpleegMetReisdocumentnummer |
      | reisdocumentnummer      | NE3663258                      |
      | gemeenteVanInschrijving | 0800                           |
      | fields                  | soort                          |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde         |
      | soort.code         | <code>         |
      | soort.omschrijving | <omschrijving> |

      Voorbeelden:
      | code | omschrijving                    |
      | PD   | Diplomatiek paspoort            |
      | R1   | Reisdocument ouder1             |
      | TE   | Tweede paspoort (zakenpaspoort) |
      | ..   | Onbekend                        |
    