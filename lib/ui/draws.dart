import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/htmlWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'editmine.dart';

class Drawers extends StatefulWidget {
  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  var _name = "";
  var _avatar = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Drawer(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(60),
              right: ScreenUtil().setWidth(60),
              top: ScreenUtil().setHeight(30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏
                  },
                  child: Image.asset("assets/img_logo.png",
                      width: ScreenUtil().setWidth(72.67),
                      height: ScreenUtil().setHeight(76.67)),
                ),

                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),

                ListTile(
                  title: new Center(
                    child: Text(
                      '消息通知',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏
                  },
                ),

                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ),
                ListTile(
                  title: new Center(
                    child: Text(
                      '通用设置',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏
                    Navigator.pushNamed(context, "commonsetting");
                  },
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ),
                ListTile(
                  title: new Center(
                    child: Text(
                      '个人信息',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏
                    Navigator.of(context)
                        .push(new MaterialPageRoute(builder: (_) {
                      return new EditMine();
                    })).then((value) async {
                      await initData();
                    });
                  },
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ), //分割线
                ListTile(
                  title: new Center(
                    child: Text(
                      '关于我们',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (content) {
                      return CustomerHtml(title: "关于我们");
                    }));
                  },
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ), //分割线
                ListTile(
                  title: new Center(
                    child: Text(
                      '帮助中心',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (content) {
                      return CustomerHtml(title: "帮助中心");
                    }));
                  },
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ), //分割线
                ListTile(
                  title: new Center(
                    child: Text(
                      '检查更新',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3D3D)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏

                    _showUpdate();
                  },
                ),
                Divider(
                  height: ScreenUtil().setHeight(1),
                  color: Colors.grey,
                ), //分割线
                ListTile(
                  title: new Center(
                    child: Text(
                      '退出登陆',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF28282)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(); //隐藏侧边栏

                    _showQuit();
                  },
                ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(20),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage("assets/ic_score.png"),
                      width: ScreenUtil().setWidth(9),
                      height: ScreenUtil().setHeight(7.67)),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  GestureDetector(
                    child: Text(
                      "评分",
                      style: TextStyle(color: Color(0xFF726868)),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(40),
                  ),
                  Image(
                      image: AssetImage("assets/ic_protocol.png"),
                      width: ScreenUtil().setWidth(9),
                      height: ScreenUtil().setHeight(7.67)),
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  GestureDetector(
                    child: Text(
                      "协议与规则",
                      style: TextStyle(color: Color(0xFF726868)),
                    ),
                    onTap: () {},
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void initData() async {
    var data = await SpUtils.getObjact(Config.USER);
    LoginEntity user = JsonConvert.fromJsonAsT(data);
    print("-----------------");
    setState(() {
      _name = user.data.user.name;
      _avatar = SpUtils.URL + user.data.user.avatar;
      print("--------+++++++++" + _name);
    });
  }

  _showQuit() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "正在退出登录?",
            message: "退出后无法使用完整功能",
            negativeText: "立即退出",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () async {
              try {
                ResultData response = await MiaoApi.logout();
                if (response != null) {
                  print("-----logout-------");
                  Navigator.pushNamedAndRemoveUntil(
                      context, "home", (route) => false);
                }
              } catch (e) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "home", (route) => false);
              }
            },
          );
        });
  }

  _showUpdate() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "当前已是最新版本",
            message: "版本号V1.9.1",
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
