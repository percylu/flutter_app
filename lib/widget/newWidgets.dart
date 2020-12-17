import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NewsHtml extends StatefulWidget {
  NewsHtml({this.content});
  final content;
  @override
  _NewsHtml createState() => _NewsHtml();
}

class _NewsHtml extends State<NewsHtml>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 250,
        height: 445,
        allowFontScaling: true);
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
          },
        ),
        backgroundColor: Colors.white,
            title: Text(
              "文章详情",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.all(15),
//        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
//        width: MediaQuery
//            .of(context)
//            .size
//            .width,
//        alignment: Alignment.topCenter,
        child:
        HtmlWidget(widget.content,
          webView: true
        ),
      ),

    );
  }


}
