import ballerina/http;
import ballerina/io;

configurable string name = ?;
configurable string content = ?;
configurable string yamlContent = ?;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        io:println(ftpPassword);
        io:println(name);
        io:println(content);
        return ftpPassword;
    }
}

