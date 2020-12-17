import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'home.dart';

class FriendSns extends StatefulWidget {
  @override
  _FriendSns createState() => _FriendSns();
}

class _FriendSns extends State<FriendSns> {
  var example = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=d8b2c61fd3aca72a34e042f8c6eb2241&imgtype=0&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2F5fe83cfb2bd1bff8154be5b70975f3bb.png%40wm_2%2Ct_55m%2B5a625Y%2B3L%2Ba0vuWkmumYgeWuoOeJqQ%3D%3D%2Cfc_ffffff%2Cff_U2ltSGVp%2Csz_23%2Cx_15%2Cy_15",
  ];

  var _current = 0;
  var _name = "";
  var _avatar = "";
  var _isfollow = false;
  var _islike = false;
  List comment = ["什么这么可爱", "可爱","什么鬼", "我不信"];
  TextEditingController messageController;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
        resizeToAvoidBottomPadding: false, //输入框抵住键盘 内容不随键盘滚动
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.8,
          backgroundColor: Colors.white,
          title: Text(
            "详情",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
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
                    return new HomePage(index: 2);
                  }));
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.5, color: Color(0xFF525050)),
                    borderRadius: BorderRadiusDirectional.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    width: ScreenUtil().setWidth(222),
                    height: ScreenUtil().setWidth(222),
                    imageUrl: example[_current],
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(10)),
                height: ScreenUtil().setHeight(56.34),
                child: Swiper(
                  outer: false,
                  viewportFraction: 0.34,
                  scale: 1,
                  onTap: (i) {
                    setState(() {
                      _current = i;
                    });
                  },
                  onIndexChanged: (i) {
                    setState(() {
                      _current = i;
                    });
                  },
                  itemBuilder: (c, i) {
                    return Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(5),
                            right: ScreenUtil().setWidth(5)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.5, color: Color(0xFF525050)),
                            borderRadius: BorderRadiusDirectional.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            width: ScreenUtil().setWidth(56.34),
                            height: ScreenUtil().setWidth(56.34),
                            imageUrl: example[i],
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        ));
                  },
                  itemCount: example.length,
                  autoplay: false,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(15),
                          top: ScreenUtil().setHeight(5),
                          bottom: ScreenUtil().setHeight(5)),
                      padding: EdgeInsets.all(6),
                      //width: ScreenUtil().setWidth(100),
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icon_topic.png",
                            width: ScreenUtil().setWidth(9.34),
                            height: ScreenUtil().setHeight(9.34),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5)),
                          Text(
                            "2020亚洲宠物展开启",
                            style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: ScreenUtil().setSp(8)),
                          )
                        ],
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(15),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      child: ClipOval(
                        child: Image.network(
                          "${_avatar}",
                          height: ScreenUtil().setWidth(46.17),
                          width: ScreenUtil().setWidth(46.17),
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {},
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Text(" ${_name}",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Text(" 吃饭睡觉",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(8),
                                  color: Color(0xFF666666))),
                          SizedBox(
                            height: ScreenUtil().setHeight(6),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.grey.shade400,
                                size: 16,
                              ),
                              Text("深圳聚创金谷",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(6.67),
                                      color: Colors.grey.shade400))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(60),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "15分钟前",
                        style: TextStyle(color: Color(0xFF9A9A9A)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(5),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: ImageIcon(AssetImage("assets/ic_follow@3x.png"),
                            color: _isfollow ? Colors.deepOrange : Colors.grey,
                            size: ScreenUtil().setWidth(13.34)),
                        onPressed: () {
                          follow();
                        }),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    IconButton(
                        icon: ImageIcon(
                          AssetImage("assets/ic_likes@3x.png"),
                          color: _islike ? Colors.deepOrange : Colors.grey,
                          size: ScreenUtil().setWidth(13.34),
                        ),
                        onPressed: () {
                          like();
                        }),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    IconButton(
                        icon: ImageIcon(AssetImage("assets/ic_message@3x.png"),
                            color: Colors.grey,
                            size: ScreenUtil().setWidth(13.34)),
                        onPressed: () {
                          showMessage();
                        }),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    IconButton(
                        icon: ImageIcon(AssetImage("assets/ic_shield@3x.png"),
                            color: Colors.grey,
                            size: ScreenUtil().setWidth(13.34)),
                        onPressed: () {
                          showunlike();
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(3),
              ),
              Container(
                height: ScreenUtil().setHeight(20)*comment.length ,
                padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(10),
                    right: ScreenUtil().setWidth(10)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200),
                child: comment.length == 0
                    ? Container(
                        width: ScreenUtil().setWidth(250),
                        margin:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(3)),
                        child: Text("暂无评论"))
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("民署:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                SizedBox(
                                  width: ScreenUtil().setWidth(5),
                                ),
                                Text(
                                  comment[index],
                                  style: TextStyle(color: Colors.black12),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: comment == null ? 0 : comment.length,
                      ),
              )
            ],
          ),
        ));
  }

  void initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    setState(() {
      _name = user.data.user.name;
      _avatar = SpUtils.URL + user.data.user.avatar;
      print("--------+++++++++" + _name);
      print("--------+++++++++" + _avatar);
    });
  }

  void follow() {
    setState(() {
      _isfollow = !_isfollow;
    });
  }

  void like() {
    setState(() {
      _islike = !_islike;
    });
  }

  void showunlike() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(210),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20)),
            alignment: Alignment.bottomRight,
            child: new SimpleDialog(
              contentPadding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 8.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.5, color: Colors.grey),
                borderRadius: BorderRadiusDirectional.circular(20),
              ),
              children: <Widget>[
                new SimpleDialogOption(
                  child: Container(
                    child: Text(
                      "屏蔽此用户",
                      style: TextStyle(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                ),
                new SimpleDialogOption(
                  child: Container(
                    child: Text(
                      "仅隐藏此状态",
                      style: TextStyle(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: EdgeInsets.all(ScreenUtil().setWidth(5)),
                ),
                new SimpleDialogOption(
                  child: Container(
                    child: Text(
                      "举报该动态",
                      style: TextStyle(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
    ).then((val) {
      print(val);
    });
  }

  void showMessage() {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              // margin: EdgeInsets.only(
              //     top: ScreenUtil().setHeight(20),
              //     left: ScreenUtil().setWidth(20),
              //     right: ScreenUtil().setWidth(20)),
              alignment: Alignment.center,
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(50),
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadiusDirectional.circular(10),
                ),
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "输入评论",
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0)),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20)),
                      child: OutlineButton(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadiusDirectional.circular(10),
                          ),
                          child: Text(
                            "发表",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }))
                ],
              ));
        });
  }
}
