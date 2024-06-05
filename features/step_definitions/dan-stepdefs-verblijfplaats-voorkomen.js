const { Then } = require('@cucumber/cucumber');
const { createCollectieObjecten } = require('./dataTable2ObjectFactory');

Then(/^heeft de response verblijfplaatsen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    createCollectieObjecten(this.context, 'verblijfplaats', dataTable);
});
