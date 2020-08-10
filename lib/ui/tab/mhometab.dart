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
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/picandpicbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class MiaoHomeTabView extends StatefulWidget{
  MiaoHomeTabView({Key key}) : super(key: key);

  @override
  State createState() {
    return _MiaoHomeTabView();
  }
}
class _MiaoHomeTabView extends State<MiaoHomeTabView> {
  var isRefresh=false;
  List swiperDataList=[];

  @override
  void initState() {
    print("--initState-");
    super.initState();
    //initData(context);

  }
  initData(BuildContext context) {
    if(!this.isRefresh) {
      MiaoApi.banner().then((res) {
        print("--initData-");

        ResultData response = res;
        if (response.code == 200) {
          List list = [];
          for (var banner in response.data['data']) {
            list.add(SpUtils.URL + banner['bannerImg']);
          }
          setState(() {
            this.isRefresh=true;
            this.swiperDataList = list;
            print("init:");
            print(this.swiperDataList);
          });
        } else {
          _showError(context, response.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: <Widget>[
      FutureBuilder(
      future: initData(context),
      builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
        if(this.swiperDataList.length>0){
          return _banner(context);
        }else{
          return Text("加载中...");
        }
        /*表示数据成功返回*/
      },
      ),
       /*   _banner(context),*/
          _buildCategoryRow(context),
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
            title: "获取广告错误",
            message: msg,
            negativeText: "重试",
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
          Expanded(
            child: picAndPicButton("assets/btn_mxx_second@3x.png",
                "assets/words_ysj@3x.png", () {
                  Navigator.pushNamed(context, "comming");
                }),

          ),
          Expanded(
            child: picAndPicButton("assets/btn_mxx_third@3x.png",
                "assets/words_wsq@3x.png", () {
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
        height: ScreenUtil().setHeight(549.99),
        child: Stack(
          children: [
            Swiper(
              outer: false,
              autoplayDelay: 2000,
              itemBuilder: (c, i) {
                return swiperDataList.length>0?
                CachedNetworkImage(
                  imageUrl: "${swiperDataList[i]}",
                  placeholder: (context, url) =>
                  new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.fill,):Text("加载中...");
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
      margin: EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            GestureDetector(onTap: () {
              print("news");
            }, child: FadeInImage.assetNetwork(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: ScreenUtil().setHeight(242.01),
              placeholder: "assets/img_cat.png",
              image:
              "https://img1.360buyimg.com/da/jfs/t1/132819/32/4365/158541/5f0d0a3fEd1a401c7/4741c28e0753541c.jpg!q70.jpg",
              fit: BoxFit.fill,
            )),

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
                decoration: BoxDecoration(
                    color: Color(0x8c000000)
                ),
                child: Text(
                  "救命！！我在这群沙雕猫中出不去了",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15),
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
