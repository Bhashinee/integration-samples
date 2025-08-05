import ballerina/http;

string serviceurl = os:getEnv("CHOREO_TAILSCALE_CONNECTION_SERVICEURL");
string choreoapikey = os:getEnv("CHOREO_TAILSCALE_CONNECTION_CHOREOAPIKEY");
http:Client httpClient = check new (serviceURL);

service / on new http:Listener(9090) {

    // This function responds with `string` value `Hello, World!` to HTTP GET requests.
    resource function get greeting() returns string {
        http:Request req = new;
        req.setHeader("Choreo-API-Key", choreoApiKey);
       // Provide the correct resource path
       http:Response payload = check httpClient->/hello(req);
       return payload;
    }
}
