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
import 'package:flutter_app/ui/editpet.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';
import 'package:flutter_app/model/miaoBean.dart';

class PetList extends StatefulWidget {
  @override
  _PetList createState() => _PetList();
}

class _PetList extends State<PetList> {
  var _petId = "";
  var _name = "";
  var _avatar = "";
  var _sexy = 0;
  var _isTop = false;
  var _futureBuilderFuture;
  miaoBean items = new miaoBean();
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = initData();
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
              child: Image.asset(
                "assets/ic_list.png",
                width: ScreenUtil().setWidth(13),
                height: ScreenUtil().setHeight(13),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                  return new HomePage(index: 1);
                }));
              }),
        ],
        backgroundColor: Colors.white,
        title: Text(
          "宠物列表",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: initData,
        child: Column(
          children: [
            Container(
              height: ScreenUtil().setHeight(300),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(22),
                        right: ScreenUtil().setWidth(22)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(63),
                                    child: CachedNetworkImage(
                                      imageUrl: items.data[index].imgUrl,
                                      width: ScreenUtil().setWidth(63),
                                      height: ScreenUtil().setWidth(63),
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                      fit: BoxFit.fill,
                                    )),
                                Positioned(
                                  bottom: ScreenUtil().setHeight(0),
                                  left: ScreenUtil().setWidth(40),
                                  child: Image.asset(
                                    items.data[index].sexy == 0
                                        ? "assets/ic_symbol_man.png"
                                        : "assets/ic_symbol_woman.png",
                                    width: ScreenUtil().setWidth(20.33),
                                    height: ScreenUtil().setHeight(20.33),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(13.33),
                            ),
                            Container(
                              width:ScreenUtil().setWidth(60),
                              child: Row(children: [
                                Text(
                                  items.data[index].name,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(15.33)),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                                GestureDetector(
                                  child: Image.asset("assets/ic_edit_address.png",
                                      width: ScreenUtil().setWidth(11),
                                      height: ScreenUtil().setHeight(12)),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(new MaterialPageRoute(builder: (_) {
                                      return new EditPet(petId: index);
                                    }));
                                  },
                                ),
                              ]),

                            ),

                            SizedBox(
                              width: ScreenUtil().setWidth(8),
                            ),
                            GestureDetector(
                              child: Image.asset("assets/ic_top_address.png",
                                  width: ScreenUtil().setWidth(22.66),
                                  height: ScreenUtil().setHeight(22.66)),
                              onTap: () {
                                print("tap");
                                Data item = items.data[index];
                                items.data.removeAt(index);
                                print(item.name);
                                setState(() {
                                  items.data.insert(0, item);
                                  print(items.data);

                                });
                              },
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(5),
                            ),
                            GestureDetector(
                              child: Image.asset("assets/ic_del_address.png",
                                  width: ScreenUtil().setWidth(22.66),
                                  height: ScreenUtil().setHeight(22.66)),
                              onTap: () {
                                setState(() {
                                  items.data.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                          alignment: Alignment.center,
                          color: Colors.grey.shade300,
                          height: 1,
                          width: ScreenUtil().setWidth(194.66),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items.data == null ? 0 : items.data.length,
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
              color: new Color(0xFFF28282),
              onPressed: () {},
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Text("添加宠物",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }

  Future initData() async {
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
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0"
          ]
        }
      ],
      "msg": "请求成功"
    });
    setState(() {});
    return items;
  }
}
