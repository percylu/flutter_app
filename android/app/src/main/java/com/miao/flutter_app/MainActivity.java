package com.miao.flutter_app;



import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.location.LocationManager;
import android.net.wifi.WifiInfo;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import com.miao.flutter_app.v1.ApLinker;

import io.flutter.embedding.android.FlutterActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;



import permissions.dispatcher.NeedsPermission;
import permissions.dispatcher.OnNeverAskAgain;
import permissions.dispatcher.OnPermissionDenied;
import permissions.dispatcher.RuntimePermissions;
import android.provider.Settings;
import android.widget.Toast;

import com.mob.pushsdk.MobPush;
import com.mob.pushsdk.MobPushCustomMessage;
import com.mob.pushsdk.MobPushNotifyMessage;
import com.mob.pushsdk.MobPushReceiver;
import com.mob.pushsdk.MobPushUtils;

import org.json.JSONArray;
import org.json.JSONObject;
@RuntimePermissions
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "hanfeng_smartlink";
    private static final String TAG = "ApLinker:MainActivity";
    private static final String KEY_AP_SSID = "ap_ssid";
    private static final String KEY_AP_PASSWORD = "ap_password";
    private static final String KEY_SSID_FORMAT = "ssid_%s";
    private ApLinker mApLinker;
    private AlertDialog mAlertDialog;

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // GeneratedPluginRegistrant.registerWith(getFlutterEngine());
        MobPush.addPushReceiver(new MobPushReceiver() {
           
            @Override
            public void onCustomMessageReceive(Context context, MobPushCustomMessage message) {
//接收自定义消息
                Toast.makeText(context, "接收到自定义消息:" + message.getContent(), Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onNotifyMessageReceive(Context context, MobPushNotifyMessage message) {
//接收通知消息
                Toast.makeText(context, "接收到通知消息:" + message.getTitle() + "\n内容为" + message.getContent() + "  \n参数为：" + message.getExtrasMap().toString(), Toast.LENGTH_SHORT).show();

            }

            @Override
            public void onNotifyMessageOpenedReceive(Context context, MobPushNotifyMessage message) {
//接收通知消息被点击事件
                Toast.makeText(context, "接收通知消息被点击事件:" + message.getTitle() + " " + message.getContent(), Toast.LENGTH_SHORT).show();

            }

            @Override
            public void onTagsCallback(Context context, String[] tags, int operation, int errorCode) {
//接收tags的增改删查操作
            }

            @Override
            public void onAliasCallback(Context context, String alias, int operation, int errorCode) {
//接收alias的增改删查操作
            }
        });
        getPushPar(getIntent());

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("getPlatformVersion")) {
                            result.success("Android " + android.os.Build.VERSION.RELEASE);
                        } else if (call.method.equals("startLink")) {
                            mApLinker = ApLinker.getInstance(getContext());
                            mApLinker.init();
                            mApLinker.setSsid(call.argument("wifi"));
                            mApLinker.setPassword(call.argument("password"));
                            mApLinker.setOnLinkListener(new OnLinkListener() {
                                @Override
                                public void onWifiConnectivityChangedBeforeLink(boolean connected, String ssid, WifiInfo wifiInfo) {

                                }

                                @Override
                                public void onLinked(LinkedModule module) {
                                    Log.i(TAG, "onLinked: " + module);
                                    result.success(module.getMac());


                                }

                                @Override
                                public void onFinished() {
                                    Log.i(TAG, "onFinished" );
                                    mApLinker.stop();

                                }

                                @Override
                                public void onTimeOut() {
                                    result.success("204");

                                }

                                @Override
                                public void onError(LinkingError error) {
                                    Log.i(TAG, "onError: " + error);
                                    result.success("404"+error);

                                }

                                @Override
                                public void onProgress(LinkingProgress progress) {
                                    Log.i(TAG, "onProgress: " + progress);

                                }
                            });
                            //mApLinker.setSsid("HUAWEI-Q2Q93C");
                            //mApLinker.setPassword("52513583");
                            mApLinker.setApSsid("hiflying_softap");
                            mApLinker.setApPassword("12345678");
                            //mApLinker.setApSsid("cat");
                            //mApLinker.setApPassword("12345678");
                            try {
                                mApLinker.start();
                            } catch (Exception e) {
                                System.out.println("failed");
                                e.printStackTrace();
                            }
                        }else if (call.method.equals("stopLink")){
                            try {
                                mApLinker.stop();
                                result.success("");
                            } catch (Exception e) {
                                System.out.println("stop");
                                e.printStackTrace();
                            }
                        }
                    }

                });

    }
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        getPushPar(intent);
    }

    private void getPushPar(Intent intent) {
        JSONArray jsonbj = MobPushUtils.parseMainPluginPushIntent(intent);
        if (jsonbj != null) {
            System.out.println("-------------jsonpushdata打印查看：" + jsonbj);
            Toast.makeText(this, "-------------jsonpushdata打印查看：" + jsonbj, Toast.LENGTH_SHORT).show();

        }
    }
    @NeedsPermission({"android.permission.ACCESS_WIFI_STATE", "android.permission.ACCESS_NETWORK_STATE", "android.permission.ACCESS_COARSE_LOCATION",
            "android.permission.ACCESS_FINE_LOCATION", "android.permission.CHANGE_WIFI_STATE", "android.permission.CHANGE_NETWORK_STATE",
            "android.permission.INTERNET", "android.permission.WAKE_LOCK"})
    public void requestPermissions() {
        Log.d(TAG, "requestPermissions: ");
    }

    @OnPermissionDenied({"android.permission.ACCESS_WIFI_STATE", "android.permission.ACCESS_NETWORK_STATE", "android.permission.ACCESS_COARSE_LOCATION",
            "android.permission.ACCESS_FINE_LOCATION", "android.permission.CHANGE_WIFI_STATE", "android.permission.CHANGE_NETWORK_STATE",
            "android.permission.INTERNET", "android.permission.WAKE_LOCK"})
    public void showPermissionDenied() {
    }


    @OnNeverAskAgain({"android.permission.ACCESS_WIFI_STATE", "android.permission.ACCESS_NETWORK_STATE", "android.permission.ACCESS_COARSE_LOCATION",
            "android.permission.ACCESS_FINE_LOCATION", "android.permission.CHANGE_WIFI_STATE", "android.permission.CHANGE_NETWORK_STATE",
            "android.permission.INTERNET", "android.permission.WAKE_LOCK"})
    public void onPermissionNeverAskAgain() {
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        MainActivityPermissionsDispatcher.onRequestPermissionsResult(this, requestCode, grantResults);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mApLinker.destroy();
    }
    @Override
    protected void onStart() {
        super.onStart();
        checkLocationProvider();
        MainActivityPermissionsDispatcher.requestPermissionsWithPermissionCheck(this);
    }
    private void checkLocationProvider() {

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){

            LocationManager locManager = (LocationManager)getSystemService(LOCATION_SERVICE);
            if (!locManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {

                Log.w(TAG, String.format("The android version sdk is %s and its location provider is disabled!", Build.VERSION.SDK_INT));
                Intent intent =  new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                startActivity(intent);

            }
        }
    }


}
