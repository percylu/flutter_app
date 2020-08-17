import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/editpet.dart';
import 'package:flutter_app/ui/petdata.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiaoDetail extends StatelessWidget {
  final petId;
  MiaoDetail({this.petId});
  ///状态栏样式-沉浸式状态栏
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: <Widget>[
              _banner(context),
              _content(context),
            ],
          ),
        ));
  }

  Widget _banner(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0",
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          fit: BoxFit.fill,
        ),
        Positioned(
          top: ScreenUtil().setHeight(9),
          left: ScreenUtil().setWidth(20),
          child: IconButton(
            icon: Image.asset(
              "assets/ic_back.png",
              width: 12,
              height: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: ScreenUtil().setHeight(204),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().setHeight(30),
            // color: Colors.black45,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(20.67),
          left: ScreenUtil().setWidth(36.33),
          right: ScreenUtil().setWidth(26.67)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  "鳌拜",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w700,
                      color: Color(0xff4A3D3D)),
                ),
                Text(
                  "(AOBAI)",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.w700,
                      color: Color(0xff4A3D3D)),
                )
              ]),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(8.67),
                    bottom: ScreenUtil().setHeight(11.67)),
                width: ScreenUtil().setWidth(40),
                height: ScreenUtil().setHeight(1),
                color: Color(0xFF999999),
              ),
              Row(
                children: [
                  Text(
                    "品种：",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                  Text(
                    "布偶",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(18),
              ),
              Row(
                children: [
                  Text(
                    "年龄：",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                  Text(
                    "2岁",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(18),
              ),
              Row(
                children: [
                  Text(
                    "体重：",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                  Text(
                    "10kg",
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(10),
                        fontWeight: FontWeight.w700,
                        color: Color(0xff333333)),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            width: ScreenUtil().setWidth(31.33),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/ic_data_pet.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                        ),
                        Text(
                          "数据",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              color: Color(0xff666666)),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                        return new PetData(petId: this.petId);
                      }));
                    },
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/ic_set_pet.png",
                          width: ScreenUtil().setWidth(25),
                          height: ScreenUtil().setHeight(25),
                        ),
                        Text(
                          "设置",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(10),
                              color: Color(0xff666666)),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
                        return new EditPet(petId: this.petId);
                      }));
                    },
                  ),

                  //IconButton(),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(60.67),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/ic_previous.png",width: ScreenUtil().setWidth(25),height: ScreenUtil().setHeight(25),),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset("assets/ic_next.png",width: ScreenUtil().setWidth(25),height: ScreenUtil().setHeight(25),),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
