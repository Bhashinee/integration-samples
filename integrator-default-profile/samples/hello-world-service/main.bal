import ballerina/http;
import ballerina/io;
import ballerina/observe as _;
import ballerinax/metrics.logs as _;
import ballerinax/jaeger as _;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        io:println("Payload2");
        return "payload2";
    }
}

