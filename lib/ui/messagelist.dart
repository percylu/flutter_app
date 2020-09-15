/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {

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
            Navigator.pushNamed(context, "home");
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "通知",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body:
       Container(

       ),
    );
  }

  Future initData(){

    return null;
  }

}
