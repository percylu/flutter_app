package com.miao.flutter_app;;

import androidx.annotation.NonNull;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class HanfengSmartlinkPlugin implements MethodChannel.MethodCallHandler {
    private final Registrar mRegistrar;

    public HanfengSmartlinkPlugin(Registrar mRegistrar) {
        this.mRegistrar = mRegistrar;
    }

    /** Plugin registration. */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "hanfeng_smartlink");
        channel.setMethodCallHandler(new HanfengSmartlinkPlugin(registrar));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        }else{
            result.notImplemented();
        }
    }
}
