import 'dart:convert';
import 'package:elite_provider/dashboard/DashBoardScreen.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/global/PLoader.dart';
import 'package:elite_provider/global/ServiceHttp.dart';
import 'package:elite_provider/loginpages/DocumentsScreen.dart';
import 'package:elite_provider/pojo/ErrorPojo.dart';
import 'package:elite_provider/pojo/GetDocumentsPojo.dart';
import 'package:elite_provider/pojo/LoginPojo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API{
  BuildContext context;
  API(this.context);
  login(Map jsonPost)
  {
  PLoader loader=PLoader(context);
  loader.show();
  ServiceHttp().httpRequestPost("login",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setString(Constants.USER_TYPE, loginPojo.role);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));

          loader.hide();
          Global.toast(context, "Logged In Successfully");
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
        }, onError: (value) {
          loader.hide();
          Map<String, dynamic> map = json.decode(value);
          CommonWidgets.showMessage(context,map["error"]);
        });
  }

  register(Map jsonPost,int userType){
    PLoader loader=PLoader(context);
    loader.show();
    ServiceHttp().httpRequestPost("register",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));
          loader.hide();
          Global.toast(context, "Registered Successfully");
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DocumentsScreen(userType)));
        }, onError: (value) {
          loader.hide();
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }
  getDocuments(int userType,{void onSuccess(GetDocumentsPojo value)}){
    Map<String, dynamic> jsonPost =
    {
      Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
    };
    PLoader loader=PLoader(context);
    loader.show();
    ServiceHttp().httpRequestPost("getDocument",map: jsonPost,
        onSuccess: (value) async {
          GetDocumentsPojo loginPojo= GetDocumentsPojo.fromJson(json.decode(value));
          onSuccess(loginPojo);
          loader.hide();
        }, onError: (value) {
          loader.hide();
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }
}