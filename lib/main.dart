import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/comming.dart';
import 'package:flutter_app/ui/commonsetting.dart';
import 'package:flutter_app/ui/devicedata.dart';
import 'package:flutter_app/ui/devicedetail.dart';
import 'package:flutter_app/ui/deviceerror.dart';
import 'package:flutter_app/ui/devicelink.dart';
import 'package:flutter_app/ui/devicelist.dart';
import 'package:flutter_app/ui/devicescan.dart';
import 'package:flutter_app/ui/devicesleep.dart';
import 'package:flutter_app/ui/devicewifi.dart';
import 'package:flutter_app/ui/editmine.dart';
import 'package:flutter_app/ui/editpet.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/miaodetail.dart';
import 'package:flutter_app/ui/mobileregister.dart';
import 'package:flutter_app/ui/petlist.dart';
import 'package:flutter_app/ui/resetpassword.dart';
import 'package:flutter_app/ui/setpassword.dart';
import 'package:flutter_app/ui/startup.dart';

import 'package:flutter_app/ui/mobilelogin.dart';

import 'package:flutter_app/widget/camera.dart';


void main() {

  // 强制竖屏
  // 强制竖屏
    runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, //只能纵向
      DeviceOrientation.portraitDown,//只能纵向
    ]);
    _statusBar();
    return
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '喵小小',
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.red,
        accentColor: Colors.indigo,
      ),
      home: HomePage(index:0),
      routes: {
        "mobileLogin": (_) => MobileLogin(),
        "mobileRegister":(_) =>MobileRegister(),
        "setPassword":(_)=>SetPassword(),
        "home": (_) => HomePage(index:0),
        "resetPassword":(_) =>ResetPassword(),
        "startup":(_)=>Startup(),
        "devicelist":(_)=>DeviceList(),
        "devicescan":(_)=>DeviceScan(),
        "devicedetail":(_)=>DeviceDetail(),
        "devicesleep":(_)=>DeviceSleep(),
        "devicedata":(_)=>DeviceData(),
        "comming":(_)=>Comming(),
        "devicelink":(_)=>DeviceLink(),
        "devicewifi":(_)=>DeviceWifi(),
        "deviceerror":(_)=>DeviceError(),
        "editmine":(_)=>EditMine(),
        "commonsetting":(_)=>CommonSetting(),
        "miaodetail":(_)=>MiaoDetail(),
        "camera":(_)=>ImagePickerPage(),
        "petlist":(_)=>PetList(),
        "editpet":(_)=>EditPet(petId:"0"),
      },
    );
  }

  ///状态栏样式-沉浸式状态栏
  _statusBar() {
    //黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
    SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );

    SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);

  }
}

