# language: nl

Functionaliteit: Reisdocumentnummer met standaardwaarde

  Rule: Een reisdocumentnummer met standaardwaarde wordt niet geleverd

    Scenario: Reisdocumentnummer heeft de standaardwaarde
      Gegeven de persoon met burgerservicenummer '000000024' heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | ......... |
      | datum einde geldigheid reisdocument (35.50) | 20330506  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000024                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een 'reisdocument' zonder gegevens
