package com.example.flutter_app;;

public interface IApLinkEncrypter {

    public String encrypt(String plain) throws Exception;
    public String decrypt(String encrypted) throws Exception;
}
