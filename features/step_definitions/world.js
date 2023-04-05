class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.proxyUrl = "http://localhost:5010/haalcentraal/api";
        this.context.apiUrl = "";
        this.context.extraHeaders = [
            { "naam": "Authorization", "waarde": "" }
        ];
        this.context.oAuth = {
            enable: false,
            accessTokenUrl: "",
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
