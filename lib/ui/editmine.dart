import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/changepassword.dart';
import 'package:flutter_app/ui/oldaccount.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditMine extends StatefulWidget {
  @override
  _EditMineState createState() => _EditMineState();
}

class _EditMineState extends State<EditMine> {
  var _userId = "";
  var _name = "";
  var _path = "";
  var _avatar = "";
  var _sexy = 0;
  var _mobile = "13823545677";
  var _pwd = "";
  var _isQQ = false;
  var _isWeixin = false;
  var _isWeibo = false;
  TextEditingController nameController = new TextEditingController();

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
              Navigator.pop(context, true);
            },
          ),
          actions: [
            FlatButton(
                child: Text(
                  "保存",
                  style: TextStyle(
                      color: Colors.black, fontSize: ScreenUtil().setSp(12)),
                ),
                onPressed: () async {
                  ResultData response = await MiaoApi.userUpdate(
                      _userId, _path, nameController.text, _sexy);
                  if (response.code == 200) {
                    update();
                    Navigator.pop(context, true);
                  } else {
                    showError(response.message);
                  }
                }),
          ],
          backgroundColor: Colors.white,
          title: Text(
            "个人信息",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: Container(
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
                    onTap: () {
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
                          child: Image.network(
                            "${_avatar}",
                            height: ScreenUtil().setWidth(49.33),
                            width: ScreenUtil().setWidth(49.33),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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
//                          child: Text(_sexy == 0 ? "男" : "女",
//                              style: TextStyle(color: Color(0xFF888888))))
                          child: DropdownButton(
                              value: _sexy,
                              //value:_sexy==0?"男":"女",
                              items: [
                                DropdownMenuItem(child: Text('男'), value: 0),
                                DropdownMenuItem(child: Text('女'), value: 1),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _sexy = value;
                                });
                              }))
                    ],
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child:
                      GestureDetector(child: Row(
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
                      ),
                      onTap: (){
                        Navigator.of(context).push(
                            new MaterialPageRoute(builder: (_) {
                              return new OldAccount(username: _mobile);
                            })
                        );
                      },
                      )
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
                  padding: EdgeInsets.only(
//                      top: ScreenUtil().setHeight(12.67),
//                      bottom: ScreenUtil().setHeight(12.67),
                    left: ScreenUtil().setWidth(36.67),
//                      right: ScreenUtil().setWidth(43.33)
                  ),
                  alignment: Alignment.center,
                  child: GestureDetector(
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
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            new MaterialPageRoute(builder: (_) {
                              return new ChangePassword(username: _mobile);
                            })
                        );
                      })),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: ScreenUtil().setHeight(33.33),
                  margin: EdgeInsets.only(
                      top: ScreenUtil().setHeight(7),
                      left: ScreenUtil().setWidth(8),
                      right: ScreenUtil().setWidth(8)),
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

  void initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    setState(() {
      nameController.text = user.data.user.name;
      _userId = user.data.user.userId;
      _name = user.data.user.name;
      _avatar = SpUtils.URL + user.data.user.avatar;
      _path = user.data.user.avatar;
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
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setHeight(80),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: GestureDetector(
                        child: Text("拍照",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          _takePhotos();
                          Navigator.pop(context, true);
                        })),

                //  SizedBox(height:ScreenUtil().setHeight(15) ,),
                Expanded(
                  child: GestureDetector(
                      child: Text("相册",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w500)),
                      onTap: () {
                        _getPhotos();
                        Navigator.pop(context, true);
                      }),
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
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImage(image);
  }

  Future<Map<String, dynamic>> _uploadImage(File _imageDir) async {
    setState(() {
      _avatar =
      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2467429933,3710707406&fm=26&gp=0.jpg";
    });
    var fileDir = _imageDir.parent.path;
    print("fileDir:-------" + fileDir);
    CompressObject compressObject = CompressObject(
      imageFile: _imageDir,
      path: fileDir,
      quality: 70,
      //first compress quality, default 80
      step: 20,
      //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      mode: CompressMode.LARGE2SMALL, //d
    );
    Luban.compressImage(compressObject).then((fileDir) async {
      // _path为压缩后图片路径
      File newImage = new File(fileDir);
      print("newImage:-----" + newImage.path);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
            newImage.path, filename: "aa.jpg"),
      });
      ResultData response = await MiaoApi.upload(formData);
      if (response.code == 200) {
        _path = '/image/' + response.data['data']['finalName'];
        setState(() {
          _avatar =
              SpUtils.URL + '/image/' + response.data['data']['finalName'];
        });
      }
    });
  }

  update() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    print("path----------" + _path);
    if (_path != "") {
      user.data.user.avatar = _path;
    }
    if (nameController.text != "") {
      user.data.user.name = nameController.text;
    }
    user.data.user.sex = _sexy;
    SpUtils.set(Config.USER, user);
  }

  showError(String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "更新用户信息错误",
            message: msg,
            negativeText: "返回",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () async {
              Navigator.pop(context);
            },
          );
        });
  }
}
