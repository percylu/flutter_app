import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/draws.dart';
import 'package:flutter_app/ui/editmine.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/utility/bubble.dart';
import 'package:flutter_app/widget/htmlWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../editsns.dart';
import '../home.dart';

class MiaoMine extends StatefulWidget {
  final reslut;

  MiaoMine({this.reslut});

  @override
  MiaoMineTabView createState() => MiaoMineTabView();
}

class MiaoMineTabView extends State<MiaoMine> {
  var _visible = true;
  var _name = "";
  var _avatar = "";
  var example = [
    "https://pic.ibaotu.com/01/21/11/18p888piC2RW1.jpg-0.jpg!ww7002",
    "https://pic.ibaotu.com/01/21/11/18p888piC2RW1.jpg-0.jpg!ww7002"
  ];

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

//      margin: EdgeInsets.only(
//          //top: ScreenUtil().setHeight(11.33),
//          left: ScreenUtil().setWidth(6.67),
//          right: ScreenUtil().setWidth(6.67)),
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Image.asset(
              "assets/mine/ic_service@3x.png",
              width: ScreenUtil().setWidth(16.37),
              height: ScreenUtil().setHeight(13.67),
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          actions: [
            FlatButton(
                child: Text(
                  "喵",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(13.33)),
                ),
                onPressed: () {
                  //Navigator.pop(context);
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (_) {
                    return new HomePage(index: 1);
                  }));
                }),
          ],
        ),
        backgroundColor: Colors.white,
        drawer: Drawers(),
        body: WillPopScope(
            child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                margin: EdgeInsets.only(bottom: 0),
                child: ListView(
                  children: [
                    Container(
                        height: ScreenUtil().setHeight(150),
                        child: Stack(
                          children: [
                            Image(
                                image:
                                AssetImage("assets/mine/edit_bg@3x.png")),
                            Positioned(
                              left: ScreenUtil().setWidth(16),
                              top: ScreenUtil().setHeight(77),
                              child: GestureDetector(
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    height: ScreenUtil().setWidth(53.33),
                                    width: ScreenUtil().setWidth(53.33),
                                    imageUrl: "${_avatar}",
                                    placeholder: (context, url) =>
                                    new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _visible = !_visible;
                                  });

                                  print(_visible);
                                },
                              ),
                            ),
                            Positioned(
                                left: ScreenUtil().setWidth(66),
                                top: ScreenUtil().setHeight(30),
                                child: Offstage(
                                  offstage: _visible,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _visible = true;
                                        });

                                        print(_visible);
                                      },
                                      child: BubbleWidget(

                                        ScreenUtil().setWidth(140),
                                        ScreenUtil().setWidth(80),
                                        Color(0xff414141),
                                        BubbleArrowDirection.left,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(
                                              ScreenUtil().setWidth(10)),
                                          child: Text(
                                            "这个家伙很懒，什么也没有留下！",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenUtil().setSp(8),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )),
                                )),
                            Positioned(
                                left: ScreenUtil().setWidth(23),
                                top: ScreenUtil().setHeight(125),
                                child: Text(
                                  _name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: ScreenUtil().setSp(13.33),
                                      color: Color(0xFF252623)),
                                )),
                            Positioned(
                                left: ScreenUtil().setWidth(100),
                                top: ScreenUtil().setHeight(115),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "关注",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          "20",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(25),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "粉丝",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          "7",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(25),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "动态",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(5),
                                        ),
                                        Text(
                                          "20",
                                          style: TextStyle(
                                              color: Color(0xFF4A3D3D),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                          ],
                        )),
                    Container(
                      //控件高度
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(30),
                      ),
                      constraints: new BoxConstraints.expand(
                          height: ScreenUtil().setHeight(218)),
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: Image
                                .asset(
                              "assets/mine/bg_content@3x.png",
                              width: double.infinity,
                              height: double.infinity,
                            )
                                .image,
                            // centerSlice: Rect.fromLTRB(19, 13, ScreenUtil().setWidth(250), ScreenUtil().setHeight(200))
                          )),
                      child: Column(
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(120),
                            child: Swiper(
                              outer: false,
                              viewportFraction: 0.5,
                              scale: 1,
                              onTap: (i) {},
                              onIndexChanged: (i) {
                                setState(() {});
                              },
                              itemBuilder: (c, i) {
                                return Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(18),
                                        right: ScreenUtil().setWidth(18)),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              //width: ScreenUtil().setWidth(50),
                                              // height: ScreenUtil().setHeight(114.67),
                                              imageUrl: example[i],
                                              placeholder: (context, url) =>
                                              new CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                              new Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width,
                                                height: 25,
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 2),
                                                decoration: BoxDecoration(
                                                    color: Color(0x8c000000)),
                                                child: Text(
                                                  "c车wire hi",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            )
                                          ],
                                        )));
                              },
                              itemCount: 2,
                              autoplay: false,
                            ),
                          ),
                          Container(
                              width: ScreenUtil().setWidth(35),
                              height: ScreenUtil().setWidth(35),
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(160),
                                  right: ScreenUtil().setWidth(10),
                                  top: ScreenUtil().setHeight(15)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                //border: Border.all(color: Colors.black12, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                                      blurRadius: 2.0, //阴影模糊程度
                                      spreadRadius: 1.0 //阴影扩散程度
                                  )
                                ],
                                borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                              ),
                              alignment: Alignment.center,
                              child: GestureDetector(
                                child: Image.asset(
                                  "assets/mine/ic_camera@3x.png",
                                  width: ScreenUtil().setWidth(20),
                                  height: ScreenUtil().setHeight(20),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(builder: (_) {
                                    return new EditSns();
                                  }));
                                },
                              ))
                        ],
                      ),
                    )
                  ],
                )),
            onWillPop: () async {
              return false;
            }));
  }

  void initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    print("-----------------");
    setState(() {
      _name = user.data.user.name;
      _avatar = SpUtils.URL + user.data.user.avatar;
      print("--------+++++++++" + _name);
    });
  }
}
