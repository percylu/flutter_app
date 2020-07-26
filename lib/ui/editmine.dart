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

class EditMine extends StatefulWidget {
  @override
  _EditMineState createState() => _EditMineState();
}

class _EditMineState extends State<EditMine> {
  var _name = "";
  var _avatar = "";
  var _sexy = 0;
  var _mobile = "13823545677";
  var _pwd = "";
  var _isQQ = false;
  var _isWeixin = false;
  var _isWeibo = false;
  TextEditingController nameController;
  TextEditingController sexyController;
  TextEditingController mobileController;

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
              Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
            },
          ),
          actions: [
            FlatButton(
                child: Text(
                  "保存",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(12)),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
                }),
          ],
          backgroundColor: Colors.white,
          title: Text(
            "个人信息",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(11.33),
              left: ScreenUtil().setWidth(6.67),
              right: ScreenUtil().setWidth(6.67)),
          child: ListView(
           // mainAxisAlignment: MainAxisAlignment.start,
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(8.67),
                  bottom: ScreenUtil().setHeight(8.67),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("头像更新>",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: Color(0xFF666666),
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
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                      left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    Text("用户名",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(80),),
                    Container(
                      width: ScreenUtil().setWidth(80),
                      height: ScreenUtil().setHeight(33.33),
                     alignment: Alignment.topRight,
                      child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "${_name}",
                          hintStyle: TextStyle(color: Color(0xFF888888)),
                          filled: true,
                          fillColor: Colors.white,
                          border:OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0)),
                    ),),

                  ],)
                ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text("性别>",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(100),),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_sexy==0?"男":"女",style:TextStyle(color: Color(0xFF888888)))
                      )
                  ],)
              ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text("手机号>",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(90),),
                    Container(
                        alignment: Alignment.center,
                        child: Text("${_mobile}",style: TextStyle(color: Color(0xFF888888)))
                    )
                  ],)
              ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child:
                  Row(children: [
                    Text("修改手机号",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(80),),
                    Container(
                        alignment: Alignment.center,
                        child: Text(">",style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Color(0xFF888888)),)
                    )
                  ],)
              ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child:
                  Row(children: [
                    Text("修改密码",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(90),),
                    Container(
                        alignment: Alignment.center,
                        child: Text(">",style: TextStyle(fontSize: ScreenUtil().setSp(12),color: Color(0xFF888888)),)
                    )
                  ],)
              ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text("QQ",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(115),),
                    Container(
                        alignment: Alignment.center,
                        child: Text("未绑定",style: TextStyle(fontSize: ScreenUtil().setSp(10),color: Color(0xFF888888)),)
                    )
                  ],)
              ),

              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text("微信",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(110),),
                    Container(
                        alignment: Alignment.center,
                        child: Text("未绑定",style: TextStyle(fontSize: ScreenUtil().setSp(10),color: Color(0xFF888888)),)
                    )
                  ],)
              ),
              Container(
                  color: Colors.white,
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(7)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Text("微博",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF666666))),
                    SizedBox(width: ScreenUtil().setWidth(110),),
                    Container(
                        alignment: Alignment.center,
                        child: Text("未绑定",style: TextStyle(fontSize: ScreenUtil().setSp(10),color: Color(0xFF888888)),)
                    )
                  ],)
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

  void initData() {
    setState(() {
      _name = "罗西";
      _avatar =
          "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1027245443,3552957153&fm=26&gp=0.jpg";
    });
  }
}
