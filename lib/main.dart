
import 'package:elite_provider/dashboard/DashBoardScreen.dart';
import 'package:elite_provider/loginpages/DocumentsScreen.dart';
import 'package:elite_provider/loginpages/SplashScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ELITE',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: DashBoardScreen(),
      //home: HireGuardScreen(),
    );
  }
}
