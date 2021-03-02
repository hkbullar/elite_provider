
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/screens/JobDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/CommonWidgets.dart';

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
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: _listOfData() //Center(child: Text("Driver's all Jobs schedule will appear here as list",textAlign: TextAlign.center,style: TextStyle(color: AppColours.white,fontSize: 22),)),
        )
    );
  }

  /*Widget listUI() {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => JobDetailsScreen()));

          listUI() {
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "From: Lake District National Park\nTo: New York Moors National Park\nDate \& Time: 4th March at 4:15 PM",
                    style: TextStyle(color: AppColours.white, fontSize: 16),),
                ),
                Text("Awaiting Quote",
                  style: TextStyle(color: AppColours.white, fontSize: 18),),

              ],
            );
          }
        });*/


          _listOfData() {
            return SafeArea(
              child: Container(
                  child: ListView.separated(
                      itemCount: 2,
                      separatorBuilder: (context, i) {
                        return Divider(thickness: 2.0,);
                      },
                      itemBuilder: (context, index) {
                        return Card(elevation: 5.0,
                            margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Container(padding: EdgeInsets.fromLTRB(
                                15.0, 10.0, 15.0, 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CommonWidgets.selectedFontWidget(
                                            "02-03-2021" + " at " +
                                                "12:25", AppColours.black, 15.0,
                                            FontWeight.bold),
                                      ),
                                      CommonWidgets.selectedFontWidget(
                                          "220" + " GHS", AppColours.off_white,
                                          15.0,
                                          FontWeight.bold),
                                    ],
                                  ),

                                  SizedBox(height: 20.0),
                                  CommonWidgets.selectedFontWidget("From:",
                                      AppColours.black, 15.0, FontWeight.bold),
                                  CommonWidgets.selectedFontWidget("Chandigarh",
                                      AppColours.black, 13.0, FontWeight.w500),
                                  SizedBox(height: 20.0),
                                  CommonWidgets.selectedFontWidget("To:",
                                      AppColours.black, 15.0, FontWeight.bold),
                                  CommonWidgets.selectedFontWidget("Punjab",
                                      AppColours.black, 13.0, FontWeight.w500),
                                  SizedBox(height: 20.0),
                                  Row(mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                    children: [
                                      RaisedButton(
                                        elevation: 5.0,
                                        onPressed: () {

                                        }, color: AppColours.white,
                                        child: CommonWidgets.selectedFontWidget(
                                            "Cancel journey",
                                            AppColours.golden_button_bg, 14.0,
                                            FontWeight.w500),),
                                      RaisedButton(
                                        elevation: 5.0,
                                        onPressed: () {

                                        }, color: AppColours.golden_button_bg,
                                        child: CommonWidgets.selectedFontWidget(
                                            "Start journey",
                                            AppColours.white, 14.0,
                                            FontWeight.w500),)
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      })
              ),
            );
          }

  }

