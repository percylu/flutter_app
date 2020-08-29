import 'package:cached_network_image/cached_network_image.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/model/miaoBean.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/daychartwidget.dart';
import 'package:flutter_app/widget/monthchartwidget.dart';
import 'package:flutter_app/widget/weekchartwidget.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PetDataPage extends StatefulWidget {
  final petId;
  final img;
  final name;
  PetDataPage({this.petId,this.img,this.name});
  @override
  _PetDataState createState() => _PetDataState();
}

class _PetDataState extends State<PetDataPage>
    with SingleTickerProviderStateMixin {
  var index = 0;
  var _kg = 20;
  var _count = 3;
  miaoBean items = new miaoBean();

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1335, allowFontScaling: true);
    return Scaffold(
      appBar:
      AppBar(
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Image.asset(
            "assets/ic_back.png",
            width: 12,
            height: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "宠物数据",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(60),
              right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(16.01)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: SpUtils.URL+widget.img,
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setWidth(200),
                      placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                      fit: BoxFit.fill,
                    )),
              ),
              Text(widget.name,style: TextStyle(fontSize: ScreenUtil().setSp(40),
                fontWeight: FontWeight.w700
              ),),
              Container(
                margin: EdgeInsets.only(top:ScreenUtil().setHeight(16.01)),
                width: ScreenUtil().setWidth(423),
                height: ScreenUtil().setHeight(77.1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 1.0), //阴影xy轴偏移量
                          blurRadius: 2.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                          )
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF000000), width: 1)),
                  //indicatorSize: TabBarIndicatorSize.label,
                  //indicatorWeight: n,
                  tabs: <Widget>[
                    Tab(text: "日"),
                    Tab(text: "周"),
                    Tab(text: "月"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: new NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    DayChart(),
                    WeekChart(),
                    MonthChart(),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "日均排泄量：${_kg}g",
                    style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(50),
                  ),
                  Text(
                    "日均如厕次数：${_count}",
                    style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          )),
    );
  }

  initData() async{
    index=widget.petId;
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
