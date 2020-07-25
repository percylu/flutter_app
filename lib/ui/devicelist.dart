/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widget/devicelistwidgit.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {

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
      body: Stack(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(800),
              //margin: EdgeInsets.only(top:ScreenUtil().setHeight(120)),
              child: ListView(

            children: <Widget>[
              DeviceListWidget(
                  "http://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
                  "象牙白",
                  "型号A-1",
                  ()=>_onPlay(1),
                  ()=>_onClose(1)),
              DeviceListWidget(
                  "http://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
                  "象牙白",
                  "型号A-2",
                  ()=>_onPlay(2),
                  ()=>_onClose(2)),
              DeviceListWidget(
                  "http://alipic.lanhuapp.com/ps212593296989fa70-5296-46d0-85a7-883ab5df03a1",
                  "象牙白",
                  "型号A-3",
                  ()=>_onPlay(3),
                  ()=>_onClose(3)),
            ],
          )),

          Container(
            alignment: Alignment.topCenter,
            width: ScreenUtil().setWidth(550),
            height: ScreenUtil().setHeight(200),
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(850),left:ScreenUtil().setWidth(100),right: ScreenUtil().setWidth(100) ),
            padding:
                EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60), top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
              color: new Color(0xFFF28282),
              onPressed: () {
                Navigator.pushNamed(context, 'devicescan');
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ Text("添加机器",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
                    SizedBox(width: 10,),
                    Image.asset("assets/ic_scan@3x.png",scale: 2,)
                    ]),
            )
          )
        ],
      ),
    );
  }

  _onPlay(int id) {
    print(id);
    Navigator.pushNamed(context, "devicedetail");
  }

    _onClose(int id) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new     MessageDialog(
              title:"确认删除该设备吗?", message:"型号A-2", negativeText:"确认删除",
              onCloseEvent: (){
                Navigator.pop(context);
              },
            onConfirmEvent: (){
              Navigator.pop(context);

            },
          );

        });

  }
}
