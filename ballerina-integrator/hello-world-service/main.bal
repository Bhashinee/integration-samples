import ballerina/http;

string serviceurl = "http://tailscale-689458782:9090/";
string choreoapikey = "chk_eyJjb25uZWN0aW9uLWlkIjoiMDFmMDcyODQtNzE0My0xYmU4LWExNDItNmQ4MGJkMWNhODRhIn0=gs9Z2g";
http:Client httpClient = check new (serviceurl);

service / on new http:Listener(9090) {

    resource function get greeting() returns string|error {
        string payload = check httpClient->/hello({ "Choreo-API-Key": choreoapikey });
        return payload;
    }
}

