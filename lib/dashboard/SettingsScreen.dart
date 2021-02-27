
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget
{

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          color: AppColours.textFeildBG,
          child: Row(
            children: [
            CommonWidgets.settingsIcon(Icons.check),
              SizedBox(width: 10),
              Text("About App",style: TextStyle(color: AppColours.white,fontSize: 16))
            ],
          ),
        ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            color: AppColours.textFeildBG,
            child: Row(
              children: [
                CommonWidgets.settingsIcon(Icons.contact_support_outlined),
                SizedBox(width: 10),
                Text("Contact Us",style: TextStyle(color: AppColours.white,fontSize: 16))
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(10),
            color: AppColours.textFeildBG,
            child: Row(
              children: [
                CommonWidgets.settingsIcon(Icons.privacy_tip_outlined),
                SizedBox(width: 10),
                Text("Privacy Policy",style: TextStyle(color: AppColours.white,fontSize: 16))
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            color: AppColours.textFeildBG,
            child: Row(
              children: [
                CommonWidgets.settingsIcon(Icons.rule),
                SizedBox(width: 10,),
                Text("Terms \& Conditions",style: TextStyle(color: AppColours.white,fontSize: 16))
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      padding: EdgeInsets.all(12),
                      color: AppColours.red_logOut,
                      onPressed: () => {},
                      child: Text('LOG OUT',style: TextStyle(color: AppColours.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}