import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_provider/dashboard/DashBoardScreen.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/loginpages/LoginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String _versionName = 'V1.0';
  final splashDelay = 4;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Global.isRegistered().then((isLogged) {
      if (isLogged) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));
        /*Global.isApproved().then((value) {
          if(value){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));
          }else{
            Global.userType().then((value){
              if(value==Constants.USER_ROLE_DRIVER){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DocumentsScreen(1, true)));
              }
              else if(value==Constants.USER_ROLE_GUARD){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DocumentsScreen(2, true)));
              }
              else{
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
              }
            });
          }
        }
        );*/
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.black,
      body: InkWell(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              Constants.LOCAL_IMAGE+"splash.jpeg",fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Expanded(child: Center(child: Text("For Providers",style: TextStyle(color: AppColours.white,fontSize: 32,fontWeight: FontWeight.bold),))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColours.golden_button_bg),),
                      Container(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Spacer(),
                            Text(_versionName,style: TextStyle(color: AppColours.off_white),),
                            Spacer(
                              flex: 4,
                            ),
                            Text('Elite Academy',style: TextStyle(color: AppColours.off_white),),
                            Spacer(),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}