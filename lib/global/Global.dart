import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/loginpages/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Global{
  static Future<SharedPreferences> getSharedPref() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    return _prefs;
  }

  void toast(BuildContext context,String message) {
    ToastContext().init(context);
    Toast.show(message, duration: Toast.lengthLong, gravity:  Toast.bottom);
  }

  static Future<bool> isRegistered() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISREGISTERED) ?? false;
  }
  static Future<bool> isJobInProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISCURRENTJOB) ?? false;
  }

  static setJobInProgress(bool value) async {
    SharedPreferences preferences =await Global.getSharedPref();
    preferences.setBool(Constants.ISCURRENTJOB,value);
  }
  static Future<bool> isOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISONLINE) ?? false;
  }
  static Future<bool> isApproved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constants.ISAPPROVED) ?? false;
  }
  static Future<String> userType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.USER_ROLE) ?? "";
  }
  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.TOKEN) ?? '';
  }

  static Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.LANGUAGE_CODE) ?? 'en';
  }

  static setLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.LANGUAGE_CODE,lang) ?? '';
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.EMAIL) ?? '';

  }
  static double getHeight(BuildContext con,{double divider}){
    double aDivider=1;
    if(divider!=null){aDivider=divider;}
    return MediaQuery.of(con).size.height/aDivider;
  }
  static fomattedTime(String time){
    int timeInMillis = int.parse(time);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return  DateFormat.yMd().add_jm().format(date);
  }

  static fomattedDate(String time){
    int timeInMillis = int.parse(time);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    return  DateFormat.yMd().format(date).toString(); // Apr 8, 2020
  }
  //logout app
  //remove shared prefrences
  static removePreferences(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(Constants.ISREGISTERED);
    //Remove bool
    prefs.remove(Constants.TOKEN);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => LoginScreen()), ModalRoute.withName("/Login"));
  }
  static getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.USER_PREF) ?? '';
  }
  //hide keyboard
  static  hideKeyBoard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
  static String formatTime(String time){

    return DateFormat.jm().format(DateFormat('HH:mm:ss').parse(time)).toString();
  }
  static  String generateDate(DateTime dt){
    var formatter = new DateFormat('MMM, EEEE');
    String date="${dt.day}${Global.getDayOfMonthSuffix(dt.day)} ${formatter.format(dt)}";
    return date;
  }
  static  String generateShortMonth(DateTime dt){
    String date="${DateFormat('EEE').format(dt)}";
    return date;
  }
  static  String generateFullMonth(DateTime dt){
    var formatter = new DateFormat('EEEE');
    String date="${dt.day}${Global.getDayOfMonthSuffix(dt.day)} ${formatter.format(dt)}";
    return date;
  }
  static String getDayOfMonthSuffix(int dayNum) {
    if(!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if(dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch(dayNum % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
  }
}