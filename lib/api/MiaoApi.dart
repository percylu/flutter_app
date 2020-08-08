
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/HttpRequest.dart';
import 'package:flutter_app/utility/Address.dart';
import 'package:flutter_app/utility/SpUtils.dart';

/// 登录 model
class MiaoApi{
  // 手机号码登录
  static login(String username,String password) async{
    ResultData response = await HttpRequest.postparam(Address.login, {"username" : username,"password":password});
    print(response);
    return response;
  }
  static logout() async{
    ResultData response = await HttpRequest.get(Address.logout, null);

    if(response != null && response.success){
      SpUtils.remove(Config.TOKEN_KEY);
      return true;
    }
    return false;

  }


  // 获取验证码
  static getVerifyCode(String phone) async {
    ResultData response = await HttpRequest.postparam(
        Address.verifyCode, {"username": phone});

//    var response = await HttpRequest.get(Address.getVerifyCode, {"phone":phone});

    return response;
  }

  // 获取验证码
  static VerifyCode(String phone,String code) async {
    ResultData response = await HttpRequest.postparam(
        Address.codeVerify, {"username": phone,"code":code});
    return response;
  }

  // 注册用户
  static add(String phone,String code) async {
    ResultData response = await HttpRequest.post(
        Address.register, {"account": phone,"password":code});
    return response;
  }
}