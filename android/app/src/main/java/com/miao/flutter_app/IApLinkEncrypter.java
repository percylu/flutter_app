package com.miao.flutter_app;;

public interface IApLinkEncrypter {

    public String encrypt(String plain) throws Exception;
    public String decrypt(String encrypted) throws Exception;
}
