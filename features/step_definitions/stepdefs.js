const { World } = require('./world');
const { Pool } = require('pg');
const { setWorldConstructor, setDefaultTimeout, Before, After, AfterAll } = require('@cucumber/cucumber');
const { valideer200Response, valideerProblemDetailsResponse } = require('./responseHelpers');
const { rollbackSqlStatements } = require('./postgresqlHelpers');
const fs = require('fs');

setWorldConstructor(World);

// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(30000);

After({tags: 'not @fout-case'}, function({ pickle }) {
    valideer200Response(this.context, !pickle.tags.map((t) => t.name).includes('@valideer-volgorde'));
});

After({tags: '@fout-case'}, function() {
    valideerProblemDetailsResponse(this.context);
});

AfterAll(async function() {
    if(global.pool === undefined) {
        return;
    }

    global.logger.debug(`end pool. Counts => total: ${global.pool.totalCount}, idle: ${global.pool.idleCount}, waiting: ${global.pool.waitingCount}`);
    await global.pool.end();
    global.logger.debug(`pool ended. Counts => total: ${global.pool.totalCount}, idle: ${global.pool.idleCount}, waiting: ${global.pool.waitingCount}`);
});

Before(function({ pickle }) {
    global.scenario = {
        name: pickle.name,
        tags: pickle.tags.map((t) => t.name)
    };

    if(global.logger === undefined) {
        global.logger = this.context.logger;
        global.logger.debug('set global logger');
    }

    if(global.pool === undefined) {
        global.logger.debug('create db pool');
        global.pool = new Pool(this.context.sql.poolConfig);
    }

    if(this.context.logFileToAssert !== undefined && fs.existsSync(this.context.logFileToAssert)) {
        const array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
        this.context.nrOfLogLines = array.length;
    }
});

Before({tags: '@api'}, function() {
    global.logger.debug('api scope. set baseUrl to apiUrl');
    this.context.baseUrl = this.context.apiUrl;
});

Before({tags: '@proxy'}, function() {
    global.logger.debug('proxy scope. set baseUrl to proxyUrl');
    this.context.baseUrl = this.context.proxyUrl;
});

Before({tags: '@mock'}, function() {
    global.logger.debug('mock scope. set baseUrl to mockUrl');
    this.context.baseUrl = this.context.mockUrl;
});

Before({tags: '@input-validatie'}, function() {
    global.logger.debug('input-validatie scope. set baseUrl to autzUrl');
    this.context.baseUrl = this.context.autzUrl;
});

Before({tags: '@autorisatie'}, function() {
    global.logger.debug('autorisatie scope. set baseUrl to autzUrl');
    this.context.baseUrl = this.context.autzUrl;
});

Before({tags: '@protocollering'}, function() {
    global.logger.debug('protocollering scope. set baseUrl to autzUrl');
    this.context.baseUrl = this.context.autzUrl;
});

After(async function({ pickle }) {
    if(pickle.tags.map((t) => t.name).includes('@stap-documentatie')) {
        return;
    }
    await rollbackSqlStatements(this.context.sql, this.context.sqlData, global.pool);

    if(this.context.gezag !== undefined) {
        fs.writeFileSync(this.context.gezagDataPath, JSON.stringify([], null, '\t'));
    }
    if(this.context.downstreamApiResponseHeaders !== undefined){
        fs.writeFileSync(this.context.downstreamApiDataPath + '/response-headers.json', JSON.stringify({}, null, '\t'));
    }
    if(this.context.downstreamApiResponseBody !== undefined){
        fs.rmSync(this.context.downstreamApiDataPath + '/response-body.json');
    }

    if(this.context.logFileToAssert !== undefined && fs.existsSync(this.context.logFileToAssert)) {
        const array = fs.readFileSync(this.context.logFileToAssert).toString().split("\n");
        if(this.context.nrOfLogLines + 1 !== array.length) {
            global.logger.warn(`${global.scenario.name}. nr of loglines ${array.length} should be ${this.context.nrOfLogLines + 1}`);
        }
    }
});