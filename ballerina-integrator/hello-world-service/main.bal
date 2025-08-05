import ballerina/http;
import ballerina/os;

string serviceurl = os:getEnv("CHOREO_TAILCON_SERVICEURL");
string choreoapikey = os:getEnv("CHOREO_TAILCON_CHOREOAPIKEY");
http:Client httpClient = check new (serviceUrl);

service / on new http:Listener(9090) {

    resource function get greeting() returns string|error {
        http:Request req = new;
        req.setHeader("Choreo-API-Key", choreoApiKey);
        
        http:Response resp = check httpClient->get("/hello", req);
        string payload = check resp.getTextPayload();
        return payload;
    }
}
