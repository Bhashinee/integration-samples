import ballerina/test;

@test:Config
public function testHelloEndpoint() returns error? {
    test:assertEquals(ftpPassword, "1234");
}
