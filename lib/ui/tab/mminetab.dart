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
import 'package:flutter_app/widget/htmlWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../home.dart';

class MiaoMine extends StatefulWidget {
  final reslut;

  MiaoMine({this.reslut});

  @override
  MiaoMineTabView createState() => MiaoMineTabView();
}

class MiaoMineTabView extends State<MiaoMine> {
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
                child: Column(
              children: [
                Container(
                    height: ScreenUtil().setHeight(150),
                    child: Stack(
                      children: [
                        Image(image: AssetImage("assets/mine/edit_bg@3x.png")),
                        Positioned(
                          left: ScreenUtil().setWidth(16),
                          top: ScreenUtil().setHeight(77),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: ScreenUtil().setWidth(53.33),
                              width: ScreenUtil().setWidth(53.33),
                              imageUrl: "${_avatar}",
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
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
                  // 控件高度
                  padding: EdgeInsets.all(0),
                  constraints: new BoxConstraints.expand(
                    height: ScreenUtil().setHeight(218.6),
                  ),
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                    image: new AssetImage("assets/mine/bg_content@3x.png"),
                    centerSlice: new Rect.fromLTRB(
                        0,
                        0,
                        ScreenUtil().setWidth(250),
                        ScreenUtil().setHeight(445)),
                  )),
                  child: Swiper(
                    outer: false,
                    viewportFraction: 0.5,
                    scale: 0.1,
                    onTap: (i) {},
                    onIndexChanged: (i) {
                      setState(() {});
                    },
                    itemBuilder: (c, i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          width: ScreenUtil().setWidth(114.67),
                          height: ScreenUtil().setWidth(114.67),
                          imageUrl: example[i],
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    itemCount: 2,
                    autoplay: false,
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
