const reporter = require('cucumber-html-reporter');
const apiName = 'Haal Centraal Reisdocumenten Bevragen API';
const gbaVersion = `GBA ${process.argv[2]}`
const proxyVersion = `Proxy ${process.argv[3]}`

const features = new Map([
    ['zoeken-en-raadplegen', 'zoeken & raadplegen']
]);

features.forEach((value, key) => {
    reporter.generate({
        theme: 'bootstrap',
        jsonFile: `docs/features/test-result-${key}-gba.json`,
        output: `docs/features/test-report-${key}-gba.html`,
        noInlineScreenshots: true,
        reportSuiteAsScenarios: true,
        scenarioTimestamp: true,
        launchReport: false,
        name:`${value} features`,
        brandTitle: `${apiName} - ${gbaVersion}`
    });
    reporter.generate({
        theme: 'bootstrap',
        jsonFile: `docs/features/test-result-${key}.json`,
        output: `docs/features/test-report-${key}.html`,
        noInlineScreenshots: true,
        reportSuiteAsScenarios: true,
        scenarioTimestamp: true,
        launchReport: false,
        name: `${value} features`,
        brandTitle: `${apiName} - ${proxyVersion}`
    });
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-autorisatie-gba.json',
    output: 'docs/features/test-report-autorisatie-gba.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'autorisatie features',
    brandTitle: `${apiName} - ${gbaVersion}`
});

reporter.generate({
    theme: 'bootstrap',
    jsonFile: 'docs/features/test-result-protocollering-gba.json',
    output: 'docs/features/test-report-protocollering-gba.html',
    noInlineScreenshots: true,
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false,
    name:'protocollering features',
    brandTitle: `${apiName} - ${gbaVersion}`
});
