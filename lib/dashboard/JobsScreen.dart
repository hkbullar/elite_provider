
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/screens/JobDetailsScreen.dart';
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: AppColours.off_white,
        ),
        scrollDirection: Axis.vertical,
        itemCount: 12,
        itemBuilder:  (context, index){
          return listUI();
        },)
    );
  }

  Widget listUI(){
   return InkWell(
     onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetailsScreen()));

     },
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text("From: Lake District National Park\nTo: New York Moors National Park\nDate \& Time: 4th March at 4:15 PM",textAlign: TextAlign.center,style: TextStyle(color: AppColours.white,fontSize: 16),),
     ),
   );
  }
}