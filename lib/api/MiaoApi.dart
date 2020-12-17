
import 'package:dio/dio.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/entity/pet_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/HttpRequest.dart';
import 'package:flutter_app/utility/Address.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:sharesdk_plugin/sharesdk_defines.dart';

/// 登录 model
class MiaoApi{
  // 手机号码登录
  static login(String username,String password) async{
    ResultData response = await HttpRequest.postparam(Address.login, {"username" : username,"password":password});
    if(response.code==201){
      LoginEntity user=JsonConvert.fromJsonAsT(response.data);
      print("user:-------------");
      print(user.data.user.name);
      SpUtils.set(Config.USER, user);
    }
    return response;


  }
  static logout() async{
    ResultData response = await HttpRequest.get(Address.logout, null);
    SpUtils.remove(Config.TOKEN_KEY);
    return true;

  }

  static upload(FormData data) async{
    ResultData response = await HttpRequest.post(Address.uploads, data);
    return response;
  }

  static userUpdate(String userId,String avatar,String name,int sexy) async{
    ResultData response = await HttpRequest.post(Address.userUpdate, {"userId":userId,
      "name":name,"sex":sexy,"avatar":avatar
    });
    return response;
  }
  // 获取验证码
  static getVerifyCode(String phone) async {
    ResultData response = await HttpRequest.postparam(
        Address.getVerifyCode, {"username": phone});

//    var response = await HttpRequest.get(Address.getVerifyCode, {"phone":phone});
    return response;
  }

  // 获取验证码
  static getCode(String phone) async {
    ResultData response = await HttpRequest.postparam(
        Address.getCode, {"username": phone});

//    var response = await HttpRequest.get(Address.getVerifyCode, {"phone":phone});
    return response;
  }
  // 获取验证码
  static getAuthCode(String phone) async {
    ResultData response = await HttpRequest.postparam(
        Address.getAuthCode, {"username": phone});

//    var response = await HttpRequest.get(Address.getVerifyCode, {"phone":phone});
    return response;
  }

  // 获取验证码
  static VerifyCode(String phone,String code) async {
    ResultData response = await HttpRequest.postparam(
        Address.codeVerify, {"username": phone,"code":code});
    return response;
  }

  // 第三方登陆账号验证
  static codeAuthVerify(String phone,String code,String type,String authuser) async {
    ResultData response = await HttpRequest.postparam(
        Address.codeAuthVerify, {"username": phone,"code":code,"type":type,"authuser":authuser});
    return response;
  }

  // 第三方登陆验证注册验证码
  static thirdauth(String authuser,String platform) async {
    ResultData response = await HttpRequest.postparam(
        Address.thirdauth, {"authuser": authuser,"platform":platform});
    return response;
  }

  // 获取验证码 for change mobile
  static codeVerifyChange(String phone,String code) async {
    ResultData response = await HttpRequest.postparam(
        Address.codeVerifyChange, {"username": phone,"code":code});
    return response;
  }

  //重置密码
  static resetPassword(String phone,String code,String password) async{
    ResultData response = await HttpRequest.postparam(
        Address.resetPassword, {"username": phone,"code":code,"password":password});
    return response;
  }
 //修改手机号
  static changeAccount(String userId,String phone,String code,) async{
    ResultData response = await HttpRequest.postparam(
        Address.changeAccount, {"userId":userId,"username": phone,"code":code});
    return response;
  }
  // 注册用户
  static add(String phone,String code,String type,String authuser) async {
    var qq,weixin,weibo,apple;
    switch(type){
      case "qq":
        qq=authuser;
        weixin="";
        weibo="";
        apple="";
        break;
      case "weixin":
        qq="";
        weixin=authuser;
        weibo="";
        apple="";
        break;
      case "weibo":
        qq="";
        weixin="";
        weibo=authuser;
        apple="";
        break;
      case "apple":
        qq="";
        weixin="";
        weibo="";
        apple=authuser;
        break;
      default:
        qq="";
        weixin="";
        weibo="";
        apple="";
        break;

    }
    ResultData response = await HttpRequest.post(
        Address.register, {"account": phone,"password":code,"qq":qq,"weixin":weixin,"weibo":weibo,"apple":apple});
    return response;
  }

  //广告位
 static banner() async{
    ResultData response = await HttpRequest.get(Address.banner, null);
    return response;
 }

 //个人资料
 static personal(String username) async{

      ResultData response = await HttpRequest.post(
          Address.personal, {"account": username});

      return response;
 }

 //添加设备
  static deviceAdd(String userId,String deviceSn) async{
    print("deviceAdd");
    ResultData response = await HttpRequest.post(
        Address.deviceAdd, {"userId": userId,"deviceSn":deviceSn});
    return response;
  }

  //设备列表
  static deviceListByUser(String userId) async{
    ResultData response = await HttpRequest.post(
        Address.devicelist, {"userId": userId});
    return response;
  }

  static deviceDelete(String deviceId) async{
    ResultData response = await HttpRequest.post(Address.deviceDel,{"deviceId":deviceId});
        return response;
  }

  static getSetting(String title) async{
    ResultData response = await HttpRequest.post(Address.setting,{"settingTitle":title});
    return response;
  }
  static getArticle(String articleId) async{
    ResultData response = await HttpRequest.post(Address.article,{"articleId":articleId});
    return response;
  }

  static getPetList(String userId) async{
    ResultData response =await HttpRequest.post(Address.petList, {"userId":userId});
    return response;
  }

  static petSetTop(String petId) async{
    ResultData response =await HttpRequest.post(Address.petSetTop, {"petId":petId});
    return response;
  }
  static petDelete(String petId) async{
    ResultData response =await HttpRequest.post(Address.petDelete, {"petId":petId});
    return response;
  }
  static petDetail(String petId) async{
    ResultData response =await HttpRequest.post(Address.petDetail, {"petId":petId});
    return response;
  }
  static petTypeList() async{
    ResultData response =await HttpRequest.post(Address.petType, {});
    return response;
  }

  static petUpdate(PetData pet) async{
    ResultData response =await HttpRequest.post(Address.petUpdate, pet.toJson());
    return response;
  }

  static petAdd(PetData pet) async{
    ResultData response =await HttpRequest.post(Address.petAdd, pet.toJson());
    return response;
  }

  static checkThird(String userId,String jPush,String mobId) async{
    ResultData response =await HttpRequest.post(Address.checkThird,{"userId":userId,"jpushRegId":jPush,"mobRegId":mobId} );
    return response;
  }
  static productDetail() async{
    ResultData response =await HttpRequest.post(Address.producDetail,{"promotion":1});
    return response;
  }
  static productQueryListPage(int page) async{
    ResultData response =await HttpRequest.post(Address.productQueryListPage,{"page":page});
    return response;
  }
}