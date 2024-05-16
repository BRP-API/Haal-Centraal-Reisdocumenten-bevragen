const { When } = require('@cucumber/cucumber');
const fs = require('fs');
const { executeSqlStatements } = require('./postgresqlHelpers');
const { addDefaultAutorisatieSettings,
        handleRequest } = require('./requestHelpers');

const apiEndpointPrefixMap = new Map([
    ['personen', 'brp'],
    ['reisdocumenten', 'reisdocumenten'],
    ['bestaat-niet', 'brp']
]);

When(/^([a-zA-Z-]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
    }

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify(this.context.gezag, null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined) {
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json',
                         JSON.stringify(this.context.downstreamApiResponseHeaders[0], null, '\t'));
    }

    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{}];
    }
    addDefaultAutorisatieSettings(this.context, this.context.afnemerID);

    await executeSqlStatements(this.context.sql, this.context.sqlData, global.pool);

    await handleRequest(this.context, `${apiEndpointPrefixMap.get(endpoint)}/${endpoint}`, dataTable);
});

When(/^([a-zA-Z-]*) wordt gezocht met een '(\w*)' aanroep$/, async function (endpoint, httpMethod) {
    if(this.context.afnemerID === undefined) {
        this.context.afnemerID = this.context.oAuth.clients[0].afnemerID;
    }

    await handleRequest(this.context, `${apiEndpointPrefixMap.get(endpoint)}/${endpoint}`, undefined, httpMethod);
});
