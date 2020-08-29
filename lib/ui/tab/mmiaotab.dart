import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/entity/pet_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../miaodetail.dart';

class MiaoMain extends StatefulWidget {
  @override
  _MiaoMainTabView createState() => _MiaoMainTabView();
}

class _MiaoMainTabView extends State<MiaoMain>{
  PetEntity items = null;
  int _current = 0;
  var listFlag;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: <Widget>[
          _banner(context),
          _name(),
          _img(),
        ],
      ),
    );
  }

  Widget _img() {
    var arr = [];
    if(items!=null) {
      if (items.data.length != 0) {
        arr = items.data[_current].imgurls.split(",");
      }
    }
    return
      Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(200.33),
        height: ScreenUtil().setHeight(143.67),
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(26),
            left: ScreenUtil().setWidth(15),
            right: ScreenUtil().setWidth(15)),
        child: arr.length == 0
            ? Text("还没有设置宠物图片")
            : new ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Swiper(
                  key:UniqueKey(),
                  outer: false,
                  viewportFraction: 1,
                  itemBuilder: (c, i) {
                    return CachedNetworkImage(
                      width: ScreenUtil().setWidth(114.67),
                      height: ScreenUtil().setWidth(114.67),
                      imageUrl: "${SpUtils.URL + arr[i]}",
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.cover,
                    );

                    return null;
                  },
                  itemCount: arr.length,
                  autoplay: false,
                ),
              ));
  }

  Widget _name() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              items==null?"宠物名字":items.data[_current].name,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(19.33),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              items==null?"品种":items.data[_current].type,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12), color: Color(0xFF999999)),
            )
          ],
        ),
        SizedBox(
          width: ScreenUtil().setWidth(7.67),
        ),
        Container(
          height: ScreenUtil().setHeight(30),
          width: 1,
          color: Color(0xff999999),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(7.67),
        ),
        GestureDetector(
          child: Image.asset(
            "assets/ic_list.png",
            width: ScreenUtil().setWidth(13),
            height: ScreenUtil().setHeight(13),
          ),
          onTap: () {
            Navigator.pushNamed(context, "petlist");
          },
        ),
        listFlag == null
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 3),
                child: Text(
                  "切换为列表显示",
                  style: TextStyle(fontSize: ScreenUtil().setSp(8)),
                ),
                height: ScreenUtil().setHeight(20),
                width: ScreenUtil().setWidth(70),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: Image.asset(
                    "assets/bg_list_tip.png",
                  ).image,
                )),
              )
            : Text("")
      ],
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(24.67),
          bottom: ScreenUtil().setHeight(21)),
      width: ScreenUtil().setWidth(250),
      height: ScreenUtil().setHeight(114.67),
      child: items==null?
           Container(
             alignment: Alignment.center,
             child:Text("还没有宠物...",style: TextStyle(fontSize: ScreenUtil().setSp(12),fontWeight: FontWeight.w500),)
           )

          :Swiper(
        outer: false,
        onTap: (i) {
//          Navigator.pushNamed(context, "miaodetail");
          Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
            return new MiaoDetail(petId: i);
          }));
        },
        viewportFraction: 0.5,
        scale: 0.1,
        onIndexChanged: (i) {
          setState(() {
            _current = i;
          });
        },
        itemBuilder: (c, i) {
          if (items != null) {
            var imgs= items.data[i].imgurls.split(",");
            return Stack(
              children: [
                ClipOval(
                    child: CachedNetworkImage(
                  width: ScreenUtil().setWidth(114.67),
                  height: ScreenUtil().setWidth(114.67),
                  imageUrl: imgs.length>0?"${SpUtils.URL+imgs[0]}":null,
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.cover,
                )),
                Positioned(
                  bottom: ScreenUtil().setHeight(15),
                  right: ScreenUtil().setWidth(25),
                  child: Image.asset(
                    items.data[i].sexy == 0
                        ? "assets/ic_symbol_man.png"
                        : "assets/ic_symbol_woman.png",
                    width: ScreenUtil().setWidth(20.33),
                    height: ScreenUtil().setHeight(20.33),
                  ),
                )
              ],
            );
          }
          return null;
        },
        itemCount: items == null ? 0 : items.data.length,
        autoplay: false,
      ),
    );
  }

  initData() async {
    items:
    //List<Map<String, String>>.generate(3, (index) => "Item$index")
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    ResultData response = await MiaoApi.getPetList(user.data.user.userId);
    if (response.code != 200) {
      _showError("获取数据错误", response.message);
      return;
    }
    listFlag = await SpUtils.get(Config.LISTFLAG);
    if (listFlag == null) {
      await SpUtils.save(Config.LISTFLAG, "1");
    }
    items = JsonConvert.fromJsonAsT(response.data);
    if(items.data.isEmpty){
      items=null;
    }
    setState(() {
   });

  }

  _showError(String title, String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: title,
            message: msg,
            negativeText: "返回",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );
        });
  }

}
