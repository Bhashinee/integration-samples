import ballerina/http;
import ballerina/io;

configurable string name = ?;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        io:println(ftpPassword);
        return ftpPassword;
    }
}

