package com.example.flutter_app.v1;

class ApLinkConfigRequest extends ApLinkCommand<ApLinkConfigPayload> {

    public ApLinkConfigRequest() {
        setId(30005);
    }

    public ApLinkConfigRequest(ApLinkConfigPayload payload) {
        this();
        setPayload(payload);
    }
}
