import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeviceError extends StatelessWidget {
  var img = "assets/img_error.png";

  ///状态栏样式-沉浸式状态栏

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
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
        ),
        body: Container(
          child: _banner(context),
        ));
  }

  Widget _banner(BuildContext context) {
    return Container(
      //设置背景图片
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ScreenUtil().setHeight(78.67)),
            Image.asset(img,
                width: ScreenUtil().setWidth(56.33),
                height: ScreenUtil().setHeight(63.67)),
            SizedBox(height: ScreenUtil().setHeight(13)),
            Text(
              "网络中断，请重新连接",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(10),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF666666)),
            ),
            SizedBox(height: ScreenUtil().setHeight(23)),
            Container(
              width: ScreenUtil().setWidth(146.67),
              height: ScreenUtil().setHeight(28.67),
              child:RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              color: new Color(0xFFF28282),
              onPressed: () {
                //_showWifiFailed();
                Navigator.pushNamed(context, "devicewifi");
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10.0))),
              child: Text("重新连接",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700)),
            ) ,),



          ],
        ));
  }
}
