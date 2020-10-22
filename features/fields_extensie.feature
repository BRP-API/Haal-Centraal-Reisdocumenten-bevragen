# language: nl

Functionaliteit: Aanpasbare representatie met de fields parameter
  Deze feature is een extensie op https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.2.0/features/fields.feature

  In de Reisdocumenten API wordt de uitgebreide variant van fields ondersteund. Velden in een groep kunnen dus worden opgevraagd zonder het hele pad op te noemen, bijvoorbeeld fields=voornamen levert naam.voornamen.

  De volgende velden worden geleverd ongeacht of de fields parameter is gebruikt en ongeacht de eventueel gevraagde velden in de fields parameter:
  - inOnderzoek wordt meegegeven wanneer gevraagde corresponderende velden in onderzoek zijn. Zie in_onderzoek.feature voor uitleg wanneer attributen in onderzoek zijn.
  - geheimhoudingPersoonsgegevens wordt altijd meegegeven wanneer deze de waarde true heeft.

  Achtergrond:
    Gegeven: reisdocument met reisdocumentnummer NA1260787 heeft datumUitgifte (12.35.30) in onderzoek
    En reisdocument met reisdocumentnummer NA1260787 heeft autoriteitAfgifte (12.35.40) in onderzoek
    En bij reisdocument met reisdocumentnummer NA1260787 hebben alle properties een waarde
    En reisdocument met reisdocumentnummer NM1260784 heeft geheimhoudingPersoonsgegevens=true


  Scenario: gevraagd gegeven is in onderzoek en geen fields gebruikt
    Als reisdocument wordt gevraagd met "/reisdocumenten/NA1260787"
    Dan bevat het antwoord datumUitgifte met de waarde "2006-12-29"
    En bevat het antwoord aanduidingInhoudingOfVermissing met een waarde
    En bevat het antwoord reisdocumentnummer met een waarde
    En bevat het antwoord autoriteitAfgifte met een waarde
    En bevat het antwoord datumEindeGeldigheid met een waarde
    En bevat het antwoord datumInhoudingOfVermissing met een waarde
    En bevat het antwoord soortReisdocument met een waarde
    En bevat het antwoord geheimhoudingPersoonsgegevens met een waarde
    En bevat het antwoord inOnderzoek.datumUitgifte met de waarde true
    En bevat het antwoord inOnderzoek.autoriteitAfgifte met de waarde true

  Scenario: gevraagd gegeven is in onderzoek en het gegeven in onderzoek wordt gevraagd
    Als persoon wordt gevraagd met "/reisdocumenten/NA1260787?fields=datumUitgifte"
    Dan bevat het antwoord datumUitgifte met de waarde "2006-12-29"
    En bevat het antwoord inOnderzoek.datumUitgifte met de waarde true

  Scenario: gevraagd gegeven is niet in onderzoek en het gegeven in onderzoek wordt niet gevraagd met fields
    Als persoon wordt gevraagd met "/reisdocumenten/NA1260787?fields=datumInhoudingOfVermissing"
    Dan bevat het antwoord veld datumInhoudingOfVermissing met een waarde
    En bevat het antwoord niet inOnderzoek


  Scenario: leveren geheimhoudingPersoonsgegevens als daar niet om is gevraagd
    Als persoon wordt gevraagd met "/reisdocumenten/NM1260784?fields=datumInhoudingOfVermissing"
    Dan bevat het antwoord veld geheimhoudingPersoonsgegevens met de waarde true
    En bevat het antwoord veld datumInhoudingOfVermissing met een waarde
