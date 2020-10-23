# language: nl

Functionaliteit: in onderzoek
  Wanneer een attribuut in onderzoek is, krijgt in het antwoord het attribuut met dezelfde naam binnen inOnderzoek de waarde true.

  Een categorie kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de categorie in onderzoek zijn.
  Wanneer een categorie in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze categorie de waarde true.
  Wanneer een categorie in zijn geheel in onderzoek is, krijgt in het antwoord in  inOnderzoek in elke groep van de categorie elk attribuut van deze categorie de waarde true.


  Een groep kan in zijn geheel in onderzoek zijn, maar er kunnen ook individuele attributen binnen de groep in onderzoek zijn.
  Wanneer een groep in zijn geheel in onderzoek is, krijgt in het antwoord in inOnderzoek elk attribuut van deze groep de waarde true.

  Een attribuut dat niet in onderzoek is, wordt niet in het antwoord in inOnderzoek opgenomen, ook niet met de waarde false of null.

  Scenario: hele categorie reisdocument in onderzoek
    Gegeven het te raadplegen reisdocument heeft het hele reisdocument in onderzoek (12.83.10=120000)
    En geen enkele andere categorie, groep of attribuut is in onderzoek
    Als het reisdocument wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.aanduidingInhoudingOfVermissing=true
    En is in het antwoord inOnderzoek.autoriteitAfgifte=true
    En is in het antwoord inOnderzoek.datumEindeGeldigheid=true
    En is in het antwoord inOnderzoek.datumInhoudingOfVermissing=true
    En is in het antwoord inOnderzoek.datumUitgifte=true
    En is in het antwoord inOnderzoek.reisdocumentnummer=true
    En is in het antwoord inOnderzoek.soortReisdocument=true
    En heeft in het antwoord inOnderzoek.datumIngangOnderzoek een waarde

  Scenario: Een attribuut is in inOnderzoek
    Gegeven het te raadplegen reisdocument heeft attribuut autoriteitAfgifte in onderzoek (12.83.10=123540)
    Als het reisdocument wordt geraadpleegd
    Dan is in het antwoord inOnderzoek.autoriteitAfgifte=true
    En heeft in het antwoord inOnderzoek.datumIngangOnderzoek een waarde
    En is in het antwoord inOnderzoek.aanduidingInhoudingOfVermissing niet aanwezig
    En is in het antwoord inOnderzoek.datumEindeGeldigheid niet aanwezig
    En is in het antwoord inOnderzoek.datumInhoudingOfVermissing niet aanwezig
    En is in het antwoord inOnderzoek.datumUitgifte niet aanwezig
    En is in het antwoord inOnderzoek.reisdocumentnummer niet aanwezig
    En is in het antwoord inOnderzoek.soortReisdocument niet aanwezig

  Scenario: Het onderzoek is beëindigd
    Gegeven het te raadplegen reisdocument heeft in onderzoek gevuld (12.83.10=120000), met datum einde in onderzoek (12.83.30) ook gevuld
    Als het reisdocument wordt geraadpleegd
    Dan is in het antwoord inOnderzoek niet aanwezig
