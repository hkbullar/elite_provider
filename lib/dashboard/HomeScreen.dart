
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Card(
                      color: AppColours.textFeildBG,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(children: [
                          Icon(Icons.directions_car,color: AppColours.golden_button_bg,size: 40,) ,
                          SizedBox(height: 10),
                          Text("Book a Journey",style: TextStyle(fontSize: 20,color: AppColours.white,fontWeight: FontWeight.bold),)
                        ],),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Card(
                      color: AppColours.textFeildBG,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(children: [
                          Icon(Icons.security,color: AppColours.golden_button_bg,size: 40,) ,
                          SizedBox(height: 10),
                          Text("Hire a Guard",style: TextStyle(fontSize: 20,color: AppColours.white,fontWeight: FontWeight.bold),)
                        ],),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}