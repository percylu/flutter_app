import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:wifi/wifi.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class DeviceWifi extends StatefulWidget {
  @override
  _DeviceWifiState createState() => _DeviceWifiState();
}

class _DeviceWifiState extends State<DeviceWifi> {
  var wifiController = new TextEditingController();
  var passwordController = new TextEditingController();
  var connectivityResult;
  var _isObscure = true;
  var _searchText = " Wi-Fi连接";
  var _fixText = "正在搜索附近设备";
  var _isConnect = false;
  var obj;
  var _deviceMac = "";
  var _seconds = 0;
  LoginEntity user;
  Timer _timer;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "WiFi连接",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () async {
            // obj = await HanfengSmartlink.stopLink;
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 70,
              ),
              Image.asset(
                "assets/login_img_micromew_wifi.png",
                scale: 1.8,
              ),
              Container(
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.only(left: 70, right: 90, top: 20),
                      elevation: 2,
                      shape: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: TextField(
                        controller: wifiController,
                        decoration: InputDecoration(
                            hintText: "输入WiFi名称",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0)),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 70, right: 90, top: 20),
                      elevation: 2,
                      shape: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            hintText: "输入 WiFi密码",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          left: 70.0, right: 90, top: 30.0, bottom: 10.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        color: new Color(0xFFF28282),
                        onPressed: () {
                          //_showWifiFailed();
                          initPlatformState();
                          //Navigator.pushNamed(context, "deviceerror");
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Text("${_searchText}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text("配网流程",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                        Text("输入账号及密码->wifi连接->等待配置完成",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void initPlatformState() async {
    print(wifiController.text);
    if (wifiController.text == "" || passwordController.text == "") {
      _showWifiError("WiFi连接失败?", "请填写WI-FI名称和密码");
      return;
    }
    _startTimer();
    //  obj = await HanfengSmartlink.startLink(wifiController.text, passwordController.text);
    var obj = configWifi(wifiController.text, passwordController.text);
    obj.whenComplete(() {
      print("++++++++++++++++++++value++++++++++++++++++++");
      //print(value);
    });
  }

  initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    user = JsonConvert.fromJsonAsT(data);
    //wifiController.text = await Wifi.ssid;
    //wifiController.text = await Connectivity().getWifiName();
    try {
      if (Platform.isIOS) {
        LocationAuthorizationStatus status =
            await _connectivity.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _connectivity.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiController.text = await _connectivity.getWifiName();
        } else {
          wifiController.text = await _connectivity.getWifiName();
        }
      } else {
        wifiController.text = await _connectivity.getWifiName();
      }
    } on PlatformException catch (e) {
      print(e.toString());
      wifiController.text = "Failed to get Wifi Name";
    }
    print("++++++++++++" + wifiController.text + "++++++++++++++");
    setState(() {});
  }

  Future<bool> configWifi(String wifi, String password) async {
    Future con = Wifi.connection("cat", "12345678");

    await con.then((res) {
      Future.delayed(new Duration(seconds: 10)).then((_) async {
        if (res == WifiState.success) {
          //Future BSSID =   _connectivity.getWifiBSSID();
          var BSSID = null;
          try {
            if (Platform.isIOS) {
              LocationAuthorizationStatus status =
                  await _connectivity.getLocationServiceAuthorization();
              if (status == LocationAuthorizationStatus.notDetermined) {
                status =
                    await _connectivity.requestLocationServiceAuthorization();
              }
              if (status == LocationAuthorizationStatus.authorizedAlways ||
                  status == LocationAuthorizationStatus.authorizedWhenInUse) {
                BSSID = _connectivity.getWifiBSSID();
              } else {
                BSSID = _connectivity.getWifiBSSID();
              }
            } else {
              BSSID = _connectivity.getWifiBSSID();
            }
          } on PlatformException catch (e) {
            print(e.toString());
            BSSID = "Failed to get Wifi BSSID";
          }

          var wifiBSSID = "";
          BSSID.then((value) async {
            wifiBSSID = value.replaceAll(":", "");
            print("++++++++++++++++++wifiBSSID++++++++++++++");
            print(wifiBSSID);

            Future getIP = _connectivity.getWifiIP();
            getIP.then((ipAddress) {
              print("getIP");
              print(ipAddress);
              var rawDgramSocket = RawDatagramSocket.bind(
                  ipAddress==null?InternetAddress.loopbackIPv4:InternetAddress.tryParse(ipAddress), 65535);


              rawDgramSocket.then((socket) {
                socket.send(
                    new Utf8Codec().encode(
                        '{"port":65535,"password":"${password}","ssid":"${wifi}"}'),
                    InternetAddress.tryParse("192.168.4.1"),
                    1000);
                socket.listen((event) {
                  if (event == RawSocketEvent.read) {
                    var recieve = socket.receive().data;
                    var str = new Utf8Codec().decode(recieve);
                    print(str);
                    if (str.substring(str.length - 2) == "2}") {
                      _deviceMac = wifiBSSID;
                      _cancleTimer();
                      //处理配网成功；
                      print("_deviceMAc+++++++++++++++" + _deviceMac);
                      if (_deviceMac != "") {
                        Future org;
                        if (Platform.isIOS) {
                          org = Wifi.connection(wifi, password);
                        } else {
                          //org = Wifi.reconnection(wifi);
                          org = Wifi.connection(wifi, password);

                        }

                        // Future org= WifiConnector.connectToWifi(ssid: wifi, password: password);

                        print(wifi);
                        org.then((value) {
                          print("reconnect++++++++++++++");
                          print(value);
                          if (value == WifiState.success) {
                            Future.delayed(const Duration(milliseconds: 2000),
                                () async {
                              print("delay......");
                              ResultData response = await MiaoApi.deviceAdd(
                                  user.data.user.userId, _deviceMac);
                              print(response.code);
                              if (response.code == 200) {
                                _showWifi("WiFi连接成功!", _deviceMac);
                              }
                            });
                            return true;
                          }
                        });
                      }
                    } else if (str.substring(str.length - 2) == "3}") {
                      setState(() {
                        _seconds = 90;
                        _searchText = "Wi-Fi连接";
                      });
                      _cancleTimer();
                      _showWifiError("WiFi连接失败?", "连接失败");

                      return false;
                    } else {
                      setState(() {
                        _seconds = 90;
                        _searchText = "Wi-Fi连接";
                      });
                      _cancleTimer();
                      _showWifiError("WiFi连接失败?", "连接失败");

                      return false;
                    }
                  }
                });
              });
            });
          });
        } else {
          print("can not get ip");
          return false;
        }
      });
    });
  }

  /// 倒计时
  _startTimer() {
    _seconds = 90;
    _searchText = _fixText;
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _searchText = "Wi-Fi连接";
        setState(() {});
        _cancleTimer();
        return;
      }
      _seconds--;
      if (_seconds % 4 == 0) {
        _searchText = _fixText;
      } else {
        _searchText = _searchText + ".";
      }
      setState(() {});
    });
  }

  _cancleTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /// 页面销毁的时候,清除timer
    _cancleTimer();
    super.dispose();
  }

  _showWifi(title, msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "WiFi连接成功",
            message: msg,
            negativeText: "确定",
            onCloseEvent: () {
              Navigator.popAndPushNamed(context, "devicelist");
            },
            onConfirmEvent: () {
              Navigator.popAndPushNamed(context, "devicelist");
            },
          );
        });
  }

  _showWifiError(title, msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "WiFi连接失败",
            message: msg,
            negativeText: "重新连接",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
              initPlatformState();
            },
          );
        });
  }
}
