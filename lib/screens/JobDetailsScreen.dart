
import 'dart:convert';

import 'package:elite_provider/global/API.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/EliteAppBar.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';
import 'package:elite_provider/pojo/User.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget
{
  JobDetailsScreen(this.journeyBooking,this.guardianBooking,this.isGuard);
  JourneyBooking journeyBooking;
  GuardianBooking guardianBooking;
  bool isGuard=false;

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState(guardianBooking: guardianBooking,journeyBooking: journeyBooking,isGuard: isGuard);
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  _JobDetailsScreenState({this.journeyBooking,this.guardianBooking,this.isGuard});

  JourneyBooking journeyBooking;
  GuardianBooking guardianBooking;

  bool isGuard=false;

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
              !isGuard?CommonWidgets.requestTextContainer("To",journeyBooking.arrivalLocation,Icons.location_on_outlined):SizedBox(),

              isGuard?CommonWidgets.requestTextContainer("Date","From: ${Global.generateDate(guardianBooking.fromDate)} To: ${Global.generateDate(guardianBooking.toDate)}",Icons.date_range_outlined):
              CommonWidgets.requestTextContainer("Date",Global.generateDate(journeyBooking.date),Icons.date_range_outlined),

              isGuard?CommonWidgets.requestTextContainer("Timings","${Global.formatTime(guardianBooking.fromTime)} To ${Global.formatTime(guardianBooking.toTime)}",Icons.time_to_leave_outlined):
              CommonWidgets.requestTextContainer("Time","${Global.formatTime(journeyBooking.time)}",Icons.time_to_leave_outlined),

              isGuard?CommonWidgets.requestTextContainer("Working Days:","${guardianBooking.selectDays.toString()}",Icons.view_week_outlined):

              commentBoxText()!=null?CommonWidgets.requestTextContainer("Comments",commentBoxText(),Icons.comment_bank_outlined):SizedBox(),

              CommonWidgets.requestTextContainer("Price","${isGuard?guardianBooking.price:journeyBooking.price}",Icons.attach_money),
              SizedBox(height: 10),
              CommonWidgets.goldenFullWidthButton("Start Job",onClick: ()
              {
                startJob();
              })
            ],
          ),
        ),
      )
    );
  }

  String commentBoxText()
  {
    if(isGuard)
    {
      if(guardianBooking.comment!=null && guardianBooking.comment.isNotEmpty)
      {
        return guardianBooking.comment;
      }
      else
      {
        return null;
      }
    }
    else
      {
      if(journeyBooking.comment!=null && journeyBooking.comment.isNotEmpty)
      {
        return journeyBooking.comment;
      }
      else
      {
        return null;
      }
    }
  }

  startJob()
  {
    Global.getUser().then((value) async {
      User userinfo = User.fromJson(json.decode(value));
      API(context).jobStartComplete(true, isGuard,userinfo.id,isGuard?guardianBooking.id:journeyBooking.id,onSuccess: ()
      {
        Navigator.pop(context,true);
      });
    });
  }
}