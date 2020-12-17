/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/widget/miaotabs.dart';
import 'package:flutter_screenutil/screenutil.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var _ismessage = false;
  var _ispush = false;
  var _isfault = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
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
            // Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            //   return new HomePage(index: 3);
            // }));
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "通知",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(ScreenUtil().setWidth(20)),

              child: MiaoTabBar(
                onTap: (int index) {
                  setState(() {
                    print(tabController.index);
                  });
                },
                indicator: const BoxDecoration(),
                tabs: [
                  MiaoTab(
                    child: Column(
                      children: [
                        Image.asset(
                          tabController.index == 0
                              ? "assets/icon_message_pressed@3x.png"
                              : "assets/icon_message@3x.png",
                          width: ScreenUtil().setWidth(30.67),
                          height: ScreenUtil().setWidth(30.67),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(3),
                        ),
                        Text(
                          "消息",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(10)),
                        )
                      ],
                    ),
                  ),
                  MiaoTab(
                    child: Column(
                      children: [
                        Image.asset(
                          tabController.index == 1
                              ? "assets/icon_push_pressed@3x.png"
                              : "assets/icon_push@3x.png",
                          width: ScreenUtil().setWidth(30.67),
                          height: ScreenUtil().setWidth(30.67),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(3),
                        ),
                        Text(
                          "推送",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(10)),
                        )
                      ],
                    ),
                  ),
                  MiaoTab(
                    child: Column(
                      children: [
                        Image.asset(
                          tabController.index == 2
                              ? "assets/icon_fault_pressed@3x.png"
                              : "assets/icon_fault@3x.png",
                          width: ScreenUtil().setWidth(30.67),
                          height: ScreenUtil().setWidth(30.67),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(3),
                        ),
                        Text(
                          "故障",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: ScreenUtil().setSp(10)),
                        )
                      ],
                    ),
                  ),
                ],
                controller: tabController,
              ),
            ),
            Container(
                height: ScreenUtil().setHeight(200),
                child: MiaoTabBarView(
                  children: [
                    Center(
                      child: _builderContent(0),
                    ),
                    Center(
                      child: _builderContent(1),
                    ),
                    Center(
                      child: _builderContent(2),
                    ),
                  ],
                  controller: tabController,
                ))
          ],
        ),
      ),
    );
  }

  initData() {
    tabController = TabController(length: 3, vsync: this);
    setState(() {});
  }
}

Widget _builderContent(int index) {
  List _title = ["新的粉丝", "苗总", "苗总"];
  List _items = ["喵总、崽崽等5个用户关注了您...", "回复了您的动态", "回复了您的动态"];
  List _isfollow = [true, false, false];
  return ListView.builder(
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(8),
            left: ScreenUtil().setHeight(8),
            right: ScreenUtil().setHeight(8)),
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(45),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(5),right:ScreenUtil().setWidth(10),left:ScreenUtil().setWidth(10)),
        decoration: BoxDecoration(
          color: _isfollow[index] ? Colors.white : null,
          // border: _isfollow[index]?null:Border.all(color: Colors.black12, width: 1),
          boxShadow: _isfollow[index]
              ? [
                  BoxShadow(
                      color: Colors.black12,
                      //offset: Offset(1.0, 1.0), //阴影xy轴偏移量
                      blurRadius: 1.0, //阴影模糊程度
                      spreadRadius: 0.0 //阴影扩散程度
                      ),
                ]
              : [],
          borderRadius: BorderRadius.circular(19),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(_title[index]),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(3),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width:ScreenUtil().setWidth(160),
                      child: Text(
                        _items[index],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Text("2020/10/23",
                            style: TextStyle(color: Colors.grey)))
                  ],
                )),
            _isfollow[index]
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                    height: 1,
                    color: Colors.grey.shade200)
          ],
        ),
      );
    },
    itemCount: _items.length,
  );
}
