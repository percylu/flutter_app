/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/picandtextbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiaoLogin extends StatefulWidget {
  @override
  MiaoLoginTabView createState() => MiaoLoginTabView();
}

class MiaoLoginTabView extends State<MiaoLogin> {
  var check = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      overflow: Overflow.visible,
      children: [
        new Positioned(
          top: ScreenUtil().setHeight(339),
          child: Image.asset(
            "assets/bg_landing.png",
            width:ScreenUtil().setWidth(399.99),
            height:ScreenUtil().setHeight(572.01)
          ),
        ),
        new Positioned(
          top: ScreenUtil().setHeight(51.99),
          child: Image.asset(
            "assets/img_cat.png",
            width: ScreenUtil().setWidth(315.99),
            height: ScreenUtil().setHeight(338.01),
          ),
        ),
        new Positioned(
            top: ScreenUtil().setHeight(927.99),
           // left: ScreenUtil().setHeight(150),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Container(
                  child: new Checkbox(
                      value: this.check,
                      activeColor: Color(0xFFAC8C8C),
                      onChanged: (bool val) {
                        setState(() {
                          this.check = val;
                        });
                      }),
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new Text(
                    "同意",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new GestureDetector(
                    onTap: () {},
                    child: new Text(
                      "《许可协议》",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xFFAC8C8C)),
                    ),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new GestureDetector(
                    onTap: () {},
                    child: new Text(
                      "《隐私政策》",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xFFAC8C8C)),
                    ),
                  ),
                ),
              ],
            )),
        new Positioned(
            top: ScreenUtil().setHeight(408),
            child: picAndTextButton("assets/btn_sign.png", "手机号登陆", () {
              if (!check) {
                showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new MessageDialog(
                          title:"请先勾选同意", message:"《许可协议》《隐私政策》", negativeText:"返回同意",
                      onCloseEvent: (){
                            Navigator.pop(context);
                      });
                    });
                 return;
                }
                    Navigator.pushNamed(context, 'mobileLogin');
              })),
        new Positioned(
            top: ScreenUtil().setHeight(528),
            child: picAndTextButton("assets/btn_sign.png", "QQ登陆", () {})),
        new Positioned(
            top: ScreenUtil().setHeight(648),
            child: picAndTextButton("assets/btn_sign.png", "微信登陆", () {})),
        new Positioned(
            top: ScreenUtil().setHeight(768),
            child: picAndTextButton("assets/btn_sign.png", "微博登陆", () {})),
      ],
    );
  }
}
