public with sharing class ServiceThatUsesNamedCredential {
    public void doSomethingWithANamedCredential() {
        HttpRequest request = new HttpRequest();
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint('callout:Amazon_API_Gateway/anEndpoint');
        request.setMethod('POST');

        new Http().send(request);
    }
}
