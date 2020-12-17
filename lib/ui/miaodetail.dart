//import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/entity/pet_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/editpet.dart';
import 'package:flutter_app/ui/petdata.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MiaoDetail extends StatefulWidget {
  final petId;

  MiaoDetail({this.petId});

  @override
  _MiaoDetail createState() => _MiaoDetail();
}

class _MiaoDetail extends State<MiaoDetail> {
  PetEntity items = null;
  var _currentIndex = 0;

  ///状态栏样式-沉浸式状态栏
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: items == null
              ? Text("加载中")
              : ListView(
                  children: <Widget>[
                    _banner(context),
                    _content(context),
                  ],
                ),
        ));
  }

  Widget _banner(BuildContext context) {
    var arr = [];
    arr = items.data[_currentIndex].imgurls.split(",");
    print(arr);
    return Stack(
      children: [
//        CachedNetworkImage(
//          imageUrl: arr==null?Text("还没有上传图片"):SpUtils.URL+arr[0];
//          placeholder: (context, url) => new CircularProgressIndicator(),
//          errorWidget: (context, url, error) => new Icon(Icons.error),
//          fit: BoxFit.cover,
//        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: ScreenUtil().setHeight(200.67),
          child: arr.length == 0
              ? Text("还没有设置宠物图片")
              : Swiper(
                  outer: false,
                  key: UniqueKey(),
                  viewportFraction: 1,
                  itemBuilder: (c, i) {
                    return CachedNetworkImage(
                      imageUrl: "${SpUtils.URL + arr[i]}",
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: arr.length,
                  autoplay: false,
                ),
        ),

        Positioned(
          top: ScreenUtil().setHeight(9),
          left: ScreenUtil().setWidth(5),
          child: IconButton(
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
      ],
    );
  }

  Widget _content(BuildContext context) {
    var now = new DateTime.now();
    var birth = DateTime.parse(items.data[_currentIndex].birthday);
    var diff = now.difference(birth);
    var age = (diff.inDays ~/ 365).toString() + "岁";
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(20.67),
        left: ScreenUtil().setWidth(26.33),
        // right: ScreenUtil().setWidth(16.67)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: ScreenUtil().setWidth(120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      items.data[_currentIndex].name,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          fontWeight: FontWeight.w700,
                          color: Color(0xff4A3D3D)),
                    ),
                    Text(
                      "(" + items.data[_currentIndex].type + ")",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w700,
                          color: Color(0xff4A3D3D)),
                    )
                  ]),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(8.67),
                        bottom: ScreenUtil().setHeight(11.67)),
                    width: ScreenUtil().setWidth(40),
                    height: ScreenUtil().setHeight(1),
                    color: Color(0xFF999999),
                  ),
                  Row(
                    children: [
                      Text(
                        "品种：",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        items.data[_currentIndex].type,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  Row(
                    children: [
                      Text(
                        "年龄：",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        age,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(18),
                  ),
                  Row(
                    children: [
                      Text(
                        "体重：",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                      Text(
                        items.data[_currentIndex].weight.toString() + "kg",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w700,
                            color: Color(0xff333333)),
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(
            width: ScreenUtil().setWidth(31.33),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/ic_data_pet.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                        ),
                        Text(
                          "数据",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              color: Color(0xff666666)),
                        ),
                      ],
                    ),
                    onTap: () {
                      var arr = [];
                      arr = items.data[_currentIndex].imgurls.split(",");
                      var avatar=arr.length>0?arr[0]:null;
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new PetDataPage(petId: items.data[_currentIndex].petId,img:avatar,name:items.data[_currentIndex].name);
                      }));
                    },
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/ic_set_pet.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                        ),
                        Text(
                          "设置",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              color: Color(0xff666666)),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (_) {
                        return new EditPet(petId: items.data[_currentIndex].petId);
                      }));
                    },
                  ),

                  //IconButton(),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60.67),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _currentIndex <= 0
                          ? _currentIndex = items.data.length - 1
                          : _currentIndex--;
                      print(_currentIndex);
                      setState(() {});
                    },
                    child: Image.asset(
                      "assets/ic_previous.png",
                      width: ScreenUtil().setWidth(25),
                      height: ScreenUtil().setHeight(25),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  ),
                  GestureDetector(
                    onTap: () {
                      _currentIndex >= items.data.length - 1
                          ? _currentIndex = 0
                          : _currentIndex++;
                      print(_currentIndex);
                      setState(() {});
                    },
                    child: Image.asset(
                      "assets/ic_next.png",
                      width: ScreenUtil().setWidth(25),
                      height: ScreenUtil().setHeight(25),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    _currentIndex = widget.petId;
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    ResultData response = await MiaoApi.getPetList(user.data.user.userId);
    if (response.code != 200) {
      _showError("获取数据错误", response.message);
      return;
    }

    setState(() {
      items = JsonConvert.fromJsonAsT(response.data);
    });
  }

  _showError(String title, String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: title,
            message: msg,
            negativeText: "返回",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );
        });
  }
}
