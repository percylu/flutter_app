import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class Article extends StatelessWidget{
  Article({this.title,this.html});
  final String html;
  final String title;

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
              "${title}",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.all(0),
//        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
//        width: MediaQuery
//            .of(context)
//            .size
//            .width,
//        alignment: Alignment.topCenter,
        child:
        HtmlWidget(this.html,
          webView: true
        ),
      ),

    );
  }
}
