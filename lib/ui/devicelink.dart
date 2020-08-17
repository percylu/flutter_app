import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart'
    as HandOverDutyDatePicker;
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class DeviceLink extends StatefulWidget {
  @override
  _DeviceLinkState createState() => _DeviceLinkState();
}

class _DeviceLinkState extends State<DeviceLink> {
  @override
  void initState() {
    super.initState();
    initData();
  }
  var _html="加载中...";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
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
          "配网中心",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          width: ScreenUtil().setWidth(182.33),
          height: ScreenUtil().setHeight(313.33),
          margin: EdgeInsets.only(top:ScreenUtil().setHeight(29.33),left:ScreenUtil().setWidth(34.67)),
          padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(10),
              bottom: ScreenUtil().setWidth(10),
              left: ScreenUtil().setWidth(28),
              right: ScreenUtil().setWidth(28)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFF4A3D3D), width: 1),
          ),
          //  margin: EdgeInsets.only(top: ScreenUtil().setHeight(51)),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(

                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  child: Text(
                    "配网流程",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A3D3D),
                        fontSize: ScreenUtil().setSp(10)),
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                  alignment: Alignment.topLeft,
                  height: ScreenUtil().setHeight(220),
                  child:
                  HtmlWidget(this._html,
                      webView: true
                  ),

                ),
                Container(
                  child: Column(
                    children: [
                      new Container(
                        alignment: Alignment.bottomCenter,
                        color: Color(0xFFE6E6E6),
                        height: 1,
                      ),
                      FlatButton(
                          child: Text(
                            "进入配置",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4A3D3D),
                                fontSize: ScreenUtil().setSp(10)),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "devicewifi");
                          })
                    ],
                  ),
                ),
              ])),
    );
  }

  initData() async{
    ResultData response = await MiaoApi.getSetting("配网指引");
    if(response.code==200){
      setState(() {
        _html=response.data['data']['settingContent'];
      });
    }
  }

}
