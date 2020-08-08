import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/entity/login_entity.dart';

import 'dart:collection';

import 'Config.dart';
import 'ResultCode.dart';
import 'ResultData.dart';
import 'SpUtils.dart';


///http请求管理类，可单独抽取出来
class HttpRequest {
  static String _baseUrl = "http://192.168.3.25:8002/";
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
    "Accept": '*/*',
  };

  static setBaseUrl(String baseUrl){
    _baseUrl = baseUrl;
  }

  static get(url,param) async{
    return await request(_baseUrl+url, param, null, new Options(method:"GET"));
  }

  static post(url,param) async{
    return await request(_baseUrl+url, param, {"Accept": '*/*'}, new Options(method: 'POST'));
  }

  static postparam(url,param) async{
    return await request(_baseUrl+url, param, {"Accept": '*/*',"content-type":CONTENT_TYPE_FORM}, new Options(method: 'POST'));
  }

  static delete(url,param) async{
    return await request(_baseUrl+url, param, null, new Options(method: 'DELETE'));
  }

  static put(url,param) async{
    return await request(_baseUrl+url, param, null, new Options(method: "PUT", contentType: "text/plain"));
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static request(url, params, Map<String, String> header, Options option, {noTip = false}) async {

    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData("", false, Code.NETWORK_ERROR,Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip));
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    headers["Authorization"] = optionParams["authorizationCode"];
    // 设置 baseUrl

    if (option != null) {
      option.headers = headers;
    } else{
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.receiveTimeout = 15000;

    Dio dio = new Dio();
    // 添加拦截器
    if (Config.DEBUG) {
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options){
            print("\n================== 请求数据 ==========================");
            print("url = ${options.uri.toString()}");
            print("headers = ${options.headers}");
            print("params = ${options.data}");
          },
          onResponse: (Response response){
            print("\n================== 响应数据 ==========================");
            print("code = ${response.statusCode}");
            print("data = ${response.data}");
            print("\n");
          },
          onError: (DioError e){
            print("\n================== 错误响应数据 ======================");
            print("type = ${e.type}");
            print("message = ${e.message}");
            print("\n");
          }
      ));
    }

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }
      return new ResultData("", false, errorResponse.data['code'],errorResponse.data['message']);
    }

    try {
      if (option.contentType != null && option.contentType == "text") {
        return new ResultData(response.data, true, Code.SUCCESS,"");
      } else {
        var responseJson = response.data;
        if (responseJson['code']== 201 && responseJson['data']['token']!= null){
          optionParams["authorizationCode"] = responseJson['data']['token'];
          print("token:"+optionParams["authorizationCode"]);
          await SpUtils.save(Config.TOKEN_KEY, optionParams["authorizationCode"]);
        }
      }
      if (response.data['code'] == 200 || response.data['code'] == 201) {
        return ResultData(response.data, true, Code.SUCCESS,"");
      }
    } catch (e) {
      print(e.toString() + url);
      return ResultData(response.data, false, response.data['code'],e.toString());
    }
    return new ResultData("", false, response.data['code'],response.data['message']);
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    SpUtils.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  static getAuthorization() async {
    String token = await SpUtils.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await SpUtils.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      optionParams["authorizationCode"] = token;
      return token;
    }
  }
}
