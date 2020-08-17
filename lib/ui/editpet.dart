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
import 'package:flutter_app/model/miaoBean.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditPet extends StatefulWidget {
  EditPet({this.petId});

  final petId;

  @override
  _EditPetState createState() => _EditPetState();
}

class _EditPetState extends State<EditPet> {
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
  miaoBean items;

  var petNameController = new TextEditingController();
  var petNickController = new TextEditingController();
  var petSexController = new TextEditingController();
  var petWeightController = new TextEditingController();
  var petBirthController = new TextEditingController();
  var petRFIDController = new TextEditingController();

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
      resizeToAvoidBottomPadding: false,
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
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
          backgroundColor: Colors.white,
          title: Text(
            "宠物资料",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(

            child: Stack(children: [
          Container(
              constraints:BoxConstraints(
                minHeight: ScreenUtil().setHeight(306.66),
              ),

              width: ScreenUtil().setWidth(190),
              height: ScreenUtil().setHeight(306.66),
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(30),
                  right: ScreenUtil().setWidth(30),
                  top: ScreenUtil().setHeight(37.33),
                  bottom: ScreenUtil().setHeight(25.33)),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF525152),
                    width: 3.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(30.66),
                  bottom: ScreenUtil().setHeight(17),
                  left: ScreenUtil().setWidth(19.33),
                  // right: ScreenUtil().setWidth(10.33)
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text("名字",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Colors.black26,
                                fontWeight: FontWeight.w700),
                            controller: petNameController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("品种",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Colors.black26,
                                fontWeight: FontWeight.w700),
                            controller: petNickController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("性别",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(78.66),
                        ),
                        SizedBox(
                            width: ScreenUtil().setWidth(48.66),
                            child: Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.center,
//                          child: Text(_sexy == 0 ? "男" : "女",
//                              style: TextStyle(color: Color(0xFF888888))))
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: petSexController.text,
                                        //value:_sexy==0?"男":"女",
                                        items: [
                                          DropdownMenuItem(
                                            child: Text('男孩',
                                                style: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize:
                                                      ScreenUtil().setSp(10),
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            value: "0",
                                          ),
                                          DropdownMenuItem(
                                              child: Text('女孩',
                                                  style: TextStyle(
                                                    color: Colors.black26,
                                                    fontSize:
                                                        ScreenUtil().setSp(10),
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              value: "1"),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _sexy = value;
                                          });
                                        }))))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("重量",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Colors.black26,
                                fontWeight: FontWeight.w700),
                            controller: petWeightController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("生日",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Colors.black26,
                                fontWeight: FontWeight.w700),
                            controller: petBirthController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("RFID",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          width: ScreenUtil().setWidth(70.66),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                color: Colors.black26,
                                fontWeight: FontWeight.w700),
                            controller: petRFIDController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 16.0)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(20),
                          bottom: ScreenUtil().setHeight(10)),
                      height: 1,
                      color: Colors.grey.shade200,
                    ),
                    Row(
                      children: [
                        Text("照片(最多三张)",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(8),
                              bottom: ScreenUtil().setHeight(8),
                              right: ScreenUtil().setHeight(0)),
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/pic_add_pet.png",
                              width: ScreenUtil().setWidth(35.66),
                              height: ScreenUtil().setHeight(34.66),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(ScreenUtil().setHeight(8)),
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/pic_add_pet.png",
                              width: ScreenUtil().setWidth(35.66),
                              height: ScreenUtil().setHeight(34.66),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(8),
                              bottom: ScreenUtil().setHeight(8),
                              right: ScreenUtil().setHeight(0)),
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              "assets/pic_add_pet.png",
                              width: ScreenUtil().setWidth(35.66),
                              height: ScreenUtil().setHeight(34.66),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          Positioned(
              top: ScreenUtil().setHeight(13),
              // left:ScreenUtil().setWidth(128),
              right: ScreenUtil().setWidth(10),
              child: GestureDetector(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(63),
                    child: CachedNetworkImage(
                      imageUrl: items.data[widget.petId].imgUrl,
                      width: ScreenUtil().setWidth(63),
                      height: ScreenUtil().setWidth(63),
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.fill,
                    )),
              )),
        ])));
  }

  initData() async {
    items = await miaoBean.fromJson({
      "code": 0,
      "count": 3,
      "data": [
        {
          "id": 1,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098914&di=9f046b001b45d25e2db21fb4e3b80c35&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F521%2Fw1056h1065%2F20181211%2Feb2b-hqackaa2812377.jpg",
          "name": "zaizai",
          "nickName": "美短猫",
          "birth": "10.1",
          "weight": "20",
          "sexy": 0,
          "rfid": "11123",
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098914&di=9f046b001b45d25e2db21fb4e3b80c35&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F521%2Fw1056h1065%2F20181211%2Feb2b-hqackaa2812377.jpg"
          ]
        },
        {
          "id": 2,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg",
          "name": "GiGi",
          "nickName": "小喵喵",
          "birth": "10.1",
          "weight": "20",
          "sexy": 0,
          "rfid": "12343",
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg"
          ]
        },
        {
          "id": 3,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0",
          "name": "Pitgi",
          "nickName": "鼻涕狗",
          "birth": "10.1",
          "weight": "20",
          "sexy": 1,
          "rfid": "1233",
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0"
          ]
        }
      ],
      "msg": "请求成功"
    });
    setState(() {
      petNameController.text = items.data[widget.petId].name;
      petNickController.text = items.data[widget.petId].nickName;
      petSexController.text = items.data[widget.petId].sexy.toString();
      petWeightController.text = items.data[widget.petId].weight;
      petBirthController.text = items.data[widget.petId].birth;
      petRFIDController.text = items.data[widget.petId].rfid;
    });
    return items;
  }

  _showPicPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
            height: ScreenUtil().setHeight(80),
            width: MediaQuery.of(context).size.width,
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
        "file": await MultipartFile.fromFile(newImage.path, filename: "aa.jpg"),
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
              Navigator.pop(context, true);
            },
            onConfirmEvent: () async {
              Navigator.pop(context, true);
            },
          );
        });
  }
}
