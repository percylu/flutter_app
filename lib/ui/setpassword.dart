import 'dart:async';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  var passwordController = new TextEditingController();
  var confirmpasswordController = new TextEditingController();
  var _ishide = true;
  var errmsg="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "设置密码",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: 100,
              ),
              Image.asset(
                "assets/login_img_micromew@3x.png",
                scale: 1.5,
              ),
              Card(
                margin:
                    EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 10),
                elevation: 2,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child:
                TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            hintText: "输入密码",
                            hintStyle: TextStyle(
                              color: Colors.black26,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 16.0)),
                      ),

              ),
              Offstage(
                  offstage: _ishide,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      errmsg,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )),
              Card(
                margin: EdgeInsets.only(left: 60, top: 10, right:60,bottom: 10),
                elevation: 2,
                shape: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                      hintText: "确认密码",
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0)),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 60.0, right: 60, top: 10.0, bottom: 90.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: new Color(0xFFE97179),
                  onPressed: () {
                    if(passwordController.text!=confirmpasswordController.text){
                      print(passwordController.text);
                      print(confirmpasswordController.text);
                      setState(() {
                        _ishide=false;
                        errmsg="输入两次密码不一致";
                      });
                      return;


                    }
                   Navigator.pushNamed(context, 'home');
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Text("确认提交",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("注册流程",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                  Text("输入手机号>输入验证码>设置密码",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 倒计时

}
