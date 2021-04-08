
import 'dart:async';
import 'dart:convert';

import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/CurrentJobPojo.dart';
import 'package:elite_provider/pojo/DriverCurrentJobPojo.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';
import 'package:elite_provider/pojo/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../global/API.dart';

class HomeScreen extends StatefulWidget
{
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {

JourneyBooking journeyBooking;
GuardianBooking guardianBooking;

CurrentJobPojo _currentJobPojo;
CurrentJourneyPojo _currentJourneyPojo;

bool isBooking=false;
bool isGuard=false;
bool isDisposed=false;
bool isCurrentJob=false;
bool isSheetLoading=false;
bool ifOnline=false;

LatLng currentPostion;

SheetController controller = SheetController();
SheetController currentJobController = SheetController();

CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664,-122.085749655962),
  zoom: 14.4746,
);

Completer<GoogleMapController> _controller = Completer();
Timer timer;

  @override
  void initState()
  {
  isDisposed=false;
  Global.isOnline().then((isOnline)
  {
    if(isOnline)
    {
      Location().onLocationChanged.listen((LocationData currentLocation)
      {
        API(context).updateUserLocation(currentLocation);
      });

      Global.userType().then((value)
      {
        if(value==Constants.USER_ROLE_DRIVER)
        {
          setState(()
          {
            isGuard=false;
            ifOnline=isOnline;
            startTimer();
            getCurrentJob();
          });
        }
        if(value==Constants.USER_ROLE_GUARD)
        {
          isGuard=true;
          ifOnline=isOnline;
          startTimer();
          getCurrentJob();
        }
      });
    }
  });
  WidgetsBinding.instance.addObserver(this);
    super.initState();
}
startTimer()
{
  timer= Timer.periodic(Duration(seconds: 5), (timer)
  {
    Global.isOnline().then((isOnline)
    {
      if(isOnline)
      {
        getRequests();
      }
    });
  });
}

stopTimer()
{
  if(timer!=null)
  {
    timer.cancel();
  }
}

  @override
  void dispose()
  {
    isDisposed=true;
    stopTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

@override
void didChangeAppLifecycleState(AppLifecycleState state)
{
  print('state = $state');
  if(state==AppLifecycleState.resumed)
 {
   startTimer();
 }
  if(state==AppLifecycleState.paused)
  {
    stopTimer();
  }
}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {
              _controller.complete(controller);
              _getUserLocation();
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RaisedButton(
                padding: EdgeInsets.all(18),
                color: ifOnline?Colors.green:Colors.red,
                child: Column(
                  children:
                  [
                    Text(ifOnline?"Go Offline":"Go Online",style: TextStyle(color: AppColours.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Text(ifOnline?"You are now Online":"You are now Offline",style: TextStyle(color: AppColours.white,fontSize: 12),),
                     ],
                ),
                onPressed: (){
                    setState(() {
                      showServiceDialog(context);
                    });
                }),
          ),
          isCurrentJob?currentJobSheet():SizedBox(),
          isBooking?buildSheet():SizedBox()
        ],
      )
    );
  }

Widget buildSheet()
{
  return SlidingSheet(
    duration: Duration(milliseconds: 600),
    color: Colors.white,
    shadowColor: Colors.black26,
    elevation: 12,
    controller: controller,
    cornerRadius: 16,
    cornerRadiusOnFullscreen: 0.0,
    addTopViewPaddingOnFullscreen: true,
    isBackdropInteractable: true,
    snapSpec: SnapSpec(
      snap: true,
      positioning: SnapPositioning.relativeToAvailableSpace,
      snappings: const [SnapSpec.headerFooterSnap,0.6,SnapSpec.expanded],
      onSnap: (state, snap)
      {
        print('Snapped to $snap');
      },
    ),
    headerBuilder: (context, state)
    {
      return Container(
        height: 70,
        color: AppColours.golden_button_bg,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.request_page_outlined,color: AppColours.white,size: 35),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Request (\$${isGuard?guardianBooking.price:journeyBooking.price})',style: TextStyle(color: AppColours.white,fontSize: 18,fontWeight: FontWeight.bold)),
                      Text('Pull me up please',style: TextStyle(color: AppColours.white,fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_up,color: AppColours.white,size: 35),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
    builder: buildChild,
  );
}

  Widget currentJobSheet()
  {
    return SlidingSheet(
      duration: Duration(milliseconds: 600),
      color: Colors.white,
      shadowColor: Colors.black26,
      elevation: 12,
      controller: controller,
      cornerRadius: 16,
      cornerRadiusOnFullscreen: 0.0,
      addTopViewPaddingOnFullscreen: true,
      isBackdropInteractable: true,
      snapSpec: SnapSpec(
        snap: true,
        positioning: SnapPositioning.relativeToAvailableSpace,
        snappings: const [SnapSpec.headerFooterSnap,0.6,SnapSpec.expanded],
        onSnap: (state, snap) {
          // print('Snapped to $snap');
        },
      ),
      headerBuilder: (context, state)
      {
        return Container(
          height: 190,
          color: AppColours.golden_button_bg,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children:
              [
                Text("${isGuard?"Location":"Source"}: ${isGuard?_currentJobPojo.currentJob.bookings.destinationLocation:_currentJourneyPojo.bookings.arrivalLocation}",style: TextStyle(color: AppColours.black,fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                isGuard?SizedBox(): Text("Destination: ${_currentJourneyPojo.bookings.destinationLocation}",style: TextStyle(color: AppColours.black,fontSize: 16,fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
      builder: currentJobSheetChild,
    );
  }

  Widget currentJobSheetChild(BuildContext context, SheetState state)
  {
  return Container(
    color: AppColours.golden_button_bg,
    padding: EdgeInsets.all(20),
    child: Column(
      children:
      [
        CommonWidgets.blackFullWidthButton("COMPLETE JOB",onClick: (){
          Global.getUser().then((value) async {
            User userinfo = User.fromJson(json.decode(value));
            API(context).jobStartComplete(false, isGuard,userinfo.id,isGuard?_currentJobPojo.currentJob.bookingId:_currentJourneyPojo.bookingId,onSuccess: ()
            {
              getCurrentJob();
            });
          });
        }),
      ],
    ),
  );
}

Widget buildChild(BuildContext context, SheetState state)
{
  return Container(
    color: AppColours.black,
    child: Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonWidgets.requestTextContainer(isGuard?"For":"From",isGuard?guardianBooking.location:journeyBooking.destinationLocation,Icons.location_on_outlined),
          isGuard?SizedBox():CommonWidgets.requestTextContainer("To",journeyBooking.arrivalLocation,Icons.location_on_outlined),
          !isGuard?Row(
            children:
            [
              Expanded(child: CommonWidgets.requestTextContainer("Date","${Global.generateDate(journeyBooking.date)}",Icons.date_range_outlined)),
              SizedBox(width: 20),
              Expanded(child: CommonWidgets.requestTextContainer("Time","${Global.formatTime(journeyBooking.time)}",Icons.time_to_leave_outlined))
            ],
          ):SizedBox(),

          isGuard?CommonWidgets.requestTextContainer("Date","From: ${Global.generateDate(guardianBooking.fromDate)}\nTo: ${Global.generateDate(guardianBooking.toDate)}",Icons.date_range_outlined):SizedBox(),
          isGuard?CommonWidgets.requestTextContainer("Timing","${Global.formatTime(guardianBooking.fromTime)} To: ${Global.formatTime(guardianBooking.toTime)}",Icons.time_to_leave_outlined):SizedBox(),
          isGuard?CommonWidgets.requestTextContainer("Working Days","${guardianBooking.selectDays}",Icons.view_week_outlined):SizedBox(),

          commentBoxText()!=null?CommonWidgets.requestTextContainer("Comments",commentBoxText(),Icons.comment_bank_outlined):SizedBox(),

          SizedBox(height: 10),
          isSheetLoading?Padding(padding: EdgeInsets.all(15),child: Center(child: CommonWidgets.loader(context))):Row(
            children: [
              Expanded(child: RaisedButton(
                color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Reject",style: TextStyle(color: AppColours.white,fontSize: 18),),
                  ),
                  onPressed: ()
                  {
                    Global.getUser().then((value) async {
                      User user = User.fromJson(json.decode(value));
                      driverGuardAcceptReject(true, isGuard, isGuard?guardianBooking.id:journeyBooking.id,user.id);
                    });
                  })),

              SizedBox(width: 20),
              Expanded(child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Accept",style: TextStyle(color: AppColours.white,fontSize: 18))),
                  onPressed: ()
                  {
                    driverGuardAcceptReject(false, isGuard, isGuard?guardianBooking.id:journeyBooking.id,0);
                  })),
            ],
          )
        ],
      ),
    ),
  );
}

driverGuardAcceptReject(bool isRejected,bool isGuardian,int bookingId,int id)
{
  setState(()
  {
    isSheetLoading=true;
  });

  API(context).journeyAcceptReject(isRejected, isGuardian, bookingId,driverGuardID: id,onSuccess: ()
  {
    controller.hide();
    setState(()
    {
      isSheetLoading=false;
    });
    getRequests();
  });
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

showServiceDialog(BuildContext context)
{
  // Create button
  Widget okButton = TextButton(
    child: Text(ifOnline?"Go Offline":"Go Online",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
    onPressed: ()
    {
      setState(()
      {
        ifOnline=!ifOnline;
        API(context).goOnlineOffline(ifOnline,onSuccess: (isOnline) async
        {
            SharedPreferences preferences =await Global.getSharedPref();
            preferences.setBool(Constants.ISONLINE, isOnline);
        });
        if(timer==null)
        {
          startTimer();
        }
        Navigator.of(context).pop();
      });
    },
  );

  Widget cancelButton = TextButton(
    child: Text("Cancel",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
    onPressed: ()
    {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColours.textFeildBG,
      title: Text(ifOnline?"Go Offline":"Go Online",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 20)),
      content: Text(ifOnline?"Do you really want to go Offline?":"Do you really want to go online?",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 14)),
      actions: [cancelButton,okButton]);
  showDialog(
    context: context,
    builder: (BuildContext context)
    {
      return alert;
    },
  );
}

getCurrentJob()
{
    if(!isGuard)
    {
      API(context).getJourneyDetails(onSuccess: (value) {
        Map<String, dynamic> map = json.decode(value);
        setState(() {
          if(map["current_job"]!=null){
            DriverCurrentJobPojo bookingsPojo = DriverCurrentJobPojo.fromJson(json.decode(value));
            isCurrentJob = true;
            _currentJourneyPojo = bookingsPojo.currentJob;
          }
          else{
            isCurrentJob=false;
            _currentJourneyPojo=null;
          }
        });

      });}

   else
    {
      API(context).getJobDetails(onSuccess: (value)
      {
        CurrentJobPojo bookingsPojo= CurrentJobPojo.fromJson(json.decode(value));
        setState(() {
          if(value.currentJob!=null)
          {
            if(bookingsPojo.currentJob.startJob==1)
            {
              isCurrentJob=true;
              _currentJobPojo=value;
            }
            else
              {
              isCurrentJob=false;
              _currentJobPojo=null;
            }
          }
          else{
            isCurrentJob=false;
            _currentJobPojo=null;
          }
        });
      });
    }
}

getRequests()
{
    if(!isGuard)
    {
      API(context).getDriverRequests(false,onSuccess: (value)
      {
        if(value!=null)
        {
          if(value.isNotEmpty)
          {
            if(!isDisposed)
            {
              setState(()
              {
                journeyBooking=value[0].bookings[0];
                isBooking=true;
                controller.show();
              });
            }
          }
          else
            {
            setState(()
            {
              isBooking=false;
            });
          }
        }
      });
    }
    else if(isGuard)
    {
      API(context).getGuardianRequests(false,onSuccess: (value)
      {
        if(value!=null)
        {
          if(value.isNotEmpty)
          {
            if(!isDisposed)
            {
              setState(()
              {
                guardianBooking=value[0].bookings[0];
                isBooking=true;
                controller.show();
              });
            }
          }
          else
            {
            setState(()
            {
              isBooking=false;
            });
          }
        }
      });
    }
}

void _getUserLocation() async {
   /* CameraPosition cc = CameraPosition(
    //  target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cc));*/
}
}