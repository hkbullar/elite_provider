
import 'dart:convert';

import 'package:elite_provider/dashboard/AboutScreen.dart';
import 'package:elite_provider/dashboard/HomeScreen.dart';
import 'package:elite_provider/dashboard/JobsScreen.dart';
import 'package:elite_provider/dashboard/ProfileScreen.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashBoardScreen extends StatefulWidget
{

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int _selectedIndex = 0;
  static const List<String> titleList=<String>["Home","Jobs","Profile","Privacy Policy","Terms & Conditions","Contact Us","About Us","Log Out"];
   List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),JobsScreen(),ProfileScreen(),AboutScreen(),AboutScreen(),AboutScreen(),AboutScreen(),
  ];

  User userinfo;

  @override
  void initState() {
    Global.getUser().then((value) async {
      setState(()
      {
        userinfo = User.fromJson(json.decode(value));
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColours.black,
        appBar: AppBar(
          backgroundColor: AppColours.black,
            iconTheme:IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(titleList[_selectedIndex],style: TextStyle(color: AppColours.white),)),
        body: _widgetOptions.elementAt(_selectedIndex),
        drawer: Drawer(
          child: Container(
            color: AppColours.textFeildBG,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 150,
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 30,),
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColours.white,width: 2),
                              image: DecorationImage(
                                image: AssetImage("assets/images/ic_profile.png"),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(userinfo!=null?userinfo.name:"",style: TextStyle(color: AppColours.white, fontSize: 20)),
                              Text(userinfo!=null?userinfo.email:"",style: TextStyle(color: AppColours.golden_button_bg, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 0.5,color: AppColours.dark_grey),
                sideBarItem(Icons.home_outlined, 0),
                sideBarItem( Icons.person_outline, 1),
                sideBarItem( Icons.schedule_outlined, 2),
                sideBarItem( Icons.policy_outlined, 3),
                sideBarItem( Icons.contacts, 4),
                sideBarItem( Icons.contact_support_outlined, 5),
                sideBarItem( Icons.info_outline, 6),
                sideBarItem( Icons.logout, 7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sideBarItem(IconData icon,int index){
    return InkWell(
      onTap: (){
        _onItemTapped(index); },
      child: Container(
        color: _selectedIndex==index?AppColours.golden_button_bg:Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Icon(icon,color: _selectedIndex==index?AppColours.white:AppColours.golden_button_bg),
                title: Text(titleList[index],style: TextStyle(color: AppColours.white),),
              ),
            ),
            Container(
              height: 0.5,
              color: AppColours.dark_grey,
            )
          ],
        ),
      ),
    );
  }
  showLogOutDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Log Out",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
          Global.removePreferences(context);
        });
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: AppColours.textFeildBG,
        title: Text("Log out",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 20)),
        content: Text("Do you really want to Log Out?",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 14)),
        actions: [cancelButton,okButton]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showExitDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Exit",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
      onPressed: () {
        setState(() {
          SystemNavigator.pop();
        });
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Cancel",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
        backgroundColor: AppColours.textFeildBG,
        title: Text("Exit App",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 20)),
        content: Text("Do you really want to Exit App?",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 14)),
        actions: [cancelButton,okButton]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<bool> _onWillPop() async {
    return (await showExitDialog(context)) ?? false;
  }
  void _onItemTapped(int index) {
    Navigator.of(context).pop();
    if(index!=7){
      if(_selectedIndex!=index)
      {
        setState(() {
          _selectedIndex = index;
        });
      }
    }
    else{
      showLogOutDialog(context);
    }

  }
}