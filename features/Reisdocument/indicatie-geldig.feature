# language: nl

Functionaliteit: leveren van de geldigheid van een reisdocument


  Rule: Als de datum einde geldigheid van een reisdocument vandaag of in het verleden ligt, is het reisdocument niet geldig

    Abstract Scenario: de einddatum geldigheid van het reisdocument is <einddatum geldigheid>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde                 |
      | Soort Nederlands reisdocument (12.35.10)                  | PN                     |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7              |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20210316               |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599                  |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | <einddatum geldigheid> |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                         | waarde                      |
      | reisdocumentnummer           | BD8P7H2C7                   |
      | burgerservicenummer          | 000000024                   |
      | indicatieGeldig.code         | N                           |
      | indicatieGeldig.omschrijving | Reisdocument is niet geldig |

      Voorbeelden:
      | einddatum geldigheid |
      | vandaag              |
      | gisteren             |
      | vorige maand         |

    Scenario: de einddatum geldigheid van het reisdocument is morgen
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde                 |
      | Soort Nederlands reisdocument (12.35.10)                  | PN                     |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7              |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20210316               |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599                  |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | <einddatum geldigheid> |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                         | waarde                 |
      | reisdocumentnummer           | BD8P7H2C7              |
      | burgerservicenummer          | 000000024              |
      | indicatieGeldig.code         | G                      |
      | indicatieGeldig.omschrijving | Reisdocument is geldig |

      Voorbeelden:
      | einddatum geldigheid |
      | morgen               |


  Rule: Als het reisdocument is ingehouden of vermist, dan is het reisdocument niet meer geldig

    Abstract Scenario: het reisdocument is <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'reisdocument' gegevens
      | naam                                                                       | waarde                                |
      | Soort Nederlands reisdocument (12.35.10)                                   | PN                                    |
      | Nummer Nederlands reisdocument (12.35.20)                                  | BD8P7H2C7                             |
      | Datum uitgifte Nederlands reisdocument (12.35.30)                          | 20220316                              |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40)                  | B0599                                 |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50)                  | 20320316                              |
      | Datum inhouding dan wel vermissing Nederlands reisdocument (12.35.60)      | 20230310                              |
      | Aanduiding inhouding dan wel vermissing Nederlands reisdocument (12.35.70) | <aanduiding inhoudhouding/vermissing> |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                         | waarde                      |
      | reisdocumentnummer           | BD8P7H2C7                   |
      | burgerservicenummer          | 000000024                   |
      | indicatieGeldig.code         | N                           |
      | indicatieGeldig.omschrijving | Reisdocument is niet geldig |

      Voorbeelden:
      | aanduiding inhoudhouding/vermissing | omschrijving                              |
      | I                                   | ingehouden, ingeleverd                    |
      | R                                   | van rechtswege vervallen                  |
      | V                                   | vermist                                   |
      | .                                   | ingehouden of vermist met onbekende reden |


  Rule: Als een persoon is overleden zijn de reisdocumenten van de persoon niet meer geldig

    Scenario: de houder van het reisdocument is overleden
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230207                             | O                                    |
      En de persoon heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde    |
      | Soort Nederlands reisdocument (12.35.10)                  | PN        |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7 |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20220316  |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599     |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | 20320316  |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                                     | waarde                      |
      | reisdocumentnummer                       | BD8P7H2C7                   |
      | burgerservicenummer                      | 000000024                   |
      | indicatieGeldig.code                     | N                           |
      | indicatieGeldig.omschrijving             | Reisdocument is niet geldig |
      | opschortingBijhouding.reden.code         | O                           |
      | opschortingBijhouding.reden.omschrijving | overlijden                  |
      | opschortingBijhouding.datum.type         | Datum                       |
      | opschortingBijhouding.datum.datum        | 2023-02-07                  |
      | opschortingBijhouding.datum.langFormaat  | 7 februari 2023             |

    Abstract Scenario: de persoonslijst is opgeschort met reden <reden omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230207                             | O                                    |
      En de persoon heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde    |
      | Soort Nederlands reisdocument (12.35.10)                  | PN        |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7 |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20220316  |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599     |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | 20320316  |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                                     | waarde                 |
      | reisdocumentnummer                       | BD8P7H2C7              |
      | burgerservicenummer                      | 000000024              |
      | indicatieGeldig.code                     | G                      |
      | indicatieGeldig.omschrijving             | Reisdocument is geldig |
      | opschortingBijhouding.reden.code         | <opschorting reden>    |
      | opschortingBijhouding.reden.omschrijving | <reden omschrijving>   |
      | opschortingBijhouding.datum.type         | Datum                  |
      | opschortingBijhouding.datum.datum        | 2023-02-07             |
      | opschortingBijhouding.datum.langFormaat  | 7 februari 2023        |

      Voorbeelden:
      | opschorting reden | reden omschrijving        |
      | E                 | emigratie                 |
      | M                 | ministerieel besluit      |
      | R                 | pl is aangelegd in de rni |
      | .                 | onbekend                  |


  Rule: Als de persoonslijst is afgevoerd, dan zijn de reisdocumenten op de persoonslijst niet geldig

    Scenario: de persoonslijst is afgevoerd (opschorting bijhouding met reden 'F')
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230207                             | F                                    |
      En de persoon heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde    |
      | Soort Nederlands reisdocument (12.35.10)                  | PN        |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7 |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20220316  |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599     |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | 20320316  |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                                     | waarde                      |
      | reisdocumentnummer                       | BD8P7H2C7                   |
      | burgerservicenummer                      | 000000024                   |
      | indicatieGeldig.code                     | N                           |
      | indicatieGeldig.omschrijving             | Reisdocument is niet geldig |
      | opschortingBijhouding.reden.code         | F                           |
      | opschortingBijhouding.reden.omschrijving | fout                        |
      | opschortingBijhouding.datum.type         | Datum                       |
      | opschortingBijhouding.datum.datum        | 2023-02-07                  |
      | opschortingBijhouding.datum.langFormaat  | 7 februari 2023             |
