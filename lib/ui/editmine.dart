
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/camera.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
              Navigator.pushNamedAndRemoveUntil(
                  context, "home", (route) => false);
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home", (route) => false);
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
                child: GestureDetector(
                    onTap:() {
                        //Navigator.pushNamed(context, "camera");
                      _showPicPicker(context);
                      },
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
                )),
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
                  child: Row(
                    children: [
                      Text("用户名",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(80),
                      ),
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
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0)),
                        ),
                      ),
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("性别>",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(100),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(_sexy == 0 ? "男" : "女",
                              style: TextStyle(color: Color(0xFF888888))))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("手机号>",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(90),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text("${_mobile}",
                              style: TextStyle(color: Color(0xFF888888))))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("修改手机号",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(80),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            ">",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: Color(0xFF888888)),
                          ))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("修改密码",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(90),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            ">",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                color: Color(0xFF888888)),
                          ))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("QQ",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(115),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "未绑定",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xFF888888)),
                          ))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("微信",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(110),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "未绑定",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xFF888888)),
                          ))
                    ],
                  )),
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
                  child: Row(
                    children: [
                      Text("微博",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF666666))),
                      SizedBox(
                        width: ScreenUtil().setWidth(110),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(
                            "未绑定",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Color(0xFF888888)),
                          ))
                    ],
                  )),
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

  void initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    setState(() {
      _name = user.data.user.name;
      _avatar = SpUtils.URL + user.data.user.avatar;
      _sexy = user.data.user.sex;
      _mobile = user.data.user.account;
      user.data.user.qq == "" ? _isQQ = false : _isQQ = true;
      user.data.user.weibo == "" ? _isWeixin = false : _isWeixin = true;
      user.data.user.weixin == "" ? _isWeibo = false : _isWeibo = true;
    });
  }

  _showPicPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top:ScreenUtil().setHeight(20)),
            height: ScreenUtil().setHeight(80),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: GestureDetector(
                    child:Text("拍照",style:TextStyle(fontSize: ScreenUtil().setSp(12),fontWeight: FontWeight.w500)),
                    onTap:(){
                      _takePhotos();
                      Navigator.pop(context);

                    }
                )),

              //  SizedBox(height:ScreenUtil().setHeight(15) ,),
                Expanded(child: GestureDetector(
                    child:Text("相册",style:TextStyle(fontSize: ScreenUtil().setSp(12),fontWeight: FontWeight.w500)),
                    onTap:(){
                      _getPhotos();
                      Navigator.pop(context);


                    }
                ),
                ),
              ],
            ),
          );
        });
  }

  _takePhotos() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _uploadImage(image);
  }

  //获取相册照片
  _getPhotos() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery);
    _uploadImage(image);
  }

  Future<Map<String, dynamic>> _uploadImage(File _imageDir) async {
    var fileDir = _imageDir.path;
    print(fileDir);
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_imageDir.path, filename: "aa.jpg"),
    });
    Dio dio = new Dio();
    var response = await dio.post(
        "http://192.168.9.234:8020/fileUpload",
        data: formData);
    print(response);
    setState(() {
      var path = "http://192.168.10.14:8888/" + response.data["data"]["path"];
      _avatar = path;
    });
    return response.data;
  }


}
