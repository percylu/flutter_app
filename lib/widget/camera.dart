
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class ImagePickerPage extends StatefulWidget {
  ImagePickerPage({Key key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  String _imageUrl;

  //拍照
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
      _imageUrl = path;
    });
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("拍照"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("拍照"),
            onPressed: _takePhotos,
          ),
          RaisedButton(
            child: Text("相册"),
            onPressed: _getPhotos,
          ),
          Center(
            child:
            _imageUrl == null ? Text("No image ") : Image.network(_imageUrl),
          )
        ],
      ),
    );
  }
}