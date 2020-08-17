package com.example.flutter_app.v1;

import android.content.Context;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.example.flutter_app.IApLinkEncrypter;

import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;

public class ApLinkUdpSender implements IApLinkSender {

    private static final String TAG = ApLinkUdpSender.class.getSimpleName();
    private static final int PORT = 48888;
    private static final int TIMEOUT = 5000;
    private Context context;
    private String apIpAddress;
    private IApLinkEncrypter apLinkEncrypter;
    private DatagramSocket socket;

    public ApLinkUdpSender(Context context, String apIpAddress, IApLinkEncrypter apLinkEncrypter) {
        this.context = context;
        this.apIpAddress = apIpAddress;
        this.apLinkEncrypter = apLinkEncrypter;
    }

    @Override
    public void init() throws Exception {
        socket = new DatagramSocket();
        socket.setSoTimeout(TIMEOUT);
    }

    @Override
    public void destroy() {
        socket.close();
        Log.d(TAG, "destroy");
    }

    @Override
    public <T> T send(Object body, Class<T> clazz) throws Exception {

        String encryptedBody = apLinkEncrypter.encrypt(body == null ? "" : JSON.toJSONString(body));
        Log.d(TAG, String.format("plain body-%s, encrypted body: %s", JSON.toJSONString(body), encryptedBody));

        try {

            byte[] bytes = encryptedBody.getBytes();
            DatagramPacket packet2Send = new DatagramPacket(bytes, bytes.length, InetAddress.getByName(apIpAddress), PORT);
            socket.send(packet2Send);

            byte[] data = new byte[4096];
            DatagramPacket packet2Receive = new DatagramPacket(data, data.length);
            socket.receive(packet2Receive);

            String responseBody = new String(data, 0, packet2Receive.getLength());
            if (!responseBody.isEmpty()) {

                Log.d(TAG, String.format("response encrypted body-%s", responseBody));

                String decryptedBody = apLinkEncrypter.decrypt(responseBody);
                Log.i(TAG, String.format("send apIpAddress-%s, body-%s, response body-%s", apIpAddress, JSON.toJSONString(body), decryptedBody));

                return JSON.parseObject(decryptedBody, clazz);
            }
        } catch (Exception e) {
            throw e;
        }

        return null;
    }
}
