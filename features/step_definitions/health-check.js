const { When, Then } = require('@cucumber/cucumber');

When('een GET request wordt gedaan naar het health check endpoint van de Autorisatie en Protocollering Proxy', async function () {
  // parse the base URL from the apiUrl by extracting the protocol and host (without the path)
  const url = new URL(this.context.apiUrl);
  const baseUrl = `${url.protocol}//${url.host}`;

  const response = await fetch(`${baseUrl}/health/ready`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  });

  this.context.response = {
    status: response.status,
    body: await response.json()
  };
});

Then('is de response healthy', function () {
  const response = this.context.response;
  response.status.should.equal(200);
  response.body.status.should.equal('Healthy');
});

