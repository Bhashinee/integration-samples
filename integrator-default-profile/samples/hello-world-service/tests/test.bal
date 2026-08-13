import ballerina/test;
import ballerina/http;

@test:Config
public function testHelloEndpoint() returns error? {
    // Assumes the hello-world service is running on localhost:9090 with /hello resource
    http:Client client1 = check new ("http://localhost:9090");
    string res = check client1->get("/hello");

    test:assertEquals(res, "1234", msg = "Not returning the proper response from the hello-world service");
}
