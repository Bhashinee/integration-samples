import ballerina/io;
import ballerina/time;
import bishidev/private_package as pp;


public function main() returns error? {
    // Get the current timestamp
    time:Utc currentTime = time:utcNow();
    string formattedTime = time:utcToString(currentTime);
    io:println(testFunction());
    // Print the timestamp in UTC format
    io:println("Current timestamp 2: " + formattedTime);
}

function testFunction() returns string {
    io:println(pp:privateFunction());
    return pp:privateFunction();
}


