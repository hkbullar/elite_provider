
import 'package:elite_provider/loginpages/SplashScreen.dart';
import 'package:elite_provider/screens/JobDetailsScreen.dart';
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
      home: SplashScreen(),
      //home: HireGuardScreen(),
    );
  }
}
