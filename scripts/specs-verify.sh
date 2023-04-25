#!/bin/bash

PARAMS="${1}"
if [[ ! -n $PARAMS ]]; then
    PARAMS={}
fi

mkdir -p docs/features

npx cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen-gba.json \
            -f summary:docs/features/test-result-zoeken-en-raadplegen-gba-summary.txt \
            features/raadpleeg-met-reisdocumentnummer \
            --tags "not @skip-verify" --tags "@gba" \
            --world-parameters "$PARAMS"

# cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen.json \
#             -f summary:docs/features/test-result-zoeken-en-raadplegen-summary.txt \
#             features/raadpleeg-met-reisdocumentnummer \
#             --tags "not @skip-verify" --tags "not @gba"
