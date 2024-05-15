# language: nl

@proxy
Functionaliteit: geheimhouding leveren bij ZoekMetBurgerservicenummer

  Wanneer een consumer van de Reisdocumenten API gegevens bevraagt van een persoon die geen toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden
  Dan wil de consumer hiervan worden geattendeerd middels een indicatie bij de gevraagde gegevens

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      En de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | NE3663258 |
      | datum einde geldigheid reisdocument (35.50) | 20330506  |
      En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |


  Regel: indicatie geheim waarde 0 wordt niet geleverd

    Scenario: reisdocument van een persoon die toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, wordt geraadpleegd
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde |
      | indicatie geheim (70.10) | 0      |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een reisdocument met de volgende gegevens
      | naam               | waarde    |
      | reisdocumentnummer | NE3663258 |


  Regel: indicatie geheim met waarde hoger dan 0 wordt vertaald naar geheimhoudingPersoonsgegevens waarde true en ongevraagd meegeleverd

    Abstract Scenario: persoon met indicatie geheim <waarde>, wordt geraadpleegd met reisdocumentnummer
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde   |
      | indicatie geheim (70.10) | <waarde> |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | reisdocumentnummer         |
      Dan heeft de response een reisdocument met de volgende gegevens
      | naam                                 | waarde    |
      | reisdocumentnummer                   | NE3663258 |
      | houder.geheimhoudingPersoonsgegevens | true      |

      Voorbeelden:
      | waarde |
      | 1      |
      | 2      |
      | 3      |
      | 4      |
      | 5      |
      | 6      |
      | 7      |

    Abstract Scenario: persoon met indicatie geheim en <fields> wordt gevraagd
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde |
      | indicatie geheim (70.10) | 7      |
      Als reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000152                  |
      | fields              | <fields>                   |
      Dan heeft de response een reisdocument met de volgende gegevens
      | naam                                 | waarde     |
      | <veld 1>                             | <waarde 1> |
      | <veld 2>                             | <waarde 2> |
      | <veld 3>                             | <waarde 3> |
      | houder.geheimhoudingPersoonsgegevens | true       |

      Voorbeelden:
      | fields                           | veld 1                     | waarde 1  | veld 2                     | waarde 2           | veld 3                           | waarde 3           |
      | reisdocumentnummer               | reisdocumentnummer         | NE3663258 |                            |                    |                                  |                    |
      | soort                            | soort.code                 | PN        | soort.omschrijving         | Nationaal paspoort |                                  |                    |
      | reisdocumentnummer,soort         | reisdocumentnummer         | NE3663258 | soort.code                 | PN                 | soort.omschrijving               | Nationaal paspoort |
      | datumEindeGeldigheid             | datumEindeGeldigheid.type  | Datum     | datumEindeGeldigheid.datum | 2033-05-06         | datumEindeGeldigheid.langFormaat | 6 mei 2033         |
      | inhoudingOfVermissing.datum      |                            |           |                            |                    |                                  |                    |
      | inhoudingOfVermissing.aanduiding |                            |           |                            |                    |                                  |                    |
      | houder                           | houder.burgerservicenummer | 000000152 |                            |                    |                                  |                    |
      | houder.burgerservicenummer       | houder.burgerservicenummer | 000000152 |                            |                    |                                  |                    |
