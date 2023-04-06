#language: nl

Functionaliteit: zoeken van de laatst uitgegeven reisdocumenten van een persoon

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
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response 0 reisdocumenten

      Voorbeelden:
      | aanduiding | omschrijving                                                |
      | I          | reisdocument ingeleverd                                     |
      | R          | van rechtswege vervallen reisdocument                       |
      | V          | vermist reisdocument                                        |
      | .          | vermist of ingehouden reisdocument met onbekende aanduiding |

    Scenario: de persoon heeft een reisdocument ingeleverd en heeft een ouder reisdocument van dezelfde soort nog in bezit
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                                    | waarde       |
      | soort reisdocument (35.10)                                              | PN           |
      | nummer reisdocument (35.20)                                             | NE3663258    |
      | datum uitgifte Nederlands reisdocument (35.30)                          | 20221106     |
      | datum einde geldigheid reisdocument (35.50)                             | 20371106     |
      | datum inhouding dan wel vermissing Nederlands reisdocument (35.60)      | 20221229     |
      | aanduiding inhouding dan wel vermissing Nederlands reisdocument (35.60) | I            |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NWE45TN71 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20080317  |
      | datum einde geldigheid reisdocument (35.50)    | 20230317  |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response 1 reisdocumenten
      En heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NWE45TN71 |
