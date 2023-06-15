#language: nl

@gba @protocollering
Functionaliteit: Protocolleren van ZoekMetBurgerservicenummer
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - pl_id: de technische sleutel voor de gegevens van de persoon waarvan gegevens zijn geleverd
  - request_zoek_rubrieken: lijst van alle parameters die in het request gebruikt zijn, vertaald naar LO-BRP elementnummers
  - request_gevraagde_rubrieken: lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Zowel request_zoek_rubrieken als request_gevraagde_rubrieken bevatten de LO-BRP elementnummers als 6 cijferig rubrieknummer (incl. voorloopnul), gescheiden door komma spatie, en oplopend gesorteerd.

  Rule: Zoekrubrieken worden vertaald naar rubrieknummers, oplopend gesorteerd op rubrieknummer en gescheiden door komma en spatie

    Scenario: Zoek reisdocumenten op burgerservicenummer
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | NE3663258 |
      | datum einde geldigheid reisdocument (35.50) | 20240506  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                                   |
      | type                | ZoekMetBurgerservicenummer               |
      | burgerservicenummer | 000000012                                |
      | fields              | reisdocumentnummer,inhoudingOfVermissing |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 010120                 |

  Rule: Gevraagde velden in fields worden vertaald naar rubrieknummers, oplopend gesorteerd en gescheiden door komma en spatie

    Abstract Scenario: Gevraagde veld <fields veld> wordt vastgelegd in 'request_gevraagde_rubrieken' als <rubrieknummer>
      Gegeven de persoon met burgerservicenummer '000000012' heeft een 'reisdocument' met de volgende gegevens
      | naam                                        | waarde    |
      | soort reisdocument (35.10)                  | PN        |
      | nummer reisdocument (35.20)                 | NE3663258 |
      | datum einde geldigheid reisdocument (35.50) | 20240506  |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                | waarde                     |
      | type                | ZoekMetBurgerservicenummer |
      | burgerservicenummer | 000000012                  |
      | fields              | <fields>                   |
      Dan heeft de persoon met burgerservicenummer '000000012' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | <gevraagde rubrieken>       |

      Voorbeelden:
      | fields                                        | gevraagde rubrieken |
      | soort                                         | 123510              |
      | soort.code                                    | 123510              |
      | soort.omschrijving                            | 123510              |
      | reisdocumentnummer                            | 123520              |
      | datumEindeGeldigheid                          | 123550              |
      | datumEindeGeldigheid.type                     | 123550              |
      | datumEindeGeldigheid.datum                    | 123550              |
      | datumEindeGeldigheid.langFormaat              | 123550              |
      | datumEindeGeldigheid.onbekend                 | 123550              |
      | datumEindeGeldigheid.jaar                     | 123550              |
      | datumEindeGeldigheid.maand                    | 123550              |
      | inhoudingOfVermissing                         | 123560, 123570      |
      | inhoudingOfVermissing.datum                   | 123560              |
      | inhoudingOfVermissing.datum.type              | 123560              |
      | inhoudingOfVermissing.datum.datum             | 123560              |
      | inhoudingOfVermissing.datum.langFormaat       | 123560              |
      | inhoudingOfVermissing.datum.onbekend          | 123560              |
      | inhoudingOfVermissing.datum.jaar              | 123560              |
      | inhoudingOfVermissing.datum.maand             | 123560              |
      | inhoudingOfVermissing.aanduiding              | 123570              |
      | inhoudingOfVermissing.aanduiding.code         | 123570              |
      | inhoudingOfVermissing.aanduiding.omschrijving | 123570              |
      | houder                                        | 010120              |
      | houder.burgerservicenummer                    | 010120              |
