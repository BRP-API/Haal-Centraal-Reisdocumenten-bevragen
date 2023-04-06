# language: nl

@gba @autorisatie
Functionaliteit: autorisatie voor het gebruik van de API ZoekMetBurgerservicenummer
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Voorlopig wordt de reisdocumenten bevragen API alleen aangeboden aan gemeenten voor het raadplegen van reisdocumenten van eigen inwoners.
  Gebruikers zijn daarom verplicht om de parameter gemeenteVanInschrijving te gebruiken en mogen dan alleen de gemeentecode van de eigen gemeente gebruiken.

  Autorisatie wordt verkregen met behulp van een Oauth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. Op basis van de afnemerindicatie kan de autorisatie worden opgezocht.
  Wanneer de afnemer een gemeente is, is er ook een gemeentecode opgenomen in de Oauth token.

  Voor één afnemer kunnen er meerdere rijen zijn in de autorisatietabel, maar daarvan kan er maar één actueel zijn. Alleen de actuele mag worden gebruikt.
  Een autorisatie is actueel wanneer de Datum ingang (35.99.98) in het verleden ligt en Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt.

  # To Do (t.z.t.): regels voor autorisatie op basis van een autorisatiebesluit
  # To Do (t.z.t.): regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)
  # To Do (t.z.t.): regels voor voorwaarderegel ad hoc (35.95.61)



    Achtergrond:
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'reisdocument' met de volgende gegevens
      | naam                                                 | waarde    |
      | soort reisdocument (35.10)                           | PN        |
      | nummer reisdocument (35.20)                          | NE3663258 |
      | datum einde geldigheid reisdocument (35.50)          | 20240506  |
      | datum inhouding/vermissing reisdocument (35.60)      | 20230405  |
      | aanduiding inhouding/vermissing reisdocument (35.70) | I         |
      En de persoon heeft de volgende 'verblijfplaats' gegevens
      | gemeente van inschrijving (09.10) |
      | 0800                              |


  Rule: Een gemeente als afnemer is geautoriseerd voor alle zoekvragen en alle gegevens voor haar eigen inwoners
    Wanneer de afnemer parameter gemeenteVanInschrijving gebruikt 
    en die is gelijk aan de waarde van gemeenteCode in de 'claim', 
    dan wordt niet gekeken naar de autorisatie van de afnemer

    Scenario: Gemeente is niet geautoriseerd voor reisdocumenten maar zoekt reisdocumenten voor een eigen inwoner met parameter gemeenteVanInschrijving
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                                                                     |
      | type                    | ZoekMetBurgerservicenummer                                                 |
      | burgerservicenummer     | 000000152                                                                  |
      | gemeenteVanInschrijving | 0800                                                                       |
      | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid,inhoudingOfVermissing,houder |
      Dan heeft de response 1 reisdocument

    @fout-case
    Scenario: Gemeente is niet geautoriseerd voor reisdocumenten en zoekt een reisdocument voor een inwoner van een andere gemeente met parameter gemeenteVanInschrijving
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                                                                     |
      | type                    | ZoekMetBurgerservicenummer                                                 |
      | burgerservicenummer     | 000000152                                                                  |
      | gemeenteVanInschrijving | 0599                                                                       |
      | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid,inhoudingOfVermissing,houder |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                        |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                                   |
      | title    | U bent niet geautoriseerd voor deze vraag.                                                    |
      | status   | 403                                                                                           |
      | detail   | Uw autorisatie staat alleen toe dat u reisdocumenten van inwoners van uw gemeente raadpleegt. |
      | code     | unauthorized                                                                                  |
      | instance | /haalcentraal/api/reisdocumenten/reisdocumenten                                               |
  
    @fout-case
    Scenario: Gebruik van de parameter gemeenteVanInschrijving is verplicht
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | naam         | waarde |
      | afnemerID    | 000008 |
      | gemeenteCode | 0800   |
      Als gba reisdocumenten wordt gezocht met de volgende parameters
      | naam                    | waarde                                                                     |
      | type                    | ZoekMetBurgerservicenummer                                                 |
      | burgerservicenummer     | 000000152                                                                  |
      | fields                  | reisdocumentnummer,soort,datumEindeGeldigheid,inhoudingOfVermissing,houder |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: gemeenteVanInschrijving.     |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/reisdocumenten                            |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                    | reason                  |
      | required | gemeenteVanInschrijving | Parameter is verplicht. |
