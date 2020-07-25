import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/tab/mlogintab.dart';

import 'package:flutter_app/ui/tab/mhometab.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  List<Widget> _children = [];
  List<Widget> _appBars = [];

  //适配刘海屏顶部安全区域，@https://coding.imooc.com/learn/list/321.html
  double paddingTop = 0;
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _statusBar();
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true); //flutter_screenuitl >= 1.2
    _children.add(MiaoLogin());
    _children.add(MiaoHomeTabView());
    //_children.add(MiaoDiscoveryTabView());
    //_children.add(MiaoPetTabView());
    //_children.add(MiaoProfileTabView());
    _appBars.add(_buildAppBarLogin());
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
        backgroundColor: Colors.white,
        appBar: _appBars[_pageIndex],
        body: _children[_pageIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _pageIndex = 1;
              print(_pageIndex);
            });
          },
          child:
          Image.asset("assets/ic_logo_black.png",width:ScreenUtil().setWidth(113) ,height: ScreenUtil().setWidth(103),),
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
        icon:Image.asset("assets/ic_back.png",width: 12,height: 20,),
        onPressed: (){
          Navigator.pop(context);
        },
      ),

    );
  }

  Widget _buildAppBarOne(String title) {
    return AppBar(
      bottom: PreferredSize(
          child: Container(color: Colors.grey.shade200, height: 1.0,),
          preferredSize: Size.fromHeight(1.0)),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey.shade200,
      elevation: 0,
      title: Text(title, style: TextStyle(color: Colors.black)),
    );
  }


  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        elevation:1,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/ic_home_default.png', width:25,height:25,),
              activeIcon: Image.asset("assets/ic_home_pressed@3x.png",width: 25,height: 25,),
              title: new Container()),
          BottomNavigationBarItem(
              icon: new Container(),
              title: new Container()),

          BottomNavigationBarItem(
              icon: Image.asset('assets/ic_me_default.png',width: 25,height: 27,),
              activeIcon: Image.asset("assets/ic_me.png",width: 25,height: 25,),
              title: new Container()),
        ],
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
            print(_pageIndex);
          });
        });
        }
  }
