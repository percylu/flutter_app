 package com.miao.flutter_app;;

import android.net.wifi.WifiInfo;

public interface OnLinkListener {

	public void onWifiConnectivityChangedBeforeLink(boolean connected, String ssid, WifiInfo wifiInfo);
	public void onLinked(LinkedModule module);

	/**
	 * always invoked when ap link task finished, no matter the task result
	 */
	public void onFinished();
	public void onTimeOut();
	public void onError(LinkingError error);
	public void onProgress(LinkingProgress progress);
}
