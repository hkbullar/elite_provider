
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/EliteAppBar.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget
{
  JobDetailsScreen(this.journeyBooking,this.guardianBooking);
  JourneyBooking journeyBooking;
  GuardianBooking guardianBooking;
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState(guardianBooking: guardianBooking,journeyBooking: journeyBooking);
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  _JobDetailsScreenState({this.journeyBooking,this.guardianBooking});
  JourneyBooking journeyBooking;
  GuardianBooking guardianBooking;
  bool isGuard=false;
  @override
  void initState() {
    Global.userType().then((value){
      setState(() {
        if(value==Constants.USER_ROLE_DRIVER){
          isGuard=false;
        }
        else if(value==Constants.USER_ROLE_GUARD){
          isGuard=true;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EliteAppBar("Job Details"),
      backgroundColor: AppColours.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              isGuard?CommonWidgets.requestTextContainer("For",guardianBooking.location,Icons.location_on_outlined):
              CommonWidgets.requestTextContainer("From",journeyBooking.destinationLocation,Icons.location_on_outlined),
              CommonWidgets.requestTextContainer("To",journeyBooking.arrivalLocation,Icons.location_on_outlined),

              isGuard?CommonWidgets.requestTextContainer("Date","From: ${Global.generateDate(guardianBooking.fromDate)} To: ${Global.generateDate(guardianBooking.toDate)}",Icons.date_range_outlined):
              CommonWidgets.requestTextContainer("Date",Global.generateDate(journeyBooking.date),Icons.date_range_outlined),

              isGuard?CommonWidgets.requestTextContainer("Timings","${Global.formatTime(guardianBooking.fromTime)} To ${Global.formatTime(guardianBooking.toTime)}",Icons.time_to_leave_outlined):
              CommonWidgets.requestTextContainer("Time","${Global.formatTime(journeyBooking.time)}",Icons.time_to_leave_outlined),

              CommonWidgets.requestTextContainer("Comments",isGuard?guardianBooking.comment.isNotEmpty?guardianBooking.comment:"No Comments":journeyBooking.comment.isNotEmpty?journeyBooking.comment:"No Comments",Icons.comment_bank_outlined),

              CommonWidgets.requestTextContainer("Price","${isGuard?guardianBooking.price:journeyBooking.price}",Icons.attach_money),
              SizedBox(height: 10),
              CommonWidgets.goldenFullWidthButton("Start Job",onClick: (){

                Navigator.pop(context, isGuard?guardianBooking:journeyBooking);
              })
            ],
          ),
        ),
      )
    );
  }
}