import ballerina/http;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        return "payload2";
    }
}

