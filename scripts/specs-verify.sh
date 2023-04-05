#!/bin/bash

mkdir -p docs/features

cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen.json \
            -f summary:docs/features/test-result-zoeken-en-raadplegen-summary.txt \
            features/raadpleeg-met-reisdocumentnummer/fout-cases.feature \
            --tags "not @skip-verify" --tags "not @gba"
