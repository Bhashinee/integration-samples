import ballerina/http;
import ballerina/io;
import ballerina/data.yaml;

configurable string name = ?;
configurable json content = ?;

int sport = 8095;

service / on new http:Listener(sport) {

    resource function get greeting() returns string|error {
        io:println(ftpPassword);
        io:println(name);
        io:println(content);
        yaml:parseString(yamlString);
        return ftpPassword;
    }
}

