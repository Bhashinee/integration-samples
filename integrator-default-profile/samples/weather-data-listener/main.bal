import ballerinax/metrics.logs as _;
import ballerina/observe as _;
import ballerina/ftp;
import ballerina/log;

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
    pollingInterval = 10 // Check for new files every 10 seconds
);

// Triggered when new files are added to the FTP path
service ftp:Service on WeatherData {
    remote function onFileText(string content, ftp:FileInfo fileInfo, ftp:Caller caller) returns error? {
        log:printInfo("New file detected", path = fileInfo.path, size = fileInfo.size);
        boolean exists = check caller->exists("/providentbijiraanddevant/zz.txt");
        if exists {
            byte[] _ = check caller->getBytes("/providentbijiraanddevant/zz.txt");
            check caller->delete("/providentbijiraanddevant/zz.txt");
        }
    }
}
