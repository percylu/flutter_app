import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart'
    as HandOverDutyDatePicker;
import 'package:flutter_screenutil/screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DeviceSleep extends StatefulWidget {
  @override
  _DeviceSleepState createState() => _DeviceSleepState();
}

class _DeviceSleepState extends State<DeviceSleep> {
  var index = 1;
  var check = false;
  List<String> _timer = new List();

  var _settime = "";

  @override
  void initState() {
    super.initState();
    initData();
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
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "睡眠模式",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(104.01),
              // right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  width: ScreenUtil().setWidth(555),
                  height: ScreenUtil().setHeight(537.99),
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(51)),
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(54),
                      left: ScreenUtil().setWidth(71.01),
                      right: ScreenUtil().setWidth(60.99)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF4A3D3D), width: 2),
                  ),
                  //  margin: EdgeInsets.only(top: ScreenUtil().setHeight(51)),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(
                      height: ScreenUtil().setHeight(350),
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      child: ListView.builder(
                          //padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(69.99)),
                          itemBuilder: (BuildContext context, int index) {
                            return _getRow(context, index);
                          },
                          itemCount: _timer.length),
                    ),
                    Container(
                      child: Column(
                        children: [
                          new Container(
                            alignment: Alignment.bottomCenter,
                            color: Color(0xFFE6E6E6),
                            height: 2,
                          ),
                          FlatButton(
                            child: Text(
                              "确认计划",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4A3D3D),
                                  fontSize: ScreenUtil().setSp(32)),
                            ),
                            onPressed: () {
                              if (_timer.length < 2) {
                                showDialog<Null>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return new MessageDialog(
                                        title: "没有添加项",
                                        message: "至少添加一项才能提交",
                                        negativeText: "确认",
                                        onCloseEvent: () {
                                          Navigator.pop(context);
                                        },
                                        onConfirmEvent: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              } else {
                                Navigator.pushNamed(context, "devicedetail");
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ]))
            ],
          )),
    );
  }

  Widget _getRow(BuildContext context, int index) {
    var list = _timer[index].split(",");
    var check = 0;
    var time = list[0];
    if (list.length > 1) {
      check = int.parse(list[1]);
    }
    return new GestureDetector(
      child: Container(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Row(
          children: [
            Image.asset(
              index == _timer.length - 1
                  ? "assets/ic_add_list.png"
                  : "assets/ic_del_list.png",
              width: ScreenUtil().setWidth(40.01),
              height: ScreenUtil().setHeight(40.01),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(36.99),
            ),
            Text(
              time,
              style: TextStyle(
                  color: Color(
                      index == _timer.length - 1 ? 0xffE6E6E6 : 0xFF4A3D3D),
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.w700),
            ),
            Visibility(
              visible: index == _timer.length - 1 ? false : true,
              child: Row(children: [
                SizedBox(
                  width: ScreenUtil().setWidth(70),
                ),
                Text(
                  "每天",
                  style: TextStyle(color: Color(0xFF4A3D3D)),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.only(left: 10),
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(20),
                  child: Checkbox(
                      value: check == 0 ? false : true,
                      activeColor: Color(0xFFAC8C8C),
                      onChanged: (bool val) {
                        check = check == 0 ? 1 : 0;
                        setState(() {
                          _timer[index] = list[0] + "," + check.toString();
                        });
                      }),
                ),
              ]),
            ),
          ],
        ),
      ),
      onTap: () {
        print("delte plan");
        setState(() {
          if (index == _timer.length - 1) {
            _showTimePicker(context);
          } else {
            _timer.removeAt(index);
          }
        });
      },
    );
  }

  _showTimePicker(BuildContext context) {
    var _startHours = "00";
    var _startMin = "00";
    var _endHours = "00";
    var _endMin = "00";
    _settime = "";
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
            height: ScreenUtil().setHeight(500),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    NumberPicker.integer(
                        listViewWidth: ScreenUtil().setWidth(120),
                        initialValue: 0,
                        itemExtent: 50,
                        infiniteLoop: false,
                        zeroPad: true,
                        minValue: 0,
                        maxValue: 23,
                        onChanged: (hours) {
                          _startHours = hours < 10
                              ? "0" + hours.toString()
                              : hours.toString();
                        }),
                    Text("时"),
                    NumberPicker.integer(
                        listViewWidth: ScreenUtil().setWidth(120),
                        initialValue: 0,
                        zeroPad: true,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (minute) {
                          _startMin = minute < 10
                              ? "0" + minute.toString()
                              : minute.toString();
                        }),
                    Text("分"),
                    Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(60)),
                        child: Text("至")),
                    NumberPicker.integer(
                        listViewWidth: ScreenUtil().setWidth(120),
                        initialValue: 0,
                        zeroPad: true,
                        minValue: 0,
                        maxValue: 23,
                        onChanged: (hours) {
                          _endHours = hours < 10
                              ? "0" + hours.toString()
                              : hours.toString();
                        }),
                    Text("时"),
                    NumberPicker.integer(
                        listViewWidth: ScreenUtil().setWidth(120),
                        initialValue: 0,
                        zeroPad: true,
                        minValue: 0,
                        maxValue: 59,
                        onChanged: (minute) {
                          print(minute);
                          _endMin = minute < 10
                              ? "0" + minute.toString()
                              : minute.toString();
                        }),
                    Text("分"),
                  ],
                ),
                RaisedButton(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(200),
                      right: ScreenUtil().setWidth(200)),
                  color: Color(0xFF4A3D3D),
                  child: Text(
                    "确定",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      _settime = _startHours +
                          ":" +
                          _startMin +
                          "-" +
                          _endHours +
                          ":" +
                          _endMin +
                          ",0";
                      String tmp = _timer.removeLast();
                      _timer.add(_settime);
                      _timer.add(tmp);
                    });
                    print(_settime);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }

  initData() {
    setState(() {
      _timer.add("添加计划");
    });
  }
}
