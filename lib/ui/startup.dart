import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Startup extends StatefulWidget {
  @override
  _StartupState createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  var swiperDataList = ["assets/logo_startup.png"];
  var swiperTextList = ["assets/text_startup.png"];

  @override
  void initState() {
    super.initState();
    ScreenUtil.init(
        width: 750,
        height: 1334,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    super.initState();
  }

  ///状态栏样式-沉浸式状态栏

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,

        child:
            GestureDetector(
              child: _banner(context),
              onTap: ()=>{
                Navigator.pushNamed(context, "home")
              },

            )
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
        //设置背景图片
        decoration: new BoxDecoration(
          color: Colors.white,
          image: new DecorationImage(
            image: new AssetImage("assets/bg_startup.png"),
            fit:BoxFit.cover
            //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
          ),
        ),
        margin: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
         // children: [
            // Swiper(
            //   outer: false,
            //   itemBuilder: (c, i) {
            //     if (swiperDataList != null) {
            //       return Column(
            //         children: [
            //           SizedBox(
            //             height: 150,
            //           ),
            //           Image.asset(
            //             swiperDataList[i],
            //             fit: BoxFit.cover,
            //           //  scale: 1.6,
            //           ),
            //           SizedBox(
            //             height: 180,
            //           ),
            //           Image.asset(
            //             swiperTextList[i],
            //             fit: BoxFit.cover,
            //          //   scale: 1.6,
            //           )
            //         ],
            //       );
            //     }
            //     return null;
            //   },
            //   pagination: new SwiperPagination(
            //       alignment: Alignment.bottomCenter,
            //       margin: EdgeInsets.all(0),
            //       builder: DotSwiperPaginationBuilder(
            //         color: Colors.white,
            //         activeColor: Colors.deepOrangeAccent.shade200,
            //       )),
            //   itemCount: swiperDataList == null ? 0 : swiperDataList.length,
            //   autoplay: false,
            // ),
          // ],
        ));
  }
}
