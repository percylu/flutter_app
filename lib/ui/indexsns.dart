import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class IndexSns extends StatefulWidget {
  final firstPath;

  IndexSns({this.firstPath});

  @override
  _IndexSnsState createState() => _IndexSnsState();
}

class _IndexSnsState extends State<IndexSns> {
  var txtController = new TextEditingController();
  var _showLocation = false;
  List topicSel;
  var topic = [
    "猫猫狗狗",
    "快乐的小宠物",
    "你是一个傻猫",
    "快乐的小宠物",
    "猫猫狗狗",
    "快乐的小宠物",
    "你是一个傻猫",
    "猫猫狗狗",
    "快乐的小宠物",
    "你是一个傻猫"
  ];
  List<String> list = [];
  var position = 0;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () async {
            Navigator.pop(context);
            // Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
            //   return new EditSns();
            // }));
          },
        ),
        actions: [
          FlatButton(
              child: Text(
                "发布",
                style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: ScreenUtil().setSp(11.33)),
              ),
              onPressed: () {
                _showDialog(context);
              }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
        child: ListView(
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(60),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 7, //不限制行数
                controller: txtController,
                decoration: InputDecoration(
                  hintText: "这一刻的想法",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(7)),
              child: Text(
                "已添加图片 （" + (list.length).toString() + "/9)",
                style: TextStyle(color: Color(0xFF9A9A9A)),
              ),
            ),
            Container(
                margin: EdgeInsets.all(ScreenUtil().setWidth(7)),
                // height: ScreenUtil().setHeight(180),
                child: GridView.builder(

                  ///子Item排列规则
                  shrinkWrap: true,
                  itemCount: list.length == 9 ? 9 : list.length + 1,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                      crossAxisCount: 3,
                      //纵轴间距
                      mainAxisSpacing: 5.0,
                      //横轴间距
                      crossAxisSpacing: 5.0,
                      //子组件宽高长度比例
                      childAspectRatio: 1),

                  ///GridView中使用的子Widegt
                  itemBuilder: (BuildContext content, int position) {
                    print("list:" + list.length.toString());
                    if (position == list.length) {
                      return new GestureDetector(
                          onTap: () {
                            // getImage();
                            _showPicPicker(context);
                          },
                          child: Container(
                              color: Colors.black12,
                              child: Icon(
                                Icons.add,
                                size: ScreenUtil().setWidth(30),
                                color: Colors.grey,
                              )));
                    } else {
                      return new Container(
                          child: list.length > position
                              ? new Image.file(new File((list[position])),
                              fit: BoxFit.cover)
                              : new Container(
                            color: Colors.green,
                          ));
                    }
                  },
                )),
            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(7)),
              height: 1,
              color: Colors.grey.shade200,
            ),
            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(7)),
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: !_showLocation ? Colors.black : Colors.green),
                    Container(
                        margin:
                        EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                        child: Text(
                          "显示位置",
                          style: TextStyle(
                              color: !_showLocation
                                  ? Color(0xFF9A9A9A)
                                  : Colors.green,
                              fontWeight: FontWeight.w700),
                        ))
                  ],
                ),
                onTap: () {
                  _showLocation = !_showLocation;
                  setState(() {});
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(7),
                    top: ScreenUtil().setHeight(10)),
                child: Text("参与话题 >",
                    style: TextStyle(
                        color: Color(0xFF9A9A9A),
                        fontWeight: FontWeight.w700))),
            Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.all(ScreenUtil().setWidth(7)),
                child: ListView(
                  children: <Widget>[
                    Wrap(spacing: 8, runSpacing: 3, children: getTag())
                  ],
                ))
          ],
        ),
      ),
    );
  }

//发布成功弹窗
  _showDialog(BuildContext context) {
    showDialog(
      // 设置点击 dialog 外部不取消 dialog，默认能够取消
        barrierDismissible: false,
        context: context,
        builder: (context) =>
            SimpleDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "图层今天也是充满希望的一天",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Center(
                          child: Container(
                            color: Colors.grey,
                            height: ScreenUtil().setHeight(100),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Text("2020-10-15"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                    alignment: Alignment.center,
                    child: Text(
                      "发布成功，分享一下吧",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(10)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            "assets/qq.png",
                            width: ScreenUtil().setWidth(20.67),
                            height: ScreenUtil().setHeight(22.67),
                          ),
                          onTap: () {

                          },
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        GestureDetector(
                          onTap: () {

                          },
                          child: Image.asset("assets/weixinguanli.png",
                              width: ScreenUtil().setWidth(20.67),
                              height: ScreenUtil().setHeight(22.67)),),

                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        GestureDetector(
                            onTap: () {

                            },
                            child: Image.asset("assets/weibo.png",
                                width: ScreenUtil().setWidth(20.67),
                                height: ScreenUtil().setHeight(22.67)),)

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().setHeight(10)),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(builder: (context) => new HomePage(index:2)),
                              (route) => route == null,
                        );
                      },
                      child: Image.asset("assets/ic_cancel_share.png",
                          width: ScreenUtil().setWidth(27),
                          height: ScreenUtil().setHeight(27)),
                    ),
                  )
                ]));
  }

  _showPicPicker(BuildContext context) {
    showModalBottomSheet(
        elevation: 2.0,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext context) {
          return new Container(
            margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
            ),
            height: ScreenUtil().setHeight(100),
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: ScreenUtil().setHeight(30),
                    alignment: Alignment.center,
                    child: GestureDetector(
                        child: Text("拍摄照片",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        onTap: () {
                          _takePhotos();
                    //      Navigator.pop(context, true);
                        })),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey.shade300,
                ),
                //  SizedBox(height:ScreenUtil().setHeight(15) ,),
                Container(
                  height: ScreenUtil().setHeight(30),
                  alignment: Alignment.center,
                  child: GestureDetector(
                      child: Text("相册中选取照片",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700)),
                      onTap: () {
                        _getPhotos();
                      //  Navigator.pop(context, true);
                      }),
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey.shade300,
                ),
                Container(
                  height: ScreenUtil().setHeight(30),
                  alignment: Alignment.center,
                  child: GestureDetector(
                      child: Text("取消选择",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700)),
                      onTap: () {
                        Navigator.pop(context, true);
                      }),
                ),
              ],
            ),
          );
        });
  }

  _takePhotos() async {
    final image = await _picker.getImage(source: ImageSource.camera);
    cropImage(image).then((res) {
      _uploadImage(res).then((value) =>   Navigator.of(context).pop()
      );
    });
  }

  //获取相册照片
  _getPhotos() async {
    try {
      final image = await _picker.getImage(source: ImageSource.gallery);
      cropImage(image).then((res) {
        _uploadImage(res).then((value) =>   Navigator.of(context).pop()
        );
      });
    }catch(e){
      print(e.toString());
    }
  }

  Future<File> cropImage(image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '剪辑',
            toolbarColor: Colors.black,
            activeControlsWidgetColor: Colors.black38,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: '剪辑',
        ));
    if (croppedFile != null) {
      print(croppedFile.path);
      image = croppedFile;
      return image;
    }
  }



  Future<Map<String, dynamic>> _uploadImage(File _imageDir) async {
    print("_uploadImage" + _imageDir.path);
   // Navigator.pop(context, true);
    setState(() {
      list.add(_imageDir.path);
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

      }
    });
  }

  initData() async {
    print("================" + widget.firstPath);
    if (widget.firstPath != "") {
      list.add(widget.firstPath);
    }
    topicSel = List.generate(topic.length, (index) => false);
    print("initData");
    setState(() {});
  }

  List<Widget> getTag() {
    var listBtns = List<Widget>();
    for (var i = 0; i < topic.length; i++) {
      var outlineBtn = FlatButton.icon(
        label: Text(topic[i]),
        icon: Image.asset(
          "assets/icon_topic.png",
          width: ScreenUtil().setWidth(9.34),
          height: ScreenUtil().setWidth(9.34),
        ),
        splashColor: Colors.grey[100],
        //borderSide: BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
            side:
            topicSel[i] ? BorderSide(color: Colors.grey) : BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        textColor: Colors.grey,
        color: Color(0xFFF2F2F2),
        onPressed: () {
          topicSel[i] = !topicSel[i];
          print(topicSel[i]);
          setState(() {});
        },
      );
      listBtns.add(outlineBtn);
    }

    return listBtns;
  }
}
