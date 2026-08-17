import ballerina/ftp;
import ballerina/io;
import ballerina/observe as _;
import ballerinax/metrics.logs as _;
import ballerina/lang.runtime;

// Listen for weather data files on an FTP server
listener ftp:Listener WeatherData = new (
    auth = {
        credentials: {
            username: ftpUser,
            password: ftpPassword
        }
    },
    protocol = ftp:SFTP,
    host = ftpHost,
    port = 22,
    pollingInterval = 60 // Check for new files every 10 seconds
);

ftp:Client ftpClient = check new ({
    protocol: ftp:SFTP,
    host: ftpHost,
    port: 22,
    auth: {
        credentials: {
            username: ftpUser,
            password: ftpPassword
        }
    }
});

// Triggered when new files are added to the FTP path
service ftp:Service on WeatherData {
    remote function onFileText(string content, ftp:FileInfo fileInfo, ftp:Caller caller) returns error? {
        io:println("---------------New file detected----------------");
        runtime:sleep(10);
        // boolean exists = check caller->exists("/providentbijiraanddevant/zz.txt");
        // if exists {
        //     byte[] _ = check caller->getBytes("/providentbijiraanddevant/zz.txt");
        //     check caller->delete("/providentbijiraanddevant/zz.txt");
        //     io:println("---------------Deleted the zz.txt file----------------");
        // }    
        // --- operation.type: put ---
        boolean exists = check caller->exists("/providentbijiraanddevant/test.txt");
        io:println("---------------Putting text file----------------");
        if exists {
            check caller->delete("/providentbijiraanddevant/test.txt");
            io:println("---------------Deleted the test.txt file----------------");
        } else {}
        check ftpClient->putText("/providentbijiraanddevant/test.txt", "Hello, FTP!");
        io:println("---------------Put text file----------------");
    }

    }
