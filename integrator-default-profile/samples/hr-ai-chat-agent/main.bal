import ballerina/http;
import ballerinax/ai.agent;
import ballerinax/metrics.logs as _;

listener agent:Listener hrRagAgentListener = new (listenOn = check http:getDefaultListener());

service /hrRagAgent on hrRagAgentListener {
    resource function post chat(@http:Payload agent:ChatReqMessage request) returns agent:ChatRespMessage|error {
        string agentResponse = check llmChat(request.message);
        return {message: agentResponse};
    }
}
