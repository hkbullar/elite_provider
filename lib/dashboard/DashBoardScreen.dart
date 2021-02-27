
import 'package:elite_provider/dashboard/HomeScreen.dart';
import 'package:elite_provider/dashboard/JobsScreen.dart';
import 'package:elite_provider/dashboard/ProfileScreen.dart';
import 'package:elite_provider/dashboard/SettingsScreen.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget
{

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  int _selectedIndex = 0;
  static const List<String> titleList=<String>["Home","Jobs","Profile","Settings"];
   List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),JobsScreen(),ProfileScreen(),SettingsScreen(),
  ];
    String title="Home";
  void _onItemTapped(int index) {
    if(_selectedIndex!=index){
      setState(() {
        title=titleList[index];
        _selectedIndex = index;
      });
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.black,
      appBar: AppBar(
        backgroundColor: AppColours.black,
          iconTheme:IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(title,style: TextStyle(color: AppColours.white),)),
      body: _widgetOptions.elementAt(_selectedIndex),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('John Smith',style: TextStyle(color: Colors.white, fontSize: 25)),
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(Constants.LOCAL_IMAGE+'logo.png'))),
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () => {_onItemTapped(0)},
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile'),
              onTap: () => {_onItemTapped(1)},
            ),
            ListTile(
              leading: Icon(Icons.schedule_outlined),
              title: Text('Jobs'),
              onTap: () => {_onItemTapped(2)},
            ),
            ListTile(
              leading: Icon(Icons.policy_outlined),
              title: Text('Privacy Policy'),
              onTap: () => {_onItemTapped(3)},
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Terms & Conditions'),
              onTap: () => {_onItemTapped(4)},
            ),
            ListTile(
              leading: Icon(Icons.contact_support_outlined),
              title: Text('Contact Us'),
              onTap: () => {_onItemTapped(5)},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () => {_onItemTapped(6)},
            ),
          ],
        ),
      ),
    );
  }
}