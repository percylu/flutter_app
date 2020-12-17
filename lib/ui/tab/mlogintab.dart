import 'dart:convert';
import 'dart:io';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/authregister.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/htmlWidget.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/picandtextbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class MiaoLogin extends StatefulWidget {
  @override
  MiaoLoginTabView createState() => MiaoLoginTabView();
}

class MiaoLoginTabView extends State<MiaoLogin> {
  var check = false;

  @override
  void initState() {
    super.initState();
    ShareSDKRegister register = ShareSDKRegister();
    register.setupWechat("wx7daceaf591fc4702",
        "18d7cf5e66c72a68e2108841657cfc7a", "https://s8pp5.share2dlink.com/");
    register.setupSinaWeibo("3668326470", "f3a4148200798f57d6acba7cd76f12c6",
        "http://www.sharesdk.cn");
    register.setupQQ("1110606125", "VktFEVFqiXtXv1VN");
    SharesdkPlugin.regist(register);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 250,
        height: 445,
        allowFontScaling: true); //flutter_screenuitl >= 1.2
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      overflow: Overflow.visible,
      children: [
        new Positioned(
          top: ScreenUtil().setHeight(110),
          child: Image.asset("assets/bg_landing.png",
              width: ScreenUtil().setWidth(133.33),
              height: Platform.isIOS?ScreenUtil().setHeight(190.67):ScreenUtil().setHeight(165.67),
              fit: BoxFit.fill),
        ),
        new Positioned(
          top: ScreenUtil().setHeight(25),
          child: Image.asset("assets/img_cat.png",
              width: ScreenUtil().setWidth(105.33),
              height: ScreenUtil().setHeight(112.67)),
        ),
        new Positioned(
            top: ScreenUtil().setHeight(310.33),
            // left: ScreenUtil().setHeight(150),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                new Container(
                  child: new Checkbox(
                      value: this.check,
                      activeColor: Color(0xFFAC8C8C),
                      onChanged: (bool val) {
                        setState(() {
                          this.check = val;
                        });
                      }),
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new Text(
                    "同意",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(8),
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (content) {
                        return CustomerHtml(title: "许可协议");
                      }));
                    },
                    child: new Text(
                      "《许可协议》",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(8),
                          color: Color(0xFFAC8C8C),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                new Container(
                  padding: EdgeInsets.all(0.0),
                  margin: EdgeInsets.all(0.0),
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (content) {
                        return CustomerHtml(title: "隐私政策");
                      }));
                    },
                    child: new Text(
                      "《隐私政策》",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(8),
                          color: Color(0xFFAC8C8C),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )),
        new Positioned(
            top: ScreenUtil().setHeight(135),
            child: picAndTextButton("assets/btn_sign@3x.png", "手机号登陆", () {
              if (!check) {
                showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new MessageDialog(
                          title: "请先勾选同意",
                          message: "《许可协议》《隐私政策》",
                          negativeText: "返回同意",
                          onConfirmEvent: () {
                            Navigator.pop(context);
                          },
                          onCloseEvent: () {
                            Navigator.pop(context);
                          });
                    });
                return;
              }
              Navigator.pushNamed(context, 'mobileLogin');
            })),
        new Positioned(
            top: ScreenUtil().setHeight(165),
            child: picAndTextButton("assets/btn_qq@3x.png", "QQ登陆", () {
              if (!check) {
                showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new MessageDialog(
                          title: "请先勾选同意",
                          message: "《许可协议》《隐私政策》",
                          negativeText: "返回同意",
                          onConfirmEvent: () {
                            Navigator.pop(context);
                          },
                          onCloseEvent: () {
                            Navigator.pop(context);
                          });
                    });
                return;
              }
              SharesdkPlugin.getUserInfo(ShareSDKPlatforms.qq,
                  (SSDKResponseState state, Map user, SSDKError error) async {
                showAlert(state, user != null ? user : error.rawData, context);
                print(user);
                var authUser = "";
                if (Platform.isAndroid) {
                  var qqUser = user["dbInfo"];
                  authUser = jsonDecode(qqUser)["userID"];
                } else {
                  authUser = user["uid"];
                }
                ResultData response = await MiaoApi.thirdauth(authUser, "qq");
                if (response != null && response.success) {
                  print(response.code);
                  if (response.code == 201) {
                    //登陆成功
                    LoginEntity user = JsonConvert.fromJsonAsT(response.data);
                    print("user:-------------");
                    print(user.data.user.name);
                    SpUtils.set(Config.USER, user);
                    Navigator.pushNamed(context, 'home');
                  }
                  if (response.code == 202) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (content) {
                      return AuthRegister(type: "qq", authuser: authUser);
                    }));
                  }
                } else {}
              });
            })),
        new Positioned(
            top: ScreenUtil().setHeight(195),
            child: picAndTextButton("assets/btn_weixin@3x.png", "微信登陆", () {
              if (!check) {
                showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new MessageDialog(
                          title: "请先勾选同意",
                          message: "《许可协议》《隐私政策》",
                          negativeText: "返回同意",
                          onConfirmEvent: () {
                            Navigator.pop(context);
                          },
                          onCloseEvent: () {
                            Navigator.pop(context);
                          });
                    });
                return;
              }
              SharesdkPlugin.getUserInfo(ShareSDKPlatforms.wechatSession,
                  (SSDKResponseState state, Map user, SSDKError error) async {
                showAlert(state, user != null ? user : error.rawData, context);
                print(user);
                var authUser = "";
                if (Platform.isAndroid) {
                  var weixinUser = user["dbInfo"];
                  authUser = jsonDecode(weixinUser)["userID"];
                } else {
                  authUser = user["uid"];
                }
                ResultData response =
                    await MiaoApi.thirdauth(authUser, "weixin");
                if (response != null && response.success) {
                  print(response.code);
                  if (response.code == 201) {
                    //登陆成功
                    LoginEntity user = JsonConvert.fromJsonAsT(response.data);
                    print("user:-------------");
                    print(user.data.user.name);
                    SpUtils.set(Config.USER, user);
                    Navigator.pushNamed(context, 'home');
                  }
                  if (response.code == 202) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (content) {
                      return AuthRegister(type: "weixin", authuser: authUser);
                    }));
                  }
                } else {}
              });
            })),
        new Positioned(
            top: ScreenUtil().setHeight(225),
            child: picAndTextButton("assets/btn_weibo@3x.png", "微博登陆", () {
              if (!check) {
                showDialog<Null>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return new MessageDialog(
                          title: "请先勾选同意",
                          message: "《许可协议》《隐私政策》",
                          negativeText: "返回同意",
                          onConfirmEvent: () {
                            Navigator.pop(context);
                          },
                          onCloseEvent: () {
                            Navigator.pop(context);
                          });
                    });
                return;
              }
              SharesdkPlugin.getUserInfo(ShareSDKPlatforms.sina,
                  (SSDKResponseState state, Map user, SSDKError error) async {
                showAlert(state, user != null ? user : error.rawData, context);
                var authUser;
                if (Platform.isAndroid) {
                  var weiboUser = user["dbInfo"];
                  authUser = jsonDecode(weiboUser)["userID"];
                } else {
                  authUser = user["uid"];
                }

                ResultData response =
                    await MiaoApi.thirdauth(authUser, "weibo");
                if (response != null && response.success) {
                  print(response.code);
                  if (response.code == 201) {
                    //登陆成功
                    LoginEntity user = JsonConvert.fromJsonAsT(response.data);
                    print("user:-------------");
                    print(user.data.user.name);
                    SpUtils.set(Config.USER, user);
                    Navigator.pushNamed(context, 'home');
                  }
                  if (response.code == 202) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (content) {
                      return AuthRegister(type: "weibo", authuser: authUser);
                    }));
                  }
                } else {}
              });
            })),
        new Positioned(
            top: ScreenUtil().setHeight(255),
            child:
    Visibility(
    visible: Platform.isIOS ? true : false,
    child:
    picAndTextButton("assets/icon_apple@3x.png", "", () {
      if (!check) {
        showDialog<Null>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return new MessageDialog(
                  title: "请先勾选同意",
                  message: "《许可协议》《隐私政策》",
                  negativeText: "返回同意",
                  onConfirmEvent: () {
                    Navigator.pop(context);
                  },
                  onCloseEvent: () {
                    Navigator.pop(context);
                  });
            });
        return;
      }
      SharesdkPlugin.getUserInfo(ShareSDKPlatforms.apple,
              (SSDKResponseState state, Map user, SSDKError error) async {
            showAlert(state, user != null ? user : error.rawData, context);
            print(user);
            var authUser = "";
            authUser = user["uid"];

            ResultData response =
            await MiaoApi.thirdauth(authUser, "apple");
            if (response != null && response.success) {
              print(response.code);
              if (response.code == 201) {
                //登陆成功
                LoginEntity user = JsonConvert.fromJsonAsT(response.data);
                print("user:-------------");
                print(user.data.user.name);
                SpUtils.set(Config.USER, user);
                Navigator.pushNamed(context, 'home');
              }
              if (response.code == 202) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (content) {
                  return AuthRegister(type: "apple", authuser: authUser);
                }));
              }
            } else {}
          });
    })
    ))

      ],
    );
  }

  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
        break;
      case SSDKResponseState.Fail:
        title = "失败";
        break;
      case SSDKResponseState.Cancel:
        title = "取消";
        break;
      default:
        title = state.toString();
        break;
    }
  }
}
