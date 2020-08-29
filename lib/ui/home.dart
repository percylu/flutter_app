import 'dart:convert';

import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/messagelist.dart';

import 'package:flutter_app/ui/tab/mhometab.dart';
import 'package:flutter_app/ui/tab/mlogintab.dart';
import 'package:flutter_app/ui/tab/mmiaotab.dart';
import 'package:flutter_app/ui/tab/mminetab.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/SpUtils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobpush_plugin/mobpush_custom_message.dart';
import 'package:mobpush_plugin/mobpush_notify_message.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'dart:io';
class HomePage extends StatefulWidget {
  HomePage({this.index});
  final int index;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  static int _pageIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];
  bool islogin = true;

  //适配刘海屏顶部安全区域，@https://coding.imooc.com/learn/list/321.html
  double paddingTop = 0;
  TextEditingController _inputController = TextEditingController();


  @override
  void initState() {
    super.initState();
    initMob();
    _pageIndex=widget.index;
    initData();
    _statusBar();
    ScreenUtil.init(width: 750,
        height: 1334,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    _children.add(MiaoHomeTabView());
    _children.add(MiaoMain());
    _children.add(MiaoMine());
    _appBars.add(null);
    _appBars.add(null);
   // _appBars.add(null);

    _appBars.add(null);
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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: islogin ? _appBars[_pageIndex] : _buildAppBarLogin(),
        body:islogin?
        IndexedStack(index:_pageIndex,
        children: _children,
        ):MiaoLogin(),
        //appBar: _appBars[_pageIndex],
        //body: _children[_pageIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _pageIndex = 1;
              print(_pageIndex);
            });
          },
          child:
          Image.asset(
            "assets/ic_logo_black.png", width: ScreenUtil().setWidth(113),
            height: ScreenUtil().setWidth(103),),
          elevation: 0.0,
          backgroundColor: Color.fromARGB(0, 0xff, 0xff, 0xff),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }


  Widget _buildAppBarLogin() {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        icon: Image.asset("assets/ic_back.png", width: 12, height: 20,),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "home");
        },
      ),

    );
  }


  Widget _buildAppBarOne(String title) {
    return AppBar(
      elevation: 0.5,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.black)),
    );
  }
  Widget _buildAppBarTwo() {
    return AppBar(
      elevation: 0,
      toolbarOpacity:1,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        elevation: 6,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_home_default.png', width: 25, height: 25,),
              activeIcon: Image.asset(
                "assets/ic_home_pressed@3x.png", width: 25, height: 25,),
              title: new Container()),
          BottomNavigationBarItem(
              icon: new Container(),
              title: new Container()),

          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/ic_me_default.png', width: 25, height: 27,),
              activeIcon: Image.asset(
                "assets/ic_me.png", width: 25, height: 25,),
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
        });
  }

  void initData() async{
    print("------------login-------------");
    var res= await SpUtils.get(Config.TOKEN_KEY);

      print(res);
      setState(() {
        if(res==null){
          islogin=false;
        }else{
          islogin=true;
        }
      });


  }

  void initMob() {
    MobpushPlugin.updatePrivacyPermissionStatus(true);
    MobpushPlugin.setClickNotificationToLaunchMainActivity(true);
    MobpushPlugin.setAppForegroundHiddenNotification(true);
    if (Platform.isIOS) {
      MobpushPlugin.setCustomNotification();
      MobpushPlugin.setAPNsForProduction(false);
    }else{
      MobpushPlugin.setClickNotificationToLaunchMainActivity(false);
    }

    MobpushPlugin.addPushReceiver(_onEvent, _onError);

    // WidgetsBinding.instance.addPostFrameCallback((time) {
    //   // print("----addPostFrameCallback--route=${widget?.route}");
    //   // switch (widget?.route ?? "") {
    //   //   case "msg":
    //     //link://com.mob.mobpush.demo2
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (_) => MessageList()));
    //     //   break;
    //     // default:
    //   // }
    // });
  }

  _onEvent(Object event) {
    print(">>>>>>>>>>>onEvent:${event.toString()}");
    setState(() {
      Map<String, dynamic> eventMap = json.decode(event);
      Map<String, dynamic> result = eventMap['result'];
      int action = eventMap['action'];
      print(eventMap['action']);
      switch (action) {
        case 0:
          MobPushCustomMessage message =
          new MobPushCustomMessage.fromJson(result);
          showDialog(
              context: context,
              child: AlertDialog(
                content: Text(message.content),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("确定"),
                  )
                ],
              ));
          break;
        case 1:
          MobPushNotifyMessage message =
          new MobPushNotifyMessage.fromJson(result);
          break;
        case 2:
          MobPushNotifyMessage message =
          new MobPushNotifyMessage.fromJson(result);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MessageList()));
          break;
      }
    });
  }

  _onError(Object event) {
    print(">>>>>>>>>>onError:${event.toString()}");
  }



}
