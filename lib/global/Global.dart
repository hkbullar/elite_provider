import 'package:elite_provider/global/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Global{
  static Future<SharedPreferences> getSharedPref() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return _prefs;
  }

  static void toast(BuildContext context,String message) {
    Toast.show(message,
        context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }

  static Future<bool> isRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISREGISTERED) ?? false;
  }
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.TOKEN) ?? '';
  }
  static double getHeight(BuildContext con,{double divider}){
    double aDivider=1;
    if(divider!=null){aDivider=divider;}
    return MediaQuery.of(con).size.height/aDivider;
  }

}