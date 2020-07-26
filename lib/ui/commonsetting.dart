import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/authmsgdialog.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CommonSetting extends StatefulWidget {
  @override
  CommonSettingState createState() => CommonSettingState();
}

class CommonSettingState extends State<CommonSetting> {
  var index = 0;
  var _isGetMsg = false;
  var _isStorage = false;
  var _isPhoto = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 250,
        height: 445,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Image.asset(
              "assets/ic_back.png",
              width: 12,
              height: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(11.33),
              left: ScreenUtil().setWidth(20.33),
              right: ScreenUtil().setWidth(20.33)),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(40),
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8.67),
                  bottom: ScreenUtil().setHeight(8.67),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("接受新消息提醒",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      width: ScreenUtil().setWidth(90),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45,width: 2),
                        borderRadius: BorderRadius.circular(20)
                      ),
                        child: FlutterSwitch(
                      width: ScreenUtil().setWidth(30.67),
                      height: ScreenUtil().setHeight(13.33),
                      //valueFontSize: 25.0,
                      //toggleSize: 45.0
                      activeColor: Color(0xFFD2B9B8),
                      inactiveColor: Colors.grey.shade400,
                      value: _isGetMsg,
                      borderRadius: ScreenUtil().setWidth(10),
                      padding: 2.0,

                      // showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          _isGetMsg = val;
                        });
                      },
                    ))
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(40),

                color: Colors.white,
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8.67),
                  bottom: ScreenUtil().setHeight(8.67),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("授权存储功能权限",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      width: ScreenUtil().setWidth(80),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45,width: 2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: FlutterSwitch(
                          width: ScreenUtil().setWidth(30.67),
                          height: ScreenUtil().setHeight(13.33),
                          //valueFontSize: 25.0,
                          //toggleSize: 45.0
                          activeColor: Color(0xFFD2B9B8),
                          inactiveColor: Colors.grey.shade400,
                          value: _isStorage,
                          borderRadius: ScreenUtil().setWidth(10),
                          padding: 2.0,

                          // showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              _isStorage = val;
                            });
                          },
                        ))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: ScreenUtil().setHeight(40),

                color: Colors.white,
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8.67),
                  bottom: ScreenUtil().setHeight(8.67),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("使用相机权限",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      width: ScreenUtil().setWidth(100),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45,width: 2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: FlutterSwitch(
                          width: ScreenUtil().setWidth(30.67),
                          height: ScreenUtil().setHeight(13.33),
                          //valueFontSize: 25.0,
                          //toggleSize: 45.0
                          activeColor: Color(0xFFD2B9B8),
                          inactiveColor: Colors.grey.shade400,
                          value: _isPhoto,
                          borderRadius: ScreenUtil().setWidth(10),
                          padding: 2.0,

                          // showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              _isPhoto = val;
                              print(_isPhoto);
                              if(_isPhoto) _onCameraSet();
                            });
                          },
                        ))
                  ],
                ),
              ),


            ],
          ),
        ));
  }

  _showQuit() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "正在退出登录?",
            message: "退出后无法使用完整功能",
            negativeText: "立即退出",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "home", (route) => false);
            },
          );
        });
  }
  _onCameraSet() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AuthMsgDialog(
            img:"assets/ic_camera.png", message:"是否允许 获取相机权限", negativeText:"允许获取",
            onCloseEvent: (){
              Navigator.pop(context);
            },
            onConfirmEvent: (){
              Navigator.pop(context);

            },
          );

        });

  }
  void initData() {}
}
