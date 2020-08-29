package com.miao.flutter_app.v1;

public interface IApLinkSender {
    public void init() throws Exception;
    public <T> T send(Object body, Class<T> clazz) throws Exception;
    public void destroy();
}
