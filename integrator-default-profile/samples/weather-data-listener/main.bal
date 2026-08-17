import ballerina/ftp;
import ballerina/io;
import ballerina/observe as _;
import ballerinax/metrics.logs as _;

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
        // boolean exists = check caller->exists("/providentbijiraanddevant/zz.txt");
        // if exists {
        //     byte[] _ = check caller->getBytes("/providentbijiraanddevant/zz.txt");
        //     check caller->delete("/providentbijiraanddevant/zz.txt");
        //     io:println("---------------Deleted the zz.txt file----------------");
        // }
        json value = {name: "test", value: 42};
        // --- operation.type: put ---
        io:println("---------------Putting text file----------------");
        check ftpClient->putText("/providentbijiraanddevant/test.txt", "Hello, FTP!");
        io:println("---------------Put text file----------------");
        check ftpClient->putBytes("/providentbijiraanddevant/bytes.bin", "binary content".toBytes());
        io:println("---------------Put bytes file----------------");
        check ftpClient->putJson("/providentbijiraanddevant/data.json", value);
        io:println("---------------Put json file----------------");
        check ftpClient->putXml("/providentbijiraanddevant/data.xml", xml `<root><item>hello</item></root>`);
        io:println("---------------Put xml file----------------");
        check ftpClient->putCsv("/providentbijiraanddevant/data.csv", [["name", "age"], ["Alice", "30"]]);
        io:println("---------------Put csv file----------------");

        // --- operation.type: mkdir ---
        check ftpClient->mkdir("/providentbijiraanddevant/newdir");
        io:println("---------------Created new directory----------------");

        // --- operation.type: get ---
        string text = check ftpClient->getText("/providentbijiraanddevant/test.txt");
        io:println("getText: " + text);

        byte[] bytes = check ftpClient->getBytes("/providentbijiraanddevant/bytes.bin");
        io:println("getBytes length: " + bytes.length().toString());

        json jsonContent = check ftpClient->getJson("/providentbijiraanddevant/data.json");
        io:println("getJson: " + jsonContent.toString());

        xml xmlContent = check ftpClient->getXml("/providentbijiraanddevant/data.xml");
        io:println("getXml: " + xmlContent.toString());

        string[][] csvContent = check ftpClient->getCsv("/providentbijiraanddevant/data.csv");
        io:println("getCsv rows: " + csvContent.length().toString());

        // --- operation.type: rename ---
        check ftpClient->rename("/providentbijiraanddevant/bytes.bin", "/providentbijiraanddevant/bytes_renamed.bin");
        io:println("---------------Renamed file----------------");

        // --- operation.type: copy ---
        check ftpClient->copy("/providentbijiraanddevant/test.txt", "/providentbijiraanddevant/test_copy.txt");
        io:println("---------------Copied file----------------");

        // --- operation.type: move ---
        check ftpClient->move("/providentbijiraanddevant/test_copy.txt", "/providentbijiraanddevant/newdir/test_copy.txt");
        io:println("---------------Moved file----------------");

        // --- operation.type: delete ---
        check ftpClient->delete("/providentbijiraanddevant/test.txt");
        io:println("---------------Deleted file----------------");
        check ftpClient->delete("/providentbijiraanddevant/bytes_renamed.bin");
        io:println("---------------Deleted renamed file----------------");
        check ftpClient->delete("/providentbijiraanddevant/data.json");
        io:println("---------------Deleted json file----------------");
        check ftpClient->delete("/providentbijiraanddevant/data.xml");
        io:println("---------------Deleted xml file----------------");
        check ftpClient->delete("/providentbijiraanddevant/data.csv");
        io:println("---------------Deleted csv file----------------");
        check ftpClient->delete("/providentbijiraanddevant/newdir/test_copy.txt");
        io:println("---------------Deleted moved file----------------");
    }
}
