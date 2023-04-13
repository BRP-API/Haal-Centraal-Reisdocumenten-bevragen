class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.proxyUrl = "http://localhost:5010/haalcentraal/api/reisdocumenten";
        this.context.apiUrl = "http://localhost:8001/haalcentraal/api/reisdocumenten";
        this.context.extraHeaders = [
            { "naam": "Authorization", "waarde": "" }
        ];
        this.context.sql = {
            useDb: true,
            logStatements: true,
            cleanup: true,
            poolConfig: {
                user: "",
                host: "localhost",
                database: "rvig_haalcentraal_testdata",
                password: "",
                port: 5432,
                allowExitOnIdle: true
            }
        };
        this.context.oAuth = {
            enable: true,
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
    }
}

// set this environment variable to bypass DEPTH_ZERO_SELF_SIGNED_CERT error when using self-signed certificates
process.env.NODE_TLS_REJECT_UNAUTHORIZED = "0";

module.exports = { World }
