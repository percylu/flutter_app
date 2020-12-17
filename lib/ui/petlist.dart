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
  import 'package:flutter_app/entity/pet_entity.dart';
  import 'package:flutter_app/generated/json/base/json_convert_content.dart';
  import 'package:flutter_app/ui/addpet.dart';
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
    PetEntity items = null;
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
              Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                return new HomePage(index: 1);
              }));          },
          ),
          actions: [
            FlatButton(
                child: Image.asset(
                  "assets/ic_list.png",
                  width: ScreenUtil().setWidth(13),
                  height: ScreenUtil().setHeight(13),
                ),
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                    return new HomePage(index: 2);
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
                                        imageUrl: SpUtils.URL+items.data[index].imgurls.split(",")[0],
                                        width: ScreenUtil().setWidth(63),
                                        height: ScreenUtil().setWidth(63),
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                        fit: BoxFit.cover,
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
                                  Container(alignment: Alignment.centerLeft,
                                      width:ScreenUtil().setWidth(42),

                                      child: Text(
                                    items.data[index].name,
                                    overflow:TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(13.33)),
                                  )),

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
                                        return new EditPet(petId: items.data[index].petId);
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
                                onTap: () async{
                                  ResultData response = await MiaoApi.petSetTop(items.data[index].petId);
                                  if(response.code==200){
                                    PetData item = items.data[index];
                                    items.data.removeAt(index);
                                    print(item.name);
                                    setState(() {
                                      items.data.insert(0, item);
                                    });
                                  }else if(response.code==1502){
                                    _showError("请先登陆", response.message);
                                    Navigator.pushReplacementNamed(context, "home");
                                  }else{
                                    _showError("置顶", response.message);
                                  }
                                },
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(5),
                              ),
                              GestureDetector(
                                child: Image.asset("assets/ic_del_address.png",
                                    width: ScreenUtil().setWidth(22.66),
                                    height: ScreenUtil().setHeight(22.66)),
                                onTap: () async{
                                    ResultData response = await MiaoApi.petDelete(items.data[index].petId);
                                    if(response.code==200){
                                      setState(() {
                                        items.data.removeAt(index);
                                      });
                                    }else if(response.code==1502){
                                      _showError("请先登陆", response.message);
                                      Navigator.pushReplacementNamed(context, "home");
                                    }else{
                                      _showError("置顶", response.message);
                                    }
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
                  itemCount: items == null ? 0 : items.data.length,
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                color: new Color(0xFFF28282),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(new MaterialPageRoute(builder: (_) {
                    return new AddPet();
                  }));
                },
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

    Future  initData() async {
      var data = await SpUtils.getObjact(Config.USER);
      LoginEntity user = JsonConvert.fromJsonAsT(data);
      ResultData response = await MiaoApi.getPetList(user.data.user.userId);
      if (response.code != 200) {
        _showError("获取数据错误", response.message);
        return null;
      }

      setState(() {
        items = JsonConvert.fromJsonAsT(response.data);
      });
      return items;
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
