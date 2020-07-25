import 'dart:async';
import 'dart:collection';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/model/deviceBean.dart';
import 'package:flutter_app/widget/devicescanbutton.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DeviceScan extends StatefulWidget {
  @override
  _DeviceScanState createState() => _DeviceScanState();
}

class _DeviceScanState extends State<DeviceScan> {
  var _searchText = "";
  var _fixText = "正在搜索附近设备";
  var _seconds = 0;
  deviceBean items = null;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    initData();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true);
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
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "设备列表",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

              SizedBox(height: 40,),
              Container(
                margin: EdgeInsets.only(left:40,right:30),
                  child: Text(
                    "${_searchText}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF4A3D3D),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ) ,
              ),

              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(30),
                  height: 400,
                  width: ScreenUtil().setWidth(681),
                  child:
                  ListView.builder(
                      itemCount: items.data.length,
                      itemBuilder: (context, index) {
                        if (items.code == 0) {
                          return deviceScanButton(items.data[index].desc, () {
                            print(items.data[index].id);
                          });
                        }
                        return null;
                      }))
            ]));
  }

  /// 倒计时
  _startTimer() {
    _seconds = 60;
    _searchText = _fixText;
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _searchText = "暂无发现可用设备";
        setState(() {});
        _cancleTimer();
        return;
      }
      _seconds--;
      if (_seconds % 4 == 0) {
        _searchText = _fixText;
      } else {
        _searchText = _searchText + ".";
      }
      setState(() {});
    });
  }

  _cancleTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    /// 页面销毁的时候,清除timer
    _cancleTimer();
  }

  initData() {
    items:
    //List<Map<String, String>>.generate(3, (index) => "Item$index")
    items = deviceBean.fromJson({
      "code": 0,
      "count": 2,
      "data": [
        {
          "id": 1,
          "imgUrl":
          "https://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
          "desc": "智能猫砂盆型号A-1",
          "mac": ""
        },
        {
          "id": 2,
          "imgUrl":
          "https://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
          "desc": "智能猫砂盆型号A-2",
          "mac": ""
        }
      ],
      "msg": "请求成功"
    });
    //setState(() {});
  }
}
