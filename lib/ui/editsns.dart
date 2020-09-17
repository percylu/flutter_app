import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditSns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(100)),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(445),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Image(
                      image: AssetImage("assets/bg_camera@3x.png"),
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setWidth(40),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      _showPicPicker(context);
                    },
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(70),
                  ),
                  GestureDetector(
                    child: Image(
                      image: AssetImage("assets/ic_edit@3x.png"),
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setWidth(40),
                      alignment: Alignment.center,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              GestureDetector(
                  child: Icon(Icons.close, size: ScreenUtil().setWidth(20)),
              onTap: (){
                    Navigator.pop(context);
              },
              )
            ],
          ),
        )); //flutter_screenuitl >= 1.2
  }

  _showPicPicker(BuildContext context) {
    showModalBottomSheet(
        elevation:2.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (BuildContext context) {
          return new Container(
            margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
            left:ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            ),
            height: ScreenUtil().setHeight(100),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ScreenUtil().setHeight(30),
                alignment: Alignment.center
                ,
                    child: GestureDetector(
                        child: Text("拍摄照片",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w700)),
                        onTap: () {
                          _takePhotos();
                          Navigator.pop(context, true);
                        })),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey.shade300,
                ),
                //  SizedBox(height:ScreenUtil().setHeight(15) ,),
                Container(
                  height: ScreenUtil().setHeight(30),

                  alignment: Alignment.center
                  ,
                  child: GestureDetector(
                      child: Text("相册中选取照片",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700)),
                      onTap: () {
                        _getPhotos();
                        Navigator.pop(context, true);
                      }),
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey.shade300,
                ),
                Container(
                  height: ScreenUtil().setHeight(30),

                  alignment: Alignment.center
                  ,
                  child: GestureDetector(
                      child: Text("取消选择",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              fontWeight: FontWeight.w700)),
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
    cropImage(image).then((res) {
      _uploadImage(res);
    });
  }
  Future<Null> cropImage(image) async {
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
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )
    );
    if (croppedFile != null) {
      image = croppedFile;
      return image;
    }
  }
  //获取相册照片
  _getPhotos() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _uploadImage(image);
  }

  Future<Map<String, dynamic>> _uploadImage(File _imageDir) async {
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
      if (response.code == 200) {}
    });
  }
}
