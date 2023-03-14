# language: nl

Functionaliteit: leveren van de geldigheid van een reisdocument bij een onbekende einddatum geldigheid


  Rule: Als de datum einde geldigheid van een reisdocument volledig onbekend is, dan is de geldigheid van het reisdocument onbekend
    ... tenzij het reisdocument om een andere reden dan de einddatum niet meer geldig is

    Scenario: de einddatum geldigheid van het reisdocument is volledig onbekend
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'reisdocument' gegevens
      | naam                                                      | waarde    |
      | Soort Nederlands reisdocument (12.35.10)                  | PN        |
      | Nummer Nederlands reisdocument (12.35.20)                 | BD8P7H2C7 |
      | Datum uitgifte Nederlands reisdocument (12.35.30)         | 20210316  |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40) | B0599     |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50) | 00000000  |
      Als het reisdocument met nummer 'BD8P7H2C7' wordt geraadpleegd
      Dan heeft de response de volgende gegevens
      | naam                         | waarde                                     |
      | reisdocumentnummer           | BD8P7H2C7                                  |
      | burgerservicenummer          | 000000024                                  |
      | indicatieGeldig.code         | O                                          |
      | indicatieGeldig.omschrijving | De status van het reisdocument is onbekend |

    Scenario: de einddatum geldigheid van het reisdocument is volledig onbekend en het reisdocument is <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'reisdocument' gegevens
      | naam                                                                       | waarde                                |
      | Soort Nederlands reisdocument (12.35.10)                                   | PN                                    |
      | Nummer Nederlands reisdocument (12.35.20)                                  | BD8P7H2C7                             |
      | Datum uitgifte Nederlands reisdocument (12.35.30)                          | 20220316                              |
      | Autoriteit van afgifte Nederlands reisdocument (12.35.40)                  | B0599                                 |
      | Datum einde geldigheid Nederlands reisdocument (12.35.50)                  | 00000000                              |
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


    Abstract Scenario: de einddatum geldigheid van het reisdocument is volledig onbekend en <situatie>
      Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20230207                             | <opschorting>                        |
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
      | opschortingBijhouding.reden.code         | <opschorting>               |
      | opschortingBijhouding.reden.omschrijving | <omschrijving>              |
      | opschortingBijhouding.datum.type         | Datum                       |
      | opschortingBijhouding.datum.datum        | 2023-02-07                  |
      | opschortingBijhouding.datum.langFormaat  | 7 februari 2023             |

      Voorbeelden:
      | situatie                                    | opschorting | omschrijving |
      | de houder van het reisdocument is overleden | O           | overlijden   |
      | de persoonslijst is afgevoerd               | F           | fout         |

    
Rule: Bij een datum einde geldigheid van een reisdocument waarvan alleen het jaar bekend is, dan is de geldigheid van het reisdocument onbekend als het jaar gelijk is aan het huidig jaar

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
      | naam                         | waarde                          |
      | reisdocumentnummer           | BD8P7H2C7                       |
      | burgerservicenummer          | 000000024                       |
      | indicatieGeldig.code         | <indicatieGeldig>               |
      | indicatieGeldig.omschrijving | <indicatieGeldig omschrijving > |

      Voorbeelden:
      | einddatum geldigheid | indicatieGeldig | indicatieGeldig omschrijving               |
      | dit jaar             | O               | De status van het reisdocument is onbekend |
      | volgend jaar         | G               | Reisdocument is geldig                     |
      | vorig jaar           | N               | Reisdocument is niet geldig                |

 Rule: Bij een datum einde geldigheid van een reisdocument waarvan de dag niet bekend is, dan is de geldigheid van het reisdocument onbekend als jaar en maand gelijk is aan de huidige maand

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
      | naam                         | waarde                          |
      | reisdocumentnummer           | BD8P7H2C7                       |
      | burgerservicenummer          | 000000024                       |
      | indicatieGeldig.code         | <indicatieGeldig>               |
      | indicatieGeldig.omschrijving | <indicatieGeldig omschrijving > |

      Voorbeelden:
      | einddatum geldigheid    | indicatieGeldig | indicatieGeldig omschrijving               |
      | deze maand              | O               | De status van het reisdocument is onbekend |
      | volgende maand          | G               | Reisdocument is geldig                     |
      | deze maand + 1 jaar     | G               | Reisdocument is geldig                     |
      | vorige maand            | N               | Reisdocument is niet geldig                |
      | deze maand - 1 jaar     | N               | Reisdocument is niet geldig                |
      | volgende maand - 1 jaar | N               | Reisdocument is niet geldig                |
      | vorige maand + 1 jaar   | G               | Reisdocument is geldig                     |
