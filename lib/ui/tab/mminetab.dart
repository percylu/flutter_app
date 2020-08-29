import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/editmine.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/htmlWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MiaoMine extends StatefulWidget {
  final reslut;
  MiaoMine({this.reslut});
  @override
  MiaoMineTabView createState() => MiaoMineTabView();

}

class MiaoMineTabView extends State<MiaoMine> {
  var _name = "";
  var _avatar = "";


  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 250,
        height: 445,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
//      margin: EdgeInsets.only(
//          //top: ScreenUtil().setHeight(11.33),
//          left: ScreenUtil().setWidth(6.67),
//          right: ScreenUtil().setWidth(6.67)),
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding:EdgeInsets.only(top:ScreenUtil().setHeight(20),bottom:ScreenUtil().setHeight(10)),
            child:Text("个人中心",style: TextStyle(fontSize: ScreenUtil().setSp(13),fontWeight: FontWeight.w500),)
          ),
          Container(
            height: 1,
            color: Colors.grey.shade100,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(8.67),
                bottom: ScreenUtil().setHeight(8.67)),
            child:
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${_name}  >",
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        width: ScreenUtil().setWidth(67.33),
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          height: ScreenUtil().setWidth(49.33),
                          width: ScreenUtil().setWidth(49.33),
                          imageUrl: "${_avatar}",
                          placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  onTap:(){
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (_) {
                          return new EditMine();
                        })
                    ).then((value) async{
                      await initData();

                    });

                  }
                ),

          ),
          GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                    left:ScreenUtil().setWidth(8),
                    right:ScreenUtil().setWidth(8)
                ),
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(10.67),
                bottom: ScreenUtil().setHeight(10.67)),
            alignment: Alignment.center,
            child: Text("消息通知",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(10),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF666666))),
          ),
            onTap: (){

            },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                  left:ScreenUtil().setWidth(8),
                  right:ScreenUtil().setWidth(8)
              ),

              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10.67),
                  bottom: ScreenUtil().setHeight(10.67)),
              alignment: Alignment.center,
              child: Text("通用设置",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){
              Navigator.pushNamed(context, "commonsetting");
            },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                  left:ScreenUtil().setWidth(8),
                  right:ScreenUtil().setWidth(8)
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10.67),
                  bottom: ScreenUtil().setHeight(10.67)),
              alignment: Alignment.center,
              child: Text("关于我们",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (content){
                    return CustomerHtml(title:"关于我们");
                  }));
              },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                  left:ScreenUtil().setWidth(8),
                  right:ScreenUtil().setWidth(8)
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10.67),
                  bottom: ScreenUtil().setHeight(10.67)),
              alignment: Alignment.center,
              child: Text("帮助中心",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (content){
                return CustomerHtml(title:"帮助中心");
              }));
            },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                  left:ScreenUtil().setWidth(8),
                  right:ScreenUtil().setWidth(8)
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10.67),
                  bottom: ScreenUtil().setHeight(10.67)),
              alignment: Alignment.center,
              child: Text("检查更新",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF666666))),
            ),
            onTap: (){
              _showUpdate();
            },
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(7),
                  left:ScreenUtil().setWidth(8),
                  right:ScreenUtil().setWidth(8)
              ),
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(10.67),
                  bottom: ScreenUtil().setHeight(10.67)),
              alignment: Alignment.center,
              child: Text("退出登录",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF28282))),
            ),
            onTap: () {
              _showQuit();
            },
          ),


        ],
      ),
    );
  }
  _showQuit(){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new     MessageDialog(
            title:"正在退出登录?", message:"退出后无法使用完整功能", negativeText:"立即退出",
            onCloseEvent: (){
              Navigator.pop(context);
            },
            onConfirmEvent: () async{
              try{
              ResultData response =   await MiaoApi.logout();
                  if(response!=null){
                    print("-----logout-------");
                    Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
                  }


              }catch(e){
                Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
              }

            },
          );

        });
  }

  _showUpdate(){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new     MessageDialog(
            title:"当前已是最新版本", message:"版本号V1.9.1", negativeText:"返回",
            onCloseEvent: (){
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );

        });
  }
  void initData() async{

      var data =await SpUtils.getObjact(Config.USER);
      LoginEntity user =JsonConvert.fromJsonAsT(data);
      print("-----------------");
      setState(() {
        _name = user.data.user.name;
        _avatar = SpUtils.URL+user.data.user.avatar;
        print("--------+++++++++"+_name);
      });



  }
}
