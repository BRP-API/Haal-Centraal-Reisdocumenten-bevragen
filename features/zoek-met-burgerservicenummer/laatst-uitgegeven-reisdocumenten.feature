#language: nl

Functionaliteit: zoeken van de laatst uitgegeven reisdocumenten van een persoon

  Rule: bij zoeken van reisdocumenten met burgerservicenummer wordt van elke soort reisdocument alleen het laatst uitgegeven reisdocument geleverd

    Scenario: de persoon heeft meerdere reisdocumenten van verschillende soorten
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NE3663258 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20221106  |
      | datum einde geldigheid reisdocument (35.50)    | 20371106  |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NWE45TN71 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20230203  |
      | datum einde geldigheid reisdocument (35.50)    | 20330203  |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | NI        |
      | nummer reisdocument (35.20)                    | 3DE04ID96 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20190628  |
      | datum einde geldigheid reisdocument (35.50)    | 20290628  |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | NI        |
      | nummer reisdocument (35.20)                    | VI793KRT2 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20150903  |
      | datum einde geldigheid reisdocument (35.50)    | 20290903  |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NWE45TN71 |
      En heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | 3DE04ID96 |

    Scenario: de persoon heeft meerdere verlopen reisdocumenten
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NE3663258 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20030324  |
      | datum einde geldigheid reisdocument (35.50)    | 20230324  |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | PN        |
      | nummer reisdocument (35.20)                    | NWE45TN71 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20080317  |
      | datum einde geldigheid reisdocument (35.50)    | 20230317  |
      En de persoon heeft een 'reisdocument' met de volgende gegevens
      | naam                                           | waarde    |
      | soort reisdocument (35.10)                     | NI        |
      | nummer reisdocument (35.20)                    | 3DE04ID96 |
      | datum uitgifte Nederlands reisdocument (35.30) | 20060628  |
      | datum einde geldigheid reisdocument (35.50)    | 20210628  |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NWE45TN71 |
      En heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | 3DE04ID96 |

  Rule: bij zoeken van reisdocumenten met burgerservicenummer wordt een ingehouden of vermist reisdocument niet geleverd

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
      Dan heeft de response een 'reisdocument' met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NWE45TN71 |
