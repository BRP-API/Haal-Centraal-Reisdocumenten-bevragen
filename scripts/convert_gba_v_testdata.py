import csv
import json

def set_field_value(target_object, field_name, value):
    target_object[field_name] = value

def map_dictionary(src_dict, fields_to_map):
    target_object = {}

    target_object['id'] = src_dict.get('id')

    for field in fields_to_map.keys():
        value = src_dict.get(field)
        if not value:
            continue

        field_to_map = fields_to_map.get(field)
        subfields_to_map = field_to_map.split('.')
        tmp_object = target_object

        for subfield in subfields_to_map:
            if subfield == subfields_to_map[-1]:
                set_field_value(tmp_object, subfield, value)
                continue
            elif not tmp_object.get(subfield):
                tmp_object[subfield] = {}
            tmp_object = tmp_object[subfield]

    return target_object

def convert_gba_v_testdata(fields_to_map, gba_v_testdata_file, gba_v_testdata_json_file):
    """
    Convert the GBA V test data file to a CSV file.
    """

    target = []

    with open(gba_v_testdata_file, 'r', encoding='utf-8-sig') as src:
        src_reader = csv.DictReader(src, delimiter=';')

        for row in src_reader:
            target_object = map_dictionary(row, fields_to_map)

            del target_object['id']
            if target_object != {}:
                target.append(target_object)

    with open(gba_v_testdata_json_file, 'w', encoding='utf-8') as dst:
        dst.write(json.dumps(target, indent=2, ensure_ascii=False))

fields_to_map = {
    '01.01.20': 'houder.burgerservicenummer',
    '08.09.10': 'houder.gemeenteVanInschrijving.code',
    '12.35.10': 'soort.code',
    '12.35.20': 'reisdocumentnummer',
    '12.35.50': 'datumEindeGeldigheid',
    '12.35.60': 'inhoudingOfVermissing.datum',
    '12.35.70': 'inhoudingOfVermissing.aanduiding.code',
    '12.83.10': 'inOnderzoek.aanduidingGegevensInOnderzoek',
    '12.83.20': 'inOnderzoek.datumIngangOnderzoek'
}

convert_gba_v_testdata(fields_to_map, '20220502_Testset_persoonslijsten_proefomgeving_GBA-V.csv', '../src/config/ReisdocumentService/test-data.json')
