import 'package:shared_preferences/shared_preferences.dart';

class SpUtils{

   static  get (String key) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString(key);
  }

  static save(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static remove(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}