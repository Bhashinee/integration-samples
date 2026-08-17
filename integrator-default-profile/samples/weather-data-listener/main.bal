import ballerina/ftp;
import ballerina/io;
import ballerina/observe as _;
import ballerinax/metrics.logs as _;

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
    pollingInterval = 1800 // Check for new files every 10 seconds
);

// ftp:Client ftpClient = check new ({
//     protocol: ftp:SFTP,
//     host: ftpHost,
//     port: 22,
//     auth: {
//         credentials: {
//             username: ftpUser,
//             password: ftpPassword
//         }
//     }
// });

@ftp:ServiceConfig {
    path: "/providentbijiraanddevant/sftpTest",
    fileNamePattern: ".*\\.txt"
}
// Triggered when new files are added to the FTP path
service ftp:Service on WeatherData {
    remote function onFileText(string content, ftp:FileInfo fileInfo, ftp:Caller caller) returns error? {
        io:println("---------------New file detected----------------");
        boolean exists = check caller->exists("/providentbijiraanddevant/sftpTest/data.csv");
        if exists {
            string[][] csvContent = check caller->getCsv("/providentbijiraanddevant/sftpTest/data.csv");
            io:println("getCsv rows: " + csvContent.length().toString());

            check caller->rename("/providentbijiraanddevant/sftpTest/data.csv", "/providentbijiraanddevant/sftpTest/data1.csv");
            io:println("---------------Renamed the data.csv file to data1.csv----------------");

            io:println("---------------Deleting csv file----------------");
            check caller->delete("/providentbijiraanddevant/sftpTest/data1.csv");
            io:println("---------------Deleted the data.csv file----------------");
        } else {
            io:println("---------------Putting CSV file----------------");
            check caller->putCsv("/providentbijiraanddevant/sftpTest/data.csv", [["name", "age"], ["Alice", "30"]]);
            io:println("---------------Put CSV file----------------");
        }
    }
}
