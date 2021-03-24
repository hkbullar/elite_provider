
import 'package:elite_provider/global/AboutUsText.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget
{
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(AboutUs.aboutUs,textAlign: TextAlign.center,style: TextStyle(color: AppColours.white,fontSize: 16),),
      )
    );
  }
}