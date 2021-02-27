
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobsScreen extends StatefulWidget
{
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("From: Lake District National Park\nTo: New York Moors National Park\nDate \& Time: 4th March at 4:15 PM",style: TextStyle(color: AppColours.white,fontSize: 16),),
          ),
          Text("Awaiting Quote",style: TextStyle(color: AppColours.white,fontSize: 18),),

        ],
      )
    );
  }
}