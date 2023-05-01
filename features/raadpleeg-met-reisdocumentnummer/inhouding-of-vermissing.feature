#language: nl

Functionaliteit: Aanduiding inhouding/vermissing van reisdocument vragen geeft ook de omschrijving van de aanduiding
  # Ook de standaardwaarde wordt geleverd, zodat ook dan zichtbaar is dat het reisdocument niet meer in bezit is van de persoon

    Abstract Scenario: 'aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70)' wordt gevraagd en heeft waarde '<aanduiding>'
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                    | waarde       |
      | soort reisdocument (35.10)                                              | PN           |
      | nummer reisdocument (35.20)                                             | NE3663258    |
      | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.70) | <aanduiding> |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                           |
      | type                    | RaadpleegMetReisdocumentnummer   |
      | reisdocumentnummer      | NE3663258                        |
      | gemeenteVanInschrijving | 0800                             |
      | fields                  | inhoudingOfVermissing.aanduiding |
      Dan heeft de response een 'reisdocument' met de volgende 'inhoudingOfVermissing' gegevens
      | naam                    | waarde         |
      | aanduiding.code         | <aanduiding>   |
      | aanduiding.omschrijving | <omschrijving> |

      Voorbeelden:
      | aanduiding | omschrijving             |
      | I          | ingehouden of ingeleverd |
      | R          | van rechtswege vervallen |
      | V          | vermist                  |
      | .          | onbekend                 |
