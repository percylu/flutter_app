import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/model/miaoBean.dart';
import 'package:flutter_app/widget/picandpicbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MiaoMain extends StatefulWidget {
  @override
  _MiaoMainTabView createState() => _MiaoMainTabView();
}

class _MiaoMainTabView extends State<MiaoMain> {
  miaoBean items = null;

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
        ],
      ),
    );
  }

  Widget _buildCategoryRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: ScreenUtil().setHeight(220),
      child: Row(
        children: <Widget>[
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_first@3x.png", "assets/words_msp@3x.png", () {
              Navigator.pushNamed(context, "devicelist");
            }),
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_second@3x.png", "assets/words_ysj@3x.png", () {
              Navigator.pushNamed(context, "comming");
            }),
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_third@3x.png", "assets/words_wsq@3x.png", () {
              Navigator.pushNamed(context, "comming");
            }),
          ),
        ],
      ),
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
        viewportFraction: 0.5,
        scale: 0.1,
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
                  fit: BoxFit.fill,
                )),
                Positioned(bottom: ScreenUtil().setHeight(10),right: ScreenUtil().setWidth(25),child:
                  Icon(Icons.man,size: 32,color: Colors.black54,)
                  ,)
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

  Widget _buildCenterPic(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            GestureDetector(
                onTap: () {
                  print("news");
                },
                child: FadeInImage.assetNetwork(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setHeight(242.01),
                  placeholder: "assets/img_cat.png",
                  image:
                      "https://img1.360buyimg.com/da/jfs/t1/132819/32/4365/158541/5f0d0a3fEd1a401c7/4741c28e0753541c.jpg!q70.jpg",
                  fit: BoxFit.fill,
                )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 25,
                padding: EdgeInsets.only(left: 10, top: 2),
                decoration: BoxDecoration(color: Color(0x8c000000)),
                child: Text(
                  "救命！！我在这群沙雕猫中出不去了",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  initData() {
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
          "bigImg":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098914&di=9f046b001b45d25e2db21fb4e3b80c35&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F521%2Fw1056h1065%2F20181211%2Feb2b-hqackaa2812377.jpg",
        },
        {
          "id": 2,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg",
          "name": "zaizai",
          "nickName": "美短猫",
          "bigImg":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=cc436ce63717fd04cdf922484ace38b7&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2F902397dda144ad34bc9ecc61daa20cf431ad8537.jpg",
        },
        {
          "id": 3,
          "imgUrl":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0",
          "name": "zaizai",
          "nickName": "美短猫",
          "bigImg":
              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1595792098913&di=fab70c861578940b00b55c0f808a93e7&imgtype=0&src=http%3A%2F%2Fpic6.58cdn.com.cn%2Fzhuanzh%2Fn_v2ed4fc8bbfb3e4f5fa12ae084cb8a7864.jpg%3Fw%3D750%26h%3D0",
        },
      ],
      "msg": "请求成功"
    });
    //setState(() {});
  }
}
