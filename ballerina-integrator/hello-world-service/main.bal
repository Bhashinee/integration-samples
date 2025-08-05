import ballerina/http;
import ballerina/os;

string serviceurl = os:getEnv("CHOREO_TAILCON_SERVICEURL");
string choreoapikey = os:getEnv("CHOREO_TAILCON_CHOREOAPIKEY");
http:Client httpClient = check new (serviceurl);

service / on new http:Listener(9090) {

    resource function get greeting() returns string|error {
        string payload = check httpClient->/hello({ "Choreo-API-Key": choreoapikey });
        return payload;
    }
}
