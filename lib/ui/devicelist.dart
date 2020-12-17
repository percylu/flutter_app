/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/device_entity.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/devicedetail.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/devicelistwidgit.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'devicedata.dart';

class DeviceList extends StatefulWidget {
  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  DeviceEntity mData;
  var _futureBuilderFuture;

  @override
  void initState() {
    super.initState();
    _futureBuilderFuture = initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1335, allowFontScaling: true);
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
            //Navigator.pushNamed(context, "home");
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "设备列表",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body:
      RefreshIndicator(
        onRefresh: initData,
        child: FutureBuilder(
          builder: DeviceList,
          future: _futureBuilderFuture,
        ),
      ),
    );
  }

  Widget DeviceList(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _createListView(context, snapshot);
      default:
        return Text('还没有开始网络请求');
    }
  }

  Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
    DeviceEntity item = snapshot.data;
    return Stack(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(800),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => _itemBuilder(context, index, item),
            itemCount: item==null?0:item.data.length,
          ),
        ),
        Container(
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(550),
            height: ScreenUtil().setHeight(200),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(850),
                left: ScreenUtil().setWidth(100),
                right: ScreenUtil().setWidth(100)),
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(60),
                right: ScreenUtil().setWidth(60),
                top: ScreenUtil().setHeight(10),
                bottom: ScreenUtil().setHeight(10)),
            child: RaisedButton(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
              color: new Color(0xFFF28282),
              onPressed: () {
                Navigator.pushNamed(context, 'devicelink');
                //Navigator.pushNamed(context, 'devicescan');
              },
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("添加机器",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/ic_scan@3x.png",
                      scale: 2,
                    )
                  ]),
            ))
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index, item) {
    return DeviceListWidget(
        SpUtils.URL + item.data[index].imgUrl,
        item.data[index].color,
        item.data[index].type,
        () => _onPlay(index),
        () => _onClose(index));
  }

  _onPlay(int index) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new DeviceDetail(deviceId: mData.data[index].deviceSn,deviceType:mData.data[index].type);
    }));
  }

  _onClose(int index) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "确认删除该设备吗?",
            message: "${mData.data[index].type}",
            negativeText: "确认删除",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () async {
              // 删除设备
              ResultData response =
                  await MiaoApi.deviceDelete(mData.data[index].deviceId);
              if (response.code == 200) {
                setState(() {
                  mData.data.removeAt(index);
                });
              }

              Navigator.pop(context);
            },
          );
        });
  }

  Future initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    ResultData response = await MiaoApi.deviceListByUser(user.data.user.userId);
    if (response.data['code'] == 200) {
      return mData = JsonConvert.fromJsonAsT(response.data);

      print(mData.data.length);
    } else if (response.data['code'] == 1502) {
      Navigator.pushReplacementNamed(context, "home");
    }
    return null;
  }

}
