import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/model/miaoBean.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../miaodetail.dart';

class MiaoMain extends StatefulWidget {
  @override
  _MiaoMainTabView createState() => _MiaoMainTabView();
}

class _MiaoMainTabView extends State<MiaoMain> {
  miaoBean items = null;
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
    return Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(200.33),
        height: ScreenUtil().setHeight(143.67),
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(26),
            left:ScreenUtil().setWidth(15),
        right:ScreenUtil().setWidth(15)),
        child: new ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Swiper(
            outer: false,
            viewportFraction: 1,
            itemBuilder: (c, i) {
              if (items.data != null) {
                return CachedNetworkImage(
                  width: ScreenUtil().setWidth(114.67),
                  height: ScreenUtil().setWidth(114.67),
                  imageUrl: "${items.data[i].imgUrl}",
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.cover,
                );
              }
              return null;
            },
            itemCount: items.data == null ? 0 : items.data.length,
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
              items.data[_current].name,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(19.33),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              items.data[_current].nickName,
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
      child: Swiper(
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
          if (items.data != null) {
            return Stack(
              children: [
                ClipOval(
                    child: CachedNetworkImage(
                  width: ScreenUtil().setWidth(114.67),
                  height: ScreenUtil().setWidth(114.67),
                  imageUrl: "${items.data[i].imgUrl}",
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  fit: BoxFit.cover,
                )),
                Positioned(
                  bottom: ScreenUtil().setHeight(10),
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
        itemCount: items.data == null ? 0 : items.data.length,
        autoplay: false,
      ),
    );
  }

  initData() async {
    items:
    //List<Map<String, String>>.generate(3, (index) => "Item$index")
    items = miaoBean.fromJson({
      "code": 0,
      "count": 3,
      "data": [
        {
          "id": 1,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098914&di=9f046b001b45d25e2db21fb4e3b80c35&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F521%2Fw1056h1065%2F20181211%2Feb2b-hqackaa2812377.jpg",
          "name": "zaizai",
          "nickName": "美短猫",
          "birth": "10.1",
          "weight": "20",
          "sexy": 0,
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098914&di=9f046b001b45d25e2db21fb4e3b80c35&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F521%2Fw1056h1065%2F20181211%2Feb2b-hqackaa2812377.jpg"
          ]
        },
        {
          "id": 2,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg",
          "name": "GiGi",
          "nickName": "小喵喵",
          "birth": "10.1",
          "weight": "20",
          "sexy": 0,
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg"
          ]
        },
        {
          "id": 3,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0",
          "name": "Pitgi",
          "nickName": "鼻涕狗",
          "birth": "10.1",
          "weight": "20",
          "sexy": 1,
          "bigImg": [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0"
          ]
        }
      ],
      "msg": "请求成功"
    });

    listFlag = await SpUtils.get(Config.LISTFLAG);

    print(listFlag);
    if (listFlag == null) {
      await SpUtils.save(Config.LISTFLAG, "1");
    }
    setState(() {});
  }
}
