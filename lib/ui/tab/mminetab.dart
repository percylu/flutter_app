import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/res/assets.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/picandtextbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiaoMine extends StatefulWidget {
  @override
  MiaoMineTabView createState() => MiaoMineTabView();
}

class MiaoMineTabView extends State<MiaoMine> {
  var _name = "";
  var _avatar = "";

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
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(11.33),
          left: ScreenUtil().setWidth(6.67),
          right: ScreenUtil().setWidth(6.67)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(8.67),
                bottom: ScreenUtil().setHeight(8.67)),
            child:
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${_name}  >",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        width: ScreenUtil().setWidth(67.33),
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          height: ScreenUtil().setWidth(49.33),
                          width: ScreenUtil().setHeight(49.33),
                          imageUrl: "${_avatar}",
                          placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  onTap:(){
                    Navigator.pushNamedAndRemoveUntil(context, "editmine", (route) => false);
                  }
                ),

          ),
          GestureDetector(
              child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(7)),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(12.67),
                bottom: ScreenUtil().setHeight(12.67)),
            alignment: Alignment.center,
            child: Text("消息通知",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF666666))),
          ),
            onTap: (){

            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7)),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.67),
                  bottom: ScreenUtil().setHeight(12.67)),
              alignment: Alignment.center,
              child: Text("通用设置",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){
              Navigator.pushNamed(context, "commonsetting");
            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7)),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.67),
                  bottom: ScreenUtil().setHeight(12.67)),
              alignment: Alignment.center,
              child: Text("关于我们",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){

            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7)),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.67),
                  bottom: ScreenUtil().setHeight(12.67)),
              alignment: Alignment.center,
              child: Text("帮助中心",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){

            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7)),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.67),
                  bottom: ScreenUtil().setHeight(12.67)),
              alignment: Alignment.center,
              child: Text("检查更新",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){

            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(7)),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.67),
                  bottom: ScreenUtil().setHeight(12.67)),
              alignment: Alignment.center,
              child: Text("退出登录",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF28282))),
            ),
            onTap: (){
              _showQuit();
            },
          ),


        ],
      ),
    );
  }
  _showQuit(){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new     MessageDialog(
            title:"正在退出登录?", message:"退出后无法使用完整功能", negativeText:"立即退出",
            onCloseEvent: (){
              Navigator.pop(context);
            },
            onConfirmEvent: (){
              Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);

            },
          );

        });
  }
  void initData() {
    setState(() {
      _name = "罗西";
      _avatar =
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1027245443,3552957153&fm=26&gp=0.jpg";
    });
  }
}
