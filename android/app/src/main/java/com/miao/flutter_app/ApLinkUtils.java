package com.miao.flutter_app;

import android.content.Context;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.text.TextUtils;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.List;

public class ApLinkUtils {

    public static boolean isBlank(String ssid) {
        return TextUtils.isEmpty(ssid) || ssid.trim().isEmpty();
    }

    public static boolean isEmptySsid(String ssid) {

        if (isBlank(ssid)) {
            return true;
        }

        if (getPureSsid(ssid).toLowerCase().contains("<unknown ssid>")) {
            return true;
        }

        return false;
    }

    public static boolean isEmptyBssid(String bssid) {

        if (isBlank(bssid)) {
            return true;
        }

        bssid = bssid.trim();
        if (bssid.equals("000000000000") || bssid.equals("00-00-00-00-00-00") || bssid.equals("00:00:00:00:00:00")) {
            return true;
        }

        return false;
    }

    public static String getSsid(Context context, int networkId) {

        if (networkId != -1) {

            WifiManager wifiManager = (WifiManager)context.getSystemService(Context.WIFI_SERVICE);
            List<WifiConfiguration> wifiConfigurations = wifiManager.getConfiguredNetworks();
            if (wifiConfigurations == null) {
                return null;
            }

            for (WifiConfiguration wifiConfiguration: wifiConfigurations) {
                if (wifiConfiguration.networkId == networkId) {
                    return wifiConfiguration.SSID;
                }
            }
        }

        return null;
    }

    public static String getBssid(Context context, int networkId) {

        if (networkId != -1) {

            WifiManager wifiManager = (WifiManager)context.getSystemService(Context.WIFI_SERVICE);
            List<WifiConfiguration> wifiConfigurations = wifiManager.getConfiguredNetworks();
            if (wifiConfigurations != null) {
                return null;
            }

            for (WifiConfiguration wifiConfiguration: wifiConfigurations) {
                if (wifiConfiguration.networkId == networkId) {
                    return wifiConfiguration.BSSID;
                }
            }
        }

        return null;
    }

    public static String getPureSsid(String ssid) {

        if (isBlank(ssid)) {
            return ssid;
        }

        if (ssid.startsWith("\"")) {
            ssid = ssid.substring(1);
        }
        if (ssid.endsWith("\"")) {
            ssid = ssid.substring(0, ssid.length() - 1);
        }

        return ssid;
    }

    /**
     * Convert a IPv4 address from an integer to an InetAddress.
     * @param hostAddress an int corresponding to the IPv4 address in network byte order
     */
    public static InetAddress intToInetAddress(int hostAddress) {
        byte[] addressBytes = { (byte)(0xff & hostAddress),
                (byte)(0xff & (hostAddress >> 8)),
                (byte)(0xff & (hostAddress >> 16)),
                (byte)(0xff & (hostAddress >> 24)) };

        try {
            return InetAddress.getByAddress(addressBytes);
        } catch (UnknownHostException e) {
            throw new AssertionError();
        }
    }

    /**
     * Convert a IPv4 address from an InetAddress to an integer
     * @param inetAddr is an InetAddress corresponding to the IPv4 address
     * @return the IP address as an integer in network byte order
     */
    public static int inetAddressToInt(InetAddress inetAddr)
            throws IllegalArgumentException {
        byte [] addr = inetAddr.getAddress();
        return ((addr[3] & 0xff) << 24) | ((addr[2] & 0xff) << 16) |
                ((addr[1] & 0xff) << 8) | (addr[0] & 0xff);
    }

    public static String calculateIpAddress(int ipAddress) {
        return (ipAddress & 0xff) + "." + (ipAddress>>8 & 0xff) + "."
                + (ipAddress>>16 & 0xff) + "." + (ipAddress>>24 & 0xff);
    }

    public static String bytes2HexString(byte[] datas) {
        return bytes2HexStringWithSplit(datas, "");
    }

    public static String bytes2HexStringWithWhitespace(byte[] datas) {
        return bytes2HexStringWithSplit(datas, " ");
    }

    public static String bytes2Characters(byte[] datas) {

        StringBuffer sb = new StringBuffer();
        for (byte b : datas) {
            sb.append((char)b);
        }
        return sb.toString();
    }

    public static int byte2Int(byte data) {
        return data & 0xFF;
    }

    public static String bytes2HexStringWithSplit(byte[] datas, String splitString) {

        if (datas == null) {
            return null;
        }

        StringBuffer sb = new StringBuffer();
        String format = "%02X";

        for (int i = 0; i < datas.length; i++) {
            sb.append(String.format(format, datas[i] & 0xFF));
            if (i < datas.length - 1) {
                sb.append(splitString);
            }
        }

        return sb.toString();
    }

    public static NetworkInterface getNetworkInterface(String ip) {

        if (TextUtils.isEmpty(ip)) {
            return null;
        }

        try {

            Enumeration<NetworkInterface> enumeration = NetworkInterface.getNetworkInterfaces();
            if (enumeration == null) {
                return null;
            }

            while (enumeration.hasMoreElements()) {

                NetworkInterface networkInterface = enumeration.nextElement();
                Enumeration<InetAddress> inetAddresses = networkInterface.getInetAddresses();
                if(inetAddresses != null) {

                    while (inetAddresses.hasMoreElements()) {

                        if (ip.equalsIgnoreCase(inetAddresses.nextElement().getHostAddress())) {
                            return networkInterface;
                        }
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static String getPureMac(String mac) {

        if (mac == null) {
            return mac;
        }

        String[] toReplaces = new String[]{":", "-", "_", " "};
        for (String toReplace : toReplaces) {
            mac = mac.replaceAll(toReplace, "");
        }
        return mac.trim();
    }

    public static String calculateHFModuleMacByBSSID(String bssid) throws Exception {
        Long number = Long.valueOf(getPureMac(bssid), 16);
        number -= 1;
        return  String.format("%012X", number);
    }
}
