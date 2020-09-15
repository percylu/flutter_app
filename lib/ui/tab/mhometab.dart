import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/acticleWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/picandpicbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MiaoHomeTabView extends StatefulWidget {
  MiaoHomeTabView({Key key}) : super(key: key);

  @override
  State createState() {
    return _MiaoHomeTabView();
  }
}

class _MiaoHomeTabView extends State<MiaoHomeTabView> {
  var isRefresh = false;
  List swiperDataList = [];
  var _futureBuilderFuture;
  var _imgurl = "";
  var _desc = "加载中...";
  var _content = "加载中...";

  @override
  void initState() {
    print("--initState-");
    super.initState();
    //_futureBuilderFuture = initData(context);
    var context=this.context;

    initData(context);
  }

  initData(BuildContext context) async{
    ResultData res= await MiaoApi.getArticle();
      if (res.code == 200) {
        _imgurl = SpUtils.URL + res.data['data']['articleCover'];
          _desc = res.data['data']['articleTitle'];
          _content = res.data['data']['articleContent'];
      }

  //  if (!this.isRefresh) {
      ResultData resa=await MiaoApi.banner();//.then((res) {
        print("--initData-");

        ResultData response = resa;
        if (response.code == 200) {
          List list = [];
          for (var banner in response.data['data']) {
            list.add(SpUtils.URL + banner['bannerImg']);
          }
//          setState(() {
          this.isRefresh = true;
          this.swiperDataList = list;
//          });
        } else {
          if (response.code == 1502) {
            Navigator.pushReplacementNamed(context, "home");
          }
          _showError(context, response.message);
        }
     // });
  //  }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1335, allowFontScaling: true);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
          children: <Widget>[
      this.swiperDataList.length>0?_banner(context):
      Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(0),
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: ScreenUtil().setHeight(549.99),
      child: Text("加载中..."),
    ),

    _buildCategoryRow(context)
    ,
    _buildCenterPic(context)
    ],
    ),
    );
  }

  _showError(BuildContext context, String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "请先登陆",
            message: msg,
            negativeText: "返回登陆",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );
        });
  }

  Widget _buildCategoryRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(220),
      child: Row(
        children: <Widget>[
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_first@3x.png", "assets/words_msp@3x.png", () {
              Navigator.pushNamed(context, "devicelist");
            }),
          ),
          Container(
            width: 1,
            height: ScreenUtil().setHeight(120),
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_second@3x.png", "assets/words_ysj@3x.png", () {
              Navigator.pushNamed(context, "comming");
            }),
          ),
          Container(
            width: 1,
            height: ScreenUtil().setHeight(120),
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_third@3x.png", "assets/words_wsq@3x.png", () {
              Navigator.pushNamed(context, "comming");
            }),
          ),
        ],
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(0),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: ScreenUtil().setHeight(589.99),
        child: Stack(
          children: [
            Swiper(
              outer: false,
              autoplayDelay: 2000,
              itemBuilder: (c, i) {
                return //swiperDataList.length>0?
                  CachedNetworkImage(
                    imageUrl: "${swiperDataList[i]}",
                    placeholder: (context, url) =>
                    new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.cover,
                  );
                //:Text("加载中...");
              },
              pagination: new SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(0),
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.deepOrangeAccent.shade200,
                  )),
              itemCount: swiperDataList.length,
              autoplay: true,
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 30, left: MediaQuery
                    .of(context)
                    .size
                    .width - 80),
                child: RaisedButton(
                  padding: EdgeInsets.all(3.0),
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  child: Image.asset(
                    "assets/ic_miao.png",
                    scale: 1.8,
                  ),
                  onPressed: () {},
                )),
          ],
        ));
  }

  Widget _buildCenterPic(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            GestureDetector(
                onTap: () {
                  print("news");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (content) {
                    return Article(title: this._desc, html: this._content);
                  }));
                },
                child:
                _imgurl!=""?
                FadeInImage.assetNetwork(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: ScreenUtil().setHeight(241.98),
                  placeholder: "assets/img_cat.png",
                  image: "${_imgurl}",
                  fit: BoxFit.cover,
                ):Text("加载中...")
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
                padding: EdgeInsets.only(left: 10, top: 2),
                decoration: BoxDecoration(color: Color(0x8c000000)),
                child: Text(
                  "${_desc}",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
