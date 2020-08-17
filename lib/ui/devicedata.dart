import 'package:cached_network_image/cached_network_image.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/daychartwidget.dart';
import 'package:flutter_app/widget/monthchartwidget.dart';
import 'package:flutter_app/widget/weekchartwidget.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DeviceData extends StatefulWidget {
  @override
  _DeviceDataState createState() => _DeviceDataState();
}

class _DeviceDataState extends State<DeviceData>
    with SingleTickerProviderStateMixin {
  var index = 0;
  var _kg = 21;
  var _count = 3;

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
          "设备数据",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(60),
              right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(60)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(46.01)),
                child: CachedNetworkImage(
                  imageUrl:
                      "http://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
                  width: ScreenUtil().setWidth(299.01),
                  height: ScreenUtil().setHeight(233.01),
                  placeholder: (context, url) => Image.asset(
                    "assets/img_cat.png",
                    width: ScreenUtil().setWidth(299.01),
                    height: ScreenUtil().setHeight(233.01),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/img_cat.png",
                    width: ScreenUtil().setWidth(299.01),
                    height: ScreenUtil().setHeight(233.01),
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
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

  initData() {
    //setState(() {});
  }
}
