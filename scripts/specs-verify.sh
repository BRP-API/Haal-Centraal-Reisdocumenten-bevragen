#!/bin/bash

DBHOST=$1
DBUSER=$2
DBPASSWORD=$3
CLIENTID=$4
CLIENTSECRET=$5

PARAMS="{ \
  \"poolConfig\": { \
    \"host\": \"${DBHOST}\", \
    \"user\": \"${DBUSER}\", \
    \"password\": \"${DBPASSWORD}\" \
  }, \
  \"client\": { \
    \"clientId\": \"${CLIENTID}\", \
    \"clientSecret\": \"${CLIENTSECRET}\" \
  }\
}"

mkdir -p docs/features

npx cucumber-js -f json:docs/features/test-result-autorisatie-gba.json \
                -f summary:docs/features/test-result-autorisatie-gba-summary.txt \
                features \
                --tags "not @skip-verify" --tags "@autorisatie" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-protocollering-gba.json \
                -f summary:docs/features/test-result-protocollering-gba-summary.txt \
                features \
                --tags "not @skip-verify" --tags "@protocollering" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen-gba.json \
                -f summary:docs/features/test-result-zoeken-en-raadplegen-gba-summary.txt \
                features/ \
                --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-zoeken-en-raadplegen.json \
                -f summary:docs/features/test-result-zoeken-en-raadplegen-summary.txt \
                features/ \
                --tags "not @skip-verify" --tags "not @gba" \
                --world-parameters "$PARAMS"
