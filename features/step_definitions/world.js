class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.proxyUrl = "http://localhost:5003/haalcentraal/api/reisdocumenten";
        this.context.apiUrl = "http://localhost:8001/haalcentraal/api/reisdocumenten";
        //this.context.apiUrl = "https://5cba8c70-68c2-4d9b-94e8-3ea8e047e7f8.mock.pstmn.io";
        this.context.extraHeaders = [
            { "naam": "Authorization", "waarde": "" }
        ];
        this.context.sql = {
            useDb: true,
            logStatements: false,
            cleanup: true,
            poolConfig: {
                user: "root",
                host: "host.docker.internal",
                database: "rvig_haalcentraal_testdata",
                password: "root",
                port: 5440,
                allowExitOnIdle: true
            }
        };
        this.context.oAuth = {
            enable: false,
            accessTokenUrl: "https://login.dev.idsecure.nl/nidp/oauth/nam/token",
            clients:[
                {
                    afnemerID: "000008",
                    clientId: "",
                    clientSecret: "",
                    scopes: ["000000099000000080000"]
                }
            ]
        }
        if(this.context.parameters?.poolConfig !== undefined) {
            this.context.sql.poolConfig.host = this.context.parameters.poolConfig.host;
            this.context.sql.poolConfig.user = this.context.parameters.poolConfig.user;
            this.context.sql.poolConfig.password = this.context.parameters.poolConfig.password
        }
        if(this.context.parameters?.client !== undefined) {
            this.context.oAuth.clients[0].clientId = this.context.parameters.client.clientId; 
            this.context.oAuth.clients[0].clientSecret = this.context.parameters.client.clientSecret; 
        }
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
// process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = { World }
