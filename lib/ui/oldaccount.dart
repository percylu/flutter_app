import 'dart:async';

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/ui/newaccount.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/widget/messagedialog.dart';


class OldAccount extends StatefulWidget {
  final username;
  OldAccount({this.username});
  @override
  _OldAccount createState() => _OldAccount();
}

class _OldAccount extends State<OldAccount> {
  var userController = new TextEditingController();
  var verifycodeController = new TextEditingController();
  var _seconds = 0;
  var _ishide=true;
  var _canSend=true;
  var passwordController = new TextEditingController();
  var _isObscure=true;
  var _eyeColor=Colors.black54;
  Timer _timer;
  @override
  Widget build(BuildContext context) {
    userController.text=widget.username;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "验证旧手机",
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
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "+86",
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(
                      width: 1.5,
                      height: 30,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                    Expanded(
                      child: TextField(
                        controller: userController,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "输入手机号码",
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
                  ],
                ),
              ),
              Offstage(
                offstage: _ishide,
                child:
              Container(
                alignment: Alignment.center,
                child: Text(
                  "短信已发送，" + _seconds.toString() + "S后可再次获取验证码",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 300,
                    child: Card(
                      margin: EdgeInsets.only(left: 60, top: 10, bottom: 10),
                      elevation: 2,
                      shape: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black54, width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        controller: verifycodeController,
                        decoration: InputDecoration(
                            hintText: "输入验证码",
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
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.email,
                      color: _canSend?Color(0xFFF28282):Colors.grey,
                      size: 36,
                    ),
                    onPressed: (_seconds == 0)?() async{
                      if(userController.text==""){
                        _showError("输入错误","请输入手机号");
                        return;

                      }
                      ResultData response=await MiaoApi.getVerifyCode(userController.text);
                      if(response != null && response.success){
                        _startTimer();
                        setState(() {
                          _canSend=false;
                          _ishide=false;
                        });
                      }else{
                        _showError("获取验证码错误",response.message);
                        return;
                      }

                    }:null,
                  )
                ],
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                    left: 60.0, right: 60, top: 10.0, bottom: 90.0),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: new Color(0xFFF28282),
                  onPressed: () async{
                    _cancleTimer();
                    ResultData response = await MiaoApi.codeVerifyChange(userController.text,
                        verifycodeController.text);
                    if(response.code==200) {
                      Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(builder: (_) {
                            return new NewAccount();
                          })
                      );                    }else{
                      _showError(" 验证码错误", response.message);
                      return;
                    }
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
            ],
          ),
        ],
      ),
    );
  }
  /// 倒计时
  _startTimer() {
    _seconds = 60;

    _timer = Timer.periodic(new Duration(seconds: 1), (timer){
      if(_seconds == 0){
        _cancleTimer();
        return;
      }
      _seconds--;
      if (_seconds == 0){
        _canSend = true;
      }
      setState(() {}
      );
    });
  }

  _cancleTimer(){
    _timer?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    /// 页面销毁的时候,清除timer
    _cancleTimer();
  }

  _showError(title,msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: title,
            message: msg,
            negativeText: "重试",
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
