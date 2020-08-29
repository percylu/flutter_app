import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
class SpUtils{
  static String URL="http://39.108.96.5:8002";
  // static String URL="http://192.168.0.51:8002";
  //static String URL="http://192.168.3.25:8002";
   static  get (String key) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString(key);
  }


  static save(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
  static set(String key,Object value) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String json=convert.jsonEncode(value);
     prefs.setString(key, json);
  }

  static getObjact(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String object=prefs.getString(key);
    return convert.jsonDecode(object);
  }
  static remove(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}