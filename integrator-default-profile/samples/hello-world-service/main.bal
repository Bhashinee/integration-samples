import ballerina/http;
import ballerina/io;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        io:println("Payload2");
        return "payload2";
    }
}

