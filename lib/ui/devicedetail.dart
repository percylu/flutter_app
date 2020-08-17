import 'dart:convert';
import 'dart:io';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/utility/mqtt.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DeviceDetail extends StatefulWidget {
  final String deviceId;
  DeviceDetail({ Key key,  this.deviceId }) : super(key: key);
  @override
  _DeviceDetailState createState() => _DeviceDetailState();

}

class _DeviceDetailState extends State<DeviceDetail> {
  var index=0;
  var _workStatus="空闲中";
  var _network = "未连接";
  var _rubbish ="90%";
  var _percent=0.90;
  var topic;
  var deviceSn="";
  //MqttClient client = MqttClient('http://mqtt.miaotechnology.com', '1883');
  Mqtt client;
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    this.deviceSn=widget.deviceId;
    print("deviceID:--------");
    print(widget.deviceId);
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
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "设备详情",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(60),
              right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(39.99)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/ic_wifi.png",
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setHeight(47.01),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(32),
                      ),
                      Text(
                        "${_network}",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(90),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/bg_percentage.png",
                        width: ScreenUtil().setWidth(251.01),
                        height: ScreenUtil().setHeight(255),
                      ),
                      Text(
                        "75%",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(48),
                            color: Color(0xFF4A3D3D),
                            fontWeight: FontWeight.w900),
                      ),
                      Positioned(
                          top: ScreenUtil().setHeight(147),
                          child: Text(
                            "猫砂剩余",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(24),
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ))
                    ],
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(90),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/ic_working.png",
                        width: ScreenUtil().setWidth(60),
                        height: ScreenUtil().setHeight(47.01),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(32),
                      ),
                      Text(
                        "${_workStatus}",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                child: Text(
                  "垃圾仓储剩余",
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(30)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(261),
                height: ScreenUtil().setHeight(50),
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    left: ScreenUtil().setWidth(180),
                    right: ScreenUtil().setWidth(180)),
                decoration: BoxDecoration(
//                  image: DecorationImage(
//                      image: AssetImage("assets/bg_progress_bar.png"),
//                      fit: BoxFit.fill
//                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: LinearPercentIndicator(
                  //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                  alignment: MainAxisAlignment.center,
                  percent: _percent,
                  // width:ScreenUtil().setWidth(249),
                  lineHeight: ScreenUtil().setHeight(46),
                  animation: true,
                  animationDuration: 1000,
                  center: Text(
                    "${_rubbish}",
                    style: new TextStyle(
                        fontSize: ScreenUtil().setSp(30),
                        fontWeight: FontWeight.w600,
                        color: Color(0xff999999)),
                  ),
                  //背景颜色
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  backgroundColor: Colors.white,
                  progressColor: Colors.grey.shade300,
                  //进度颜色
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                child: Text(
                  "功能模式",
                  style: TextStyle(
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w800,
                      fontSize: ScreenUtil().setSp(39.99)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                child: Text(
                  "Function mode",
                  style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(21.99)),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(600),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(0)),
                child: GridView.count(
                  //水平子Widget之间间距
                  crossAxisSpacing: ScreenUtil().setWidth(20),
                  //垂直子Widget之间间距
                  mainAxisSpacing: ScreenUtil().setHeight(20),
                  //GridView内边距
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(60),
                      right: ScreenUtil().setWidth(60),
                      top: ScreenUtil().setHeight(30)),
                  //一行的Widget数量
                  crossAxisCount: 2,
                  //子Widget宽高比例
                  // childAspectRatio: 2.0,
                  //子Widget列表
                  children: [
                    GestureDetector(onTap: ()=>_checkFunction(1),child:Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(index==1 ? "assets/bg_mask_list.png":"assets/bg_qs.png"),
                        Positioned(
                          top: ScreenUtil().setHeight(60),
                          child: Image.asset(
                            index==1 ?
                            "assets/ic_shovel_on.png":
                            "assets/ic_shovel _off.png",
                            width: ScreenUtil().setWidth(60),
                            height: ScreenUtil().setHeight(60),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setHeight(140),
                          child: Text(
                            "一键铲屎",
                            style: TextStyle(
                                color: Color(index==1?0xffffffff:0xff666666),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )),
                    GestureDetector(onTap: ()=>_checkFunction(2),child:Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(index==2 ? "assets/bg_mask_list.png":"assets/bg_qs.png"),
                        Positioned(
                          top: ScreenUtil().setHeight(60),
                          child: Image.asset(
                            index==2 ?
                            "assets/ic_clean_on.png":
                            "assets/ic_clean_off.png",
                            width: ScreenUtil().setWidth(60),
                            height: ScreenUtil().setHeight(60),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setHeight(140),
                          child: Text(
                            "一键清砂",
                            style: TextStyle(
                                color: Color(index==2?0xffffffff:0xff666666),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )),
                    GestureDetector(onTap: ()=>_checkFunction(3),child:Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(index==3 ? "assets/bg_mask_list.png":"assets/bg_qs.png"),
                        Positioned(
                          top: ScreenUtil().setHeight(60),
                          child: Image.asset(
                            index==3 ?
                            "assets/ic_sleep_on.png":
                            "assets/ic_sleep_off.png",
                            width: ScreenUtil().setWidth(60),
                            height: ScreenUtil().setHeight(60),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setHeight(140),
                          child: Text(
                            "睡眠模式",
                            style: TextStyle(
                                color: Color(index==3?0xffffffff:0xff666666),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )),
                    GestureDetector(onTap: ()=>_checkFunction(4),child:Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset(index==4 ? "assets/bg_mask_list.png":"assets/bg_qs.png"),
                        Positioned(
                          top: ScreenUtil().setHeight(60),
                          child: Image.asset(
                            index==4 ?
                            "assets/ic_data_list_on.png":
                            "assets/ic_data_list_off.png",
                            width: ScreenUtil().setWidth(60),
                            height: ScreenUtil().setHeight(60),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setHeight(140),
                          child: Text(
                            "设备数据",
                            style: TextStyle(
                                color: Color(index==4?0xffffffff:0xff666666),
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )),


                  ],
                ),
              )
            ],
          )),
    );
  }
  _checkFunction(int i){

    switch(i){
      case 1:
        if(index==i){
          showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new     MessageDialog(
                  title:"准备停止一键铲💩", message:"型号A-2", negativeText:"确认停止",
                  onCloseEvent: (){
                    Navigator.pop(context);
                  },
                  onConfirmEvent: (){
                    publishMessage("{\"excreta:\"\"0\"}");
                    setState(() {
                      index=0;
                    });
                    Navigator.pop(context);
                  },);
              });
        }else{
          showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new     MessageDialog(
                  title:"准备启动一键铲💩", message:"型号A-2", negativeText:"确认启动",
                  onCloseEvent: (){
                    Navigator.pop(context);
                  },
                  onConfirmEvent: (){
                    publishMessage("{\"excreta:\"\"1\"}");
                    setState(() {
                      index=i;
                    });
                    Navigator.pop(context);
                  },);
              });
        }
        break;
      case 2:
        if(index==i){
          showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new     MessageDialog(
                  title:"准备停止一键清砂", message:"型号A-2", negativeText:"确认停止",
                  onCloseEvent: (){
                    Navigator.pop(context);
                  },
                  onConfirmEvent: (){
                    publishMessage("{\"sand:\"\"0\"}");
                    setState(() {
                      index=0;
                    });
                    Navigator.pop(context);
                  },);
              });
        }else{
          showDialog<Null>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return new     MessageDialog(
                  title:"准备启动一键清砂", message:"型号A-2", negativeText:"确认启动",
                  onCloseEvent: (){
                    Navigator.pop(context);
                  },
                  onConfirmEvent: (){
                    publishMessage("{\"sand:\"\"1\"}");
                    setState(() {
                      index=i;
                    });
                    Navigator.pop(context);
                  },);
              });
        }
        break;
      case 3:
        index=i;
        Navigator.pushNamed(context, "devicesleep");
        break;
      case 4:
        index=i;
        Navigator.pushNamed(context, "devicedata");
        break;
      default:

    }

  }
  initData() async{
    //client= Mqtt.getInstance('ws://39.108.96.5/mqtt',8083,widget.deviceId);
    client= Mqtt.getInstance("mqtt.miaotechnology.com",1883,"app_"+widget.deviceId);
    var connect=await client.connect();
    print(connect);
    client.mqttClient.autoReconnect=true;
    client.subscribe("mxx/"+widget.deviceId+"/cat");
      publishMessage('{"equipmentstatus:"}');
    client.mqttClient.updates.listen(listenMqtt);

  }
  listenMqtt(List<MqttReceivedMessage<MqttMessage>> data) {
    data.forEach((MqttReceivedMessage<MqttMessage> m) {
      final MqttPublishMessage recMess = m.payload;

      final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print("----");
      String str=pt.replaceAll(':"', '":').replaceAll('""', '","');
      Map json=jsonDecode(str);
      int count=json.length;
      if(count==7){
        //设备状态
        _network="已连接";
        if(json['sand']=="1"||json['excreta']=="1"){
          _workStatus="工作中";
        }else{
          _workStatus="空闲中";
        }
        switch(json['capacity']){
          case "0":
            _rubbish="100%";
            _percent=1.00;
            break;
          case "1":
            _rubbish="90%";
            _percent=0.90;
            break;
          case "2":
            _rubbish="50%";
            _percent=0.50;
            break;
          case "3":
            _rubbish="25%";
            _percent=0.25;

            break;
        }
        setState(() {

        });


      }else if(count==3){

        //主动上传
      }else{
        //其他
        print(json.keys.first);
        switch(json.keys.first){
          case "led":
            if(json.values.first=="1ok"){

            }else{

            }
            break;
          case "capacity":
            print(json.values.first);
            break;
          case "sand":
            index==2?index=0:index;
            if(json.values.first=="1ok"){

            }else{

            }
            break;
          case "excreta":
            index==1?index=0:index;
            if(json.values.first=="1ok"){

            }else{

            }
            break;
          case "shutdown":
            print(json.values.first);
            break;
          case "sleep":
            if(json.values.first=="1ok"){

            }else{

            }
            break;
        }
        setState(() {

        });
      }
      print(str);
    });
  }
  publishMessage(msg){
    client.publishMessage(msg,"mxx/"+widget.deviceId+"/web");
  }

  @override
  void dispose() {
    super.dispose();
    client.disconnect();
  }
}
