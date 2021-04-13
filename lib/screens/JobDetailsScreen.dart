
import 'dart:convert';

import 'package:elite_provider/global/API.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/EliteAppBar.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';
import 'package:elite_provider/pojo/User.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobDetailsScreen extends StatefulWidget
{
  JobDetailsScreen(this.journeyBooking,this.guardianBooking,this.isGuard);

  DriverBookingPojo journeyBooking;
  GuardianBookingPojo guardianBooking;



  bool isGuard=false;

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState(guardianBookingPojo: guardianBooking,driverBookingPojo: journeyBooking,isGuard: isGuard);
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  _JobDetailsScreenState({this.driverBookingPojo,this.guardianBookingPojo,this.isGuard});

  GuardianBookingPojo guardianBookingPojo;
  DriverBookingPojo driverBookingPojo;

  JourneyBooking journeyBooking;
  GuardianBooking guardianBooking;
  List<String> daysList=[];
  bool isGuard=false;

  @override
  void initState() {
    if(isGuard){
      guardianBooking=guardianBookingPojo.bookings[0];
      daysList=guardianBooking.selectDays;
    }else{
      journeyBooking=driverBookingPojo.bookings[0];
    }
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
              !isGuard?CommonWidgets.requestTextContainer("To",journeyBooking.arrivalLocation,Icons.location_on_outlined):SizedBox(),

              isGuard?CommonWidgets.requestTextContainer("Date","From: ${Global.generateDate(guardianBooking.fromDate)} To: ${Global.generateDate(guardianBooking.toDate)}",Icons.date_range_outlined):
              CommonWidgets.requestTextContainer("Date",Global.generateDate(journeyBooking.date),Icons.date_range_outlined),

              isGuard?CommonWidgets.requestTextContainer("Timings","${Global.formatTime(guardianBooking.fromTime)} To ${Global.formatTime(guardianBooking.toTime)}",Icons.time_to_leave_outlined):
              CommonWidgets.requestTextContainer("Time","${Global.formatTime(journeyBooking.time)}",Icons.time_to_leave_outlined),

              isGuard?CommonWidgets.requestTextContainer("Working Days:",getDaysString(),Icons.view_week_outlined):

              commentBoxText()!=null?CommonWidgets.requestTextContainer("Comments",commentBoxText(),Icons.comment_bank_outlined):SizedBox(),

              CommonWidgets.requestTextContainer("Price","${isGuard?guardianBooking.price:journeyBooking.price}",Icons.attach_money),
              SizedBox(height: 10),
              CommonWidgets.goldenFullWidthButton(generateText(),onClick: ()
              async {
                if(isGuard){
                  if(guardianBookingPojo.status==0){
                    if(await Global.isJobInProgress()){
                      Global.toast(context, "Job already in progress");
                    }
                    else{
                      startJob();
                    }
                  }
                  else if(guardianBookingPojo.status==1){
                    Navigator.pop(context,true);
                  }
                }
                else{
                  if(driverBookingPojo.startJob==0){
                    if(await Global.isJobInProgress())
                    {
                      Global.toast(context, "Job already in progress");
                    }
                    else
                   {
                      startJob();
                    }
                  }
                  else if(driverBookingPojo.startJob==1)
                  {
                    Navigator.pop(context,true);
                  }
                }
              })
            ],
          ),
        ),
      )
    );
  }

String generateText()
{
    if(isGuard){
      if(guardianBookingPojo.status==0){
        return "Start Job";
      }
      else if(guardianBookingPojo.status==1){
        return "Job in Progress";
      }
      else{
        return "Completed Job :)";
      }
    }
    else{
      if(driverBookingPojo.startJob==0){
        return "Start Journey";
      }
      else if(driverBookingPojo.startJob==1){
        return "On a Journey";
      }
      else {
        return "Completed Journey :)";
      }
    }
}

String getDaysString(){
    String days="";
    if(daysList.isNotEmpty){
      for(int i=0;i<daysList.length;i++){
        if(i==0){
          days="${daysList[i]}";
        }
        else{
          days="$days,${daysList[i]}";
        }
      }
    }
    return days;
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
      API(context).jobStartComplete(true, isGuard,userinfo.id,isGuard?guardianBookingPojo.bookingId:driverBookingPojo.bookingId,onSuccess: ()
      {
        Navigator.pop(context,true);
      });
    });
  }
}