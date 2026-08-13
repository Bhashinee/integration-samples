import ballerina/os;

string ftpPassword = os:getEnv("password");
configurable string ftpUser = "username";