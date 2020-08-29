package com.miao.flutter_app.v1;

import android.content.Context;
import android.util.Log;

import com.alibaba.fastjson.JSON;

public final class ApConfiger {

    private static final String TAG = ApConfiger.class.getSimpleName();
    private static final int RETRY_MAX_TIMES = 5;

    private Context context;
    private String apSsid;
    private String apIpAddress;
    private String localIpAddress;
    private boolean started;

    private ApLinkHttpSender httpSender;
    private ApLinkUdpSender udpSender;
    private ApConfigResult configResult;


    public ApConfiger(Context context) {
        this.context = context;
    }

    public void init(String apSsid, String apIpAddress, String localIpAddress) {
        this.apSsid = apSsid;
        this.apIpAddress = apIpAddress;
        this.localIpAddress = localIpAddress;

        ApLinkEncrypter encrypter = new ApLinkEncrypter(localIpAddress, apSsid);
        httpSender = new ApLinkHttpSender(context, apIpAddress, encrypter);
        udpSender = new ApLinkUdpSender(context, apIpAddress, encrypter);
        configResult = new ApConfigResult();
        started = true;

        try {
            httpSender.init();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            udpSender.init();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean configAp(String ssid, String password, String userData) throws ApLinkCanceldException {

        IApLinkSender[] senders = new IApLinkSender[]{httpSender, udpSender};
        for (IApLinkSender sender: senders) {
            runConfigApTask(sender, ssid, password, userData);
        }

        while (started) {

            synchronized (configResult) {

                try {
                    configResult.wait(100);
                } catch (InterruptedException e) {
                }

                if (configResult.canceled > 0) {
                    throw new ApLinkCanceldException("ap config task is canceled");
                }else if (configResult.succeed > 0) {
                    return true;
                }else if (configResult.failed >= senders.length) {
                    return false;
                }
            }
        }

        throw new ApLinkCanceldException("ap config task is canceled");
    }
    
    public void destroy() {
        started = false;
        if (httpSender != null) {

            try {
                httpSender.destroy();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (udpSender != null) {

            try {
                udpSender.destroy();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void runConfigApTask(final IApLinkSender sender, final String ssid, final String password, final String userData) {

        new Thread(new Runnable() {
            @Override
            public void run() {

                Boolean result = null;
                try {
                    result = configApAction(sender, ssid, password, userData);
                } catch (ApLinkCanceldException e) {
                }

                synchronized (configResult) {

                    if (result == null) {
                        configResult.canceled += 1;
                    }else if (result) {
                        configResult.succeed += 1;
                    }else {
                        configResult.failed += 1;
                    }

                    configResult.notifyAll();
                }
            }
        }).start();
    }

    private boolean configApAction(IApLinkSender sender, String ssid, String password, String userData) throws ApLinkCanceldException {

        if (!setAp(sender, ssid, password, userData)) {
            Log.w(TAG, String.format("set ap-%s to link '%s' failed", apSsid, ssid));
            return false;
        }
        Log.d(TAG, String.format("set ap-%s to link '%s' succeed", apSsid, ssid));

        if (!restartAp(sender)) {
            Log.w(TAG, String.format("restart ap-%s failed", apSsid));
            return false;
        }
        Log.d(TAG, String.format("restart ap-%s succeed", apSsid));

        return true;
    }

    private boolean setAp(IApLinkSender sender, String ssid, String password, String userData) throws ApLinkCanceldException {

        ApLinkConfigPayload payload = new ApLinkConfigPayload(ssid, password, userData);
        ApLinkConfigRequest request = new ApLinkConfigRequest(payload);
        ApLinkConfigLinkResponse response = sendApCommand(sender, request, ApLinkConfigLinkResponse.class);
        if (response != null) {
            return response.isValid();
        }

        return false;
    }

    private boolean restartAp(IApLinkSender sender) throws ApLinkCanceldException {

        ApLinkRestartRequest request = new ApLinkRestartRequest();
        ApLinkRestartResponse response = sendApCommand(sender, request, ApLinkRestartResponse.class);
        if (response != null) {
            return response.isValid();
        }

        return false;
    }

    private <T extends ApLinkResponse> T sendApCommand(IApLinkSender sender, ApLinkCommand command, Class<T> clazz) throws ApLinkCanceldException {

        T response = null;

        for (int i = 1; i <= RETRY_MAX_TIMES && started; i++) {

            try {
                response = sender.send(command, clazz);
                Log.d(TAG, String.format("%s sends command at the No.%s time succeed: %s", sender.getClass().getSimpleName(), i, JSON.toJSONString(command)));

                if (response != null && (response.isValid() || !response.isSupported())) {
                    break;
                }
            } catch (Exception e) {
                Log.w(TAG, String.format("%s sends command at the No.%s time failed: %s, failed-message: %s",
                        sender.getClass().getSimpleName(), i, JSON.toJSONString(command), e.getMessage()));
            }

            try {
                Thread.sleep(100);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        if (!started) {
            throw new ApLinkCanceldException("ap link task is canceled when send ap command: " + JSON.toJSONString(command));
        }

        return response;
    }

    private class ApConfigResult {
        private int failed;
        private int succeed;
        private int canceled;
    }
}
