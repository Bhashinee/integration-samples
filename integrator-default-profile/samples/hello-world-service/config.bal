import ballerina/os;

configurable string ftpPassword = os:getEnv("password");
configurable string ftpUser = "username";