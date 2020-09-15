/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  var userController = new TextEditingController();
  var passwordController = new TextEditingController();
  var _isObscure=true;
  var _eyeColor=Colors.black54;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.8,
        backgroundColor: Colors.white,
        title: Text(
          "登录",
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
              Container(height: 100,),
              Image.asset("assets/login_img_micromew@3x.png",scale: 1.5,),
              Container(
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.only(left: 60, right: 60, top: 20),
                      elevation: 2,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54,width:3.0),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child:
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              Text("+86",style: TextStyle(fontSize: 15),),
                              Container(
                                width: 1.5,
                                height: 30,
                                margin: EdgeInsets.only(left:10,right: 10),
                                decoration: BoxDecoration(color: Colors.grey),
                              ),
                              Expanded(
                                child: TextField(
                              controller: userController,
                              decoration: InputDecoration(
                                  hintText: "输入手机号码",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0)),
                            ),
                              )
                          ],),
                    ),
                    Card(
                      margin: EdgeInsets.only(left: 60, right: 60, top: 20),
                      elevation: 2,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54,width:3.0),
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon:Icon(
                              Icons.visibility,
                              color: _eyeColor),
                              onPressed: (){
                                setState(() {
                                  print(_isObscure);

                                  _isObscure =! _isObscure;
                                  _eyeColor = _isObscure ? Colors.black54
                                      : Color(0xFFF28282);

                                });
                              },
                            ),

                            hintText: "登录密码",
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left:60.0,right:60,top:30.0,bottom:10.0),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        color: new Color(0xFFF28282),
                        onPressed: ()  async{

                          ResultData response = await MiaoApi.login(userController.text,passwordController.text);
                          print(response);
                          if(response.code==200){
                            SpUtils.save(Config.ACCOUNT, userController.text);
                            SpUtils.save(Config.PWD, passwordController.text);
                            Navigator.pushReplacementNamed(context, 'home');
                          }else{
                            _showError(response.message);
                            return;
                          }
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child:
                            Text("登录", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text("手机快速注册",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              )),
                          onPressed: () {
                            Navigator.pushNamed(context, "mobileRegister");
                          },
                          padding: EdgeInsets.only(right: 150),
                        ),
                        FlatButton(
                          child: Text("忘记密码",
                              style: TextStyle(
                                color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                              )),
                          onPressed: () {
                            Navigator.pushNamed(context, "resetPassword");
                          },
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  _showError(msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "登陆错误",
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
