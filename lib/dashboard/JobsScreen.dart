
import 'package:elite_provider/global/API.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';
import 'package:elite_provider/screens/JobDetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/CommonWidgets.dart';

class JobsScreen extends StatefulWidget
{
  Function onClick;
  JobsScreen({this.onClick(value,value1,value2)});

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool isGuard=false;
  List<GuardianBookingPojo> guardianBooking;
  List<DriverBookingPojo> journeyBooking;
  @override
  void initState() {
    _getRequests();
    super.initState();
  }
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
          _listOfData() {
            return SafeArea(
              child: Container(
                  child: ListView.separated(
                      itemCount: guardianBooking!=null || journeyBooking!=null?isGuard?guardianBooking.length:journeyBooking.length:0,
                      separatorBuilder: (context, i) {
                        return Divider(thickness: 2.0);
                      },
                      itemBuilder: (context, index) {
                        return _bookingJourneyListItem(index);
                      })
              ),
            );
          }

         Widget _bookingJourneyListItem(int index){
            return Card(
                elevation: 5.0,
                color: AppColours.golden_button_bg,
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
                            child: Column(
                              children: [
                                isGuard?CommonWidgets.selectedFontWidget("From: ${Global.generateDate(guardianBooking[index].bookings[0].fromDate)} "
                                    "To: ${Global.generateDate(guardianBooking[index].bookings[0].toDate)}\n"
                                    "Timings: ${Global.formatTime(guardianBooking[index].bookings[0].fromTime)}To"
                                    " ${Global.formatTime(guardianBooking[index].bookings[0].toTime)}\n${guardianBooking[index].bookings[0].selectDays}",
                                    AppColours.black, 15.0,FontWeight.bold):
                                CommonWidgets.selectedFontWidget("${Global.generateDate(journeyBooking[index].bookings[0].date)} at ${Global.formatTime(journeyBooking[index].bookings[0].time)}", AppColours.black, 15.0,FontWeight.bold),
                              ],
                            ),
                          ),
                          CommonWidgets.selectedFontWidget("${isGuard?guardianBooking[index].bookings[0].price:journeyBooking[index].bookings[0].price} Pounds", AppColours.white, 15.0,FontWeight.bold),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      isGuard?CommonWidgets.selectedFontWidget("For",
                          AppColours.black, 15.0, FontWeight.bold):CommonWidgets.selectedFontWidget("From:",
                          AppColours.black, 15.0, FontWeight.bold),
                      CommonWidgets.selectedFontWidget(isGuard?guardianBooking[0].bookings[0].location:journeyBooking[index].bookings[0].destinationLocation,
                          AppColours.black, 13.0, FontWeight.w500),
                      isGuard?SizedBox():SizedBox(height: 20.0),
                      isGuard?SizedBox():CommonWidgets.selectedFontWidget("To:",AppColours.black, 15.0, FontWeight.bold),
                      isGuard?SizedBox():CommonWidgets.selectedFontWidget(journeyBooking[index].bookings[0].arrivalLocation,AppColours.black, 13.0, FontWeight.w500),
                      SizedBox(height: 20.0),
                      CommonWidgets.blackFullWidthButton("JOB DETAILS",onClick: ()
                      {
                        listItemClick(isGuard?null:journeyBooking[index].bookings[0], isGuard?guardianBooking[0].bookings[0]:null);
                      })
                    ],
                  ),
                ));
          }
listItemClick(JourneyBooking journeyBooking,GuardianBooking guardianBooking) async {

  if(isGuard){
    await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetailsScreen(null,guardianBooking))).then((value) =>
    {widget.onClick(null,guardianBooking,isGuard)});
  }else{
   await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => JobDetailsScreen(journeyBooking,null))).then((value) =>
   {widget.onClick(journeyBooking,null,isGuard)});
  }
}

  _getRequests(){
    Global.userType().then((value){
      if(value==Constants.USER_ROLE_DRIVER){
        isGuard=false;
        API(context).getDriverRequests(onSuccess: (value){
          if(value!=null && value.isNotEmpty){
                setState(() {
                  journeyBooking=value;
                });
          }
        });
      }
      else if(value==Constants.USER_ROLE_GUARD){
        isGuard=true;
        API(context).getGuardianRequests(onSuccess: (value){
          if(value!=null && value.isNotEmpty){
                setState(() {
                  guardianBooking=value;
                });
          }
        });
      }
    });
  }
  }

