const { World } = require('./world');
const { createCollectieDataZonderVolgNrFromArray, createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray } = require('./dataTable2Array.js');
const { createObjectFrom } = require('./dataTable2Object.js');
const { stringifyValues } = require('./stringify.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest } = require('./handleRequest.js');
const { Pool } = require('pg');
const { executeSqlStatements, rollbackSqlStatements } = require('./postgressHelpers.js');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor } = require('./gba.js');

setWorldConstructor(World);

let pool = undefined;
let logSqlStatements = false;
let accessToken = undefined;

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function(burgerservicenummer, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray('persoon', [
            ['burger_service_nr', burgerservicenummer]
        ]).concat(createArrayFrom(dataTable, columnNameMap))
    ];
});

function createPersoonMetGegevensgroep(burgerservicenummer, gegevensgroep, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    if(gegevensgroep !== 'inschrijving') {
        if(gegevensgroep === 'kiesrecht') {
            sqlData["inschrijving"] = [
                [
                    [ 'geheim_ind', '0' ]
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
        }
        else {
            sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
            sqlData[gegevensgroep] = [
                [
                    [ 'volg_nr', '0']
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
        }
    }
    else {
        sqlData[gegevensgroep] = [ createArrayFrom(dataTable, columnNameMap) ];
    }
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, function (burgerservicenummer, relatie, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    const collectieData = relatie === 'reisdocument'
        ? createCollectieDataZonderVolgNrFromArray(createArrayFrom(dataTable, columnNameMap))
        : createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap));

    sqlData[`${relatie}-${getNextStapelNr(sqlData, relatie)}`] = [
        collectieData
    ];
});

Given(/^de persoon heeft een '(\w*)' met de volgende gegevens$/, function(relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, relatie);
    const collectieData = relatie === 'reisdocument'
        ? createCollectieDataZonderVolgNrFromArray(createArrayFrom(dataTable, columnNameMap), stapelNr)
        : createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr);

    sqlData[`${relatie}-${stapelNr}`] = [
        collectieData
    ];
});

Given(/^de persoon heeft de volgende '(\w*)' gegevens$/, async function (gegevensgroep, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[gegevensgroep] = [
        gegevensgroep === 'inschrijving'
            ? createArrayFrom(dataTable, columnNameMap)
            : createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)) 

    ];
});

When(/^reisdocumenten wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = true;
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }

    if(this.context.oAuth.enable){
        if(this.context.afnemerId === undefined) {
            let sqlData = this.context.sqlData.at(-1);
            const afnemerId = this.context.oAuth.clients[0].afnemerID;
    
            sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
        }

        await executeSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);

        const result = await handleOAuthRequest(accessToken, this.context.oAuth, this.context.afnemerID, this.context.proxyUrl, dataTable);
        this.context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        await executeSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);

        this.context.response = await postBevragenRequestWithBasicAuth(this.context.proxyUrl, this.context.extraHeaders, dataTable);
    }
});

When(/^gba reisdocumenten wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = false;
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }

    if(this.context.oAuth.enable){
        if(this.context.afnemerId === undefined) {
            let sqlData = this.context.sqlData.at(-1);
            const afnemerId = this.context.oAuth.clients[0].afnemerID;
    
            sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
        }

        await executeSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);

        const result = await handleOAuthRequest(accessToken, this.context.oAuth, this.context.afnemerID, this.context.apiUrl, dataTable);
        this.context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        await executeSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);

        this.context.response = await postBevragenRequestWithBasicAuth(this.context.apiUrl, this.context.extraHeaders, dataTable);
    }
});

Then(/^heeft de response een '(\w*)' met de volgende gegevens$/, function (_, dataTable) {
    this.context.verifyResponse = true;

    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }

    this.context.expected.push(expected);
});

Then(/^heeft de response een '(\w*)' met de volgende '(\w*)' gegevens$/, function (_, gegevensgroep, dataTable) {
    this.context.verifyResponse = true;

    const expected = {};
    expected[gegevensgroep] = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }

    this.context.expected.push(expected);
});

Then(/^heeft het '(\w*)' de volgende '(\w*)' gegevens$/, function (objectName, gegevensgroep, dataTable) {
    const expectedArray = this.context.expected;
    should.exist(expectedArray, `Geen ${objectName} lijst gevonden`);
    expectedArray.length.should.not.equal(0, `Leeg ${objectName} lijst`);

    const expected = expectedArray.at(-1);

    expected[gegevensgroep] = createObjectFrom(dataTable);
});

Then(/^heeft de response (\d*) reisdocumenten$/, function (aantal) {
    const actual = this.context?.response?.data?.reisdocumenten;

    should.exist(actual);
    actual.length.should.equal(Number(aantal), `aantal reisdocumenten in response is ongelijk aan ${aantal}\nReisdocumenten: ${JSON.stringify(actual, null, '\t')}`);
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    this.context.expected = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.expected[gegevensgroep] = dataTable.hashes();
});

After({tags: 'not @fout-case'}, function() {

    const actual = this.context?.response?.data.reisdocumenten !== undefined
        ? this.context.response.data.reisdocumenten
        : [];
    const expected = this.context.expected;

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

After({tags: '@fout-case'}, async function() {
    const headers = this.context?.response?.headers;
    should.exist(headers, 'no response headers found');

    const header = headers["content-type"];
    should.exist(header, "no header found with name 'content-type'");
    header.should.contain('application/problem+json', "no 'content-type' header found with value: 'application/problem+json'");

    const actual = this.context?.response?.data !== undefined
        ? stringifyValues(this.context.response.data)
        : {};
    const expected = this.context.expected;

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

Before(function() {
    if(this.context.sql.useDb && pool === undefined) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if(pool === undefined ||
        !this.context.sql.cleanup ||
        this.context.sqlData === undefined) {
        return;
    }

    await rollbackSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);
});

function getNextStapelNr(sqlData, relatie) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(relatie)){
            stapelNr = Number(key.replace(`${relatie}-`, ''));
        }
    });

    return stapelNr+1;
}
