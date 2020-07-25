import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Comming extends StatelessWidget {
  var img = "assets/CAT.png";

  ///状态栏样式-沉浸式状态栏

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img,
                width: ScreenUtil().setWidth(270),
                height: ScreenUtil().setHeight(270)),
            SizedBox(height: ScreenUtil().setHeight(20)),
            Text(
              "敬请期待~",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF666666)),
            )
          ],
        ));
  }
}
