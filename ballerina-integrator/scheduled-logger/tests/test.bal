import ballerina/test;

@test:Config
function intAddTest() {
    test:assertEquals(testFunction(), "This is a private function.");
}