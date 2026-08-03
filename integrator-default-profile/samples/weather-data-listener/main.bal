import ballerina/ftp;
import ballerina/io;
import ballerina/log;
import ballerinax/metrics.logs as _;
import ballerina/observe as _;

// Listen for weather data files on an FTP server
listener ftp:Listener WeatherData = new (
    path = "/providentbijiraanddevant",
    auth = {
        credentials: {
            username: ftpUser,
            password: ftpPassword
        }
    },
    protocol = ftp:SFTP,
    host = ftpHost,
    port = 22,
    pollingInterval = 10, // Check for new files every 10 seconds
    fileNamePattern = "(.*).txt" // Process only .TXT files
);

// Triggered when new files are added to the FTP path
service ftp:Service on WeatherData {
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        io:println("New file(s) detected on FTP server.");
        do {
            // Process each newly added file
            foreach ftp:FileInfo addedFile in event.addedFiles {
                io:println("File found " + addedFile.pathDecoded);
                // Get file content as a byte stream
                stream<byte[] & readonly, io:Error?> fileStream = check caller->get(addedFile.pathDecoded);
                // Read the first chunk of data
                record {|byte[] value;|}? content = check fileStream.next();

                if content is record {|byte[] value;|} {
                    // Convert byte data to string
                    string fileContent = check string:fromBytes(content.value);

                    // Extract the first line 
                    int? firstLineIndex = fileContent.indexOf("\n");
                    if firstLineIndex is int {
                        string location = fileContent.substring(0, firstLineIndex);
                        log:printInfo("Received weather information from: " + location);
                    }
                } else {
                    log:printError("Failed to read weather content");
                }
            }
        } on fail error err {
            // Log unexpected errors during processing
            log:printError("Error: " + err.message());
        }
    }
}
