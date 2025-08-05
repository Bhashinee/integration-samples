import ballerina/http;

string serviceurl = "http://tailscale-689458782:9090/";
string choreoapikey = "chk_eyJjb25uZWN0aW9uLWlkIjoiMDFmMDcyMjAtMjAwMS0xZTM4LWJjODctYWExNWE3NGFlYTQ0In0=oItpjA";
http:Client httpClient = check new (serviceurl);

service / on new http:Listener(9090) {

    resource function get greeting() returns string|error {
        string payload = check httpClient->/hello({ "Choreo-API-Key": choreoapikey });
        return payload;
    }
}

