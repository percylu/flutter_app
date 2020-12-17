import 'dart:convert';

import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/messagelist.dart';
import 'package:flutter_app/ui/tab/mcommunitytab.dart';

import 'package:flutter_app/ui/tab/mhometab.dart';
import 'package:flutter_app/ui/tab/mlogintab.dart';
import 'package:flutter_app/ui/tab/mmiaotab.dart';
import 'package:flutter_app/ui/tab/mminetab.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:io';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'draws.dart';

class HomePage extends StatefulWidget {
  HomePage({this.index});

  final int index;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginEntity user;
  static int _pageIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];
  bool islogin = true;
  String _sdkVersion = 'Unknown';
  String _registrationId = 'Unknown';

  //适配刘海屏顶部安全区域，@https://coding.imooc.com/learn/list/321.html
  double paddingTop = 0;
  TextEditingController _inputController = TextEditingController();

  JPush jpush = new JPush();

  @override
  void initState() {
    print("222");
    super.initState();
    _pageIndex = widget.index;
    initData();
    jpush.setup(
      appKey: '979597f2608ac5ec9047909b', channel: 'developer-default',
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );
    jpush.getRegistrationID().then((rid) async {
      print("+++++++++++++++++++++" + rid);
      ResultData response =
          await MiaoApi.checkThird(user.data.user.userId, rid, null);
      if (response.code == 1502) {
        islogin = false;
        setState(() {});
      }
    });
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));
    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        if (islogin) {
          jpush.clearAllNotifications();
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new MessageList();
          }));
        }
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );
    // _statusBar();
    _children.add(MiaoHomeTabView());
    _children.add(CommunityMain());
    _children.add(MiaoMain());
    _children.add(MiaoMine());
    _appBars.add(null);
    _appBars.add(null);
    _appBars.add(null);
    _appBars.add(null);
  }

  // ///状态栏样式-沉浸式状态栏
  // _statusBar() {
  //   //黑色沉浸式状态栏，基于SystemUiOverlayStyle.dark修改了statusBarColor
  //   SystemUiOverlayStyle uiOverlayStyle = SystemUiOverlayStyle(
  //     systemNavigationBarColor: Color(0xFF000000),
  //     systemNavigationBarDividerColor: null,
  //     statusBarColor: Colors.transparent,
  //     systemNavigationBarIconBrightness: Brightness.light,
  //     statusBarIconBrightness: Brightness.dark,
  //     statusBarBrightness: Brightness.light,
  //   );
  //
  //   SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);

    return Theme(
        data: Theme.of(context).copyWith(
            //设置背景色`BottomNavigationBar`
            canvasColor: Colors.white,
            //设置高亮文字颜色
            primaryColor: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: islogin ? _appBars[_pageIndex] : _buildAppBarLogin(),
          body: islogin
              ? IndexedStack(
                  index: _pageIndex,
                  children: _children,
                )
              : MiaoLogin(),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ));
  }

  Widget _buildAppBarLogin() {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        icon: Image.asset(
          "assets/ic_back.png",
          width: 12,
          height: 20,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "home");
        },
      ),
    );
  }

  Theme _buildBottomNavigationBar() {
    return Theme(
        data: Theme.of(context).copyWith(
            //设置背景色`BottomNavigationBar`
            canvasColor: Colors.white,
            //设置高亮文字颜色
            primaryColor: Colors.black12),
        //设置一般文字颜色
        child: new BottomNavigationBar(
            backgroundColor: Colors.white,
            // elevation: 6,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_home.png',
                    width: 25,
                    height: 25,
                  ),
                  // activeIcon: Image.asset(
                  //   "assets/ic_home_pressed@3x.png", width: 25, height: 25,),
                  title: new Container()),
              // BottomNavigationBarItem(
              //     icon: new Container(),
              //     title: new Container()),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_community.png',
                    width: 25,
                    height: 25,
                  ),
                  // activeIcon: Image.asset(
                  //   "assets/ic_home_pressed@3x.png", width: 25, height: 25,),
                  title: new Container()),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_pet.png',
                    width: 25,
                    height: 25,
                  ),
/*              activeIcon: Image.asset(
                "assets/ic_me.png",
                width: 25,
                height: 25,
              ),*/
                  title: new Container()),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_me.png',
                    width: 25,
                    height: 25,
                  ),
/*              activeIcon: Image.asset(
                "assets/ic_me.png",
                width: 25,
                height: 25,
              ),*/
                  title: new Container()),
            ],
            currentIndex: _pageIndex,
            onTap: (int index) async {
              var token = await SpUtils.get(Config.TOKEN_KEY);
              setState(() {
                _pageIndex = index;
                if (token == null) {
                  islogin = false;
                } else {
                  islogin = true;
                }
              });
            }));
  }

  void initData() async {
    var res = await SpUtils.get(Config.TOKEN_KEY);
    setState(() {
      if (res == null) {
        islogin = false;
        return;
      } else {
        islogin = true;
      }
    });
    var data = await SpUtils.getObjact(Config.USER);
    user = JsonConvert.fromJsonAsT(data);
  }
}
