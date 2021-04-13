
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
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
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import '../global/API.dart';
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(30.5882408,76.8438542);
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
bool isResumed=true;

SheetController controller = SheetController();
SheetController currentJobController = SheetController();

Location location;

Timer timer;

//MAP AND TRACKING KEYS AND DATA
Completer<GoogleMapController> _controller = Completer();
Set<Marker> _markers = Set<Marker>();
Set<Polyline> _polylines = Set<Polyline>();
List<LatLng> polylineCoordinates = [];
PolylinePoints polylinePoints;
String googleAPIKey = "AIzaSyD3hJNvatQ8W1cPBS4ZeLS8U8T5x0YQqMY";
double requestSheetTitleHeight=0;
LocationData currentLocation;

@override
void initState()
{
    location = new Location();
    polylinePoints = PolylinePoints();

  WidgetsBinding.instance.addObserver(this);
    super.initState();
}

registerOnChangeListener()
{
  if(isCurrentJob){
    Location().onLocationChanged.listen((LocationData currentLocation)
    {
      API(context).updateUserLocation(currentLocation);
      this.currentLocation = currentLocation;
      if(isCurrentJob)
        updatePinOnMap();
    });
  }
}

startTimer()
{
  timer= Timer.periodic(Duration(seconds: 10), (timer)
  {
      if(ifOnline)
      {
        getRequests();
      }
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
  if(state==AppLifecycleState.resumed)
 {
   isResumed=true;
   startTimer();
 }
  if(state==AppLifecycleState.paused)
  {
  isResumed=false;
  }
}

@override
Widget build(BuildContext context)
{
  CameraPosition initialCameraPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION
  );
  if (currentLocation != null) {
    initialCameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude,
            currentLocation.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING
    );
  }
  return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          GoogleMap(
              myLocationEnabled: true,
              compassEnabled: true,
              tiltGesturesEnabled: false,
              markers: _markers,
              polylines: _polylines,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                if(!_controller.isCompleted){
                  _controller.complete(controller);
                }
                Global.isOnline().then((isOnline)
                {

                  setState(() {
                    this.ifOnline=isOnline;
                  });
                });
                Global.userType().then((value)
                {

                  if(value==Constants.USER_ROLE_DRIVER)
                  {
                    isGuard=false;
                  }
                  if(value==Constants.USER_ROLE_GUARD)
                  {

                    isGuard=true;
                  }
                  getCurrentLocation();
                });

              }),
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
                      showOnlineOfflineDialogue(context);
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
       // print('Snapped to $snap');
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
      controller: currentJobController,
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
          height: 190+requestSheetTitleHeight,
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
        SizedBox(height: requestSheetTitleHeight)
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
          isGuard?CommonWidgets.requestTextContainer("Working Days",getDaysString(guardianBooking.selectDays),Icons.view_week_outlined):SizedBox(),

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

showOnlineOfflineDialogue(BuildContext context)
{
  // Create button
  Widget okButton = TextButton(
    child: Text(ifOnline?"Go Offline":"Go Online",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
    onPressed: ()
    {
      userOnlineOfflineAPI();
      Navigator.of(context).pop();
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

userOnlineOfflineAPI()
{
    API(context).goOnlineOffline(!ifOnline,onSuccess: (isOnline) async
    {
      bool newStatus=!ifOnline;
      SharedPreferences preferences =await Global.getSharedPref();
      preferences.setBool(Constants.ISONLINE, newStatus);
      if(newStatus){
        if(timer==null)
        {
          startTimer();
        }
      }
      else{
        stopTimer();
      }
      setState((){
        ifOnline=newStatus;
      });
    });
  }

void updatePinOnMap() async
{
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,
          currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() async {
      // updated position
      var pinPosition = LatLng(currentLocation.latitude,currentLocation.longitude);

      _markers.removeWhere((m) => m.markerId.value == "current");
      _markers.add(Marker(
        markerId: MarkerId("current"),
        position: pinPosition,
          icon: BitmapDescriptor.fromBytes(await getCurrentMarkerIcon())// updated position
      ));
    });
  }

getCurrentJob()
{
    if(!isGuard)
    {
      API(context).getJourneyDetails(onSuccess: (value) {
        Map<String, dynamic> map = json.decode(value);
          if(map["current_job"]!=null){
            DriverCurrentJobPojo bookingsPojo = DriverCurrentJobPojo.fromJson(json.decode(value));
            isCurrentJob = true;
            _currentJourneyPojo = bookingsPojo.currentJob;
            showPinsOnMapForJourney(bookingsPojo.currentJob.bookings.arrivalLat, bookingsPojo.currentJob.bookings.arrivalLong, bookingsPojo.currentJob.bookings.destinationLat, bookingsPojo.currentJob.bookings.destinationLong);
            Global.setJobInProgress(true);
            currentJobController.show();
            if(!ifOnline){
              userOnlineOfflineAPI();
            }
            else{
              startTimer();
            }
            registerOnChangeListener();
          }
          else{
            _markers = Set<Marker>();
            _polylines = Set<Polyline>();

            isCurrentJob=false;
            _currentJourneyPojo=null;
            Global.setJobInProgress(false);
            startTimer();
          }
      });}

    else
    {
      API(context).getJobDetails(onSuccess: (value)
      {
        Map<String, dynamic> map = json.decode(value);
        setState(() {
          if(map["current_job"]!=null){
            CurrentJobPojo bookingsPojo= CurrentJobPojo.fromJson(json.decode(value));
            isCurrentJob=true;
            _currentJobPojo=bookingsPojo;
            Global.setJobInProgress(true);
            showPinOnMapForGuardian();
            if(!ifOnline){
              userOnlineOfflineAPI();
            }
            else{
              startTimer();
            }
            registerOnChangeListener();
          }
          else{
            isCurrentJob=false;
            _currentJobPojo=null;
            Global.setJobInProgress(false);
            startTimer();
          }
        });
      });
    }
  }

getCurrentLocation() async
{
  await location.getLocation().then((value) async {
    currentLocation =value;
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,
          currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    getCurrentJob();
  });
}

getRequests()
{
    if(!isGuard)
    {
      API(context).getDriverRequests(false,onSuccess: (value)
      {
        if (!isDisposed && isResumed){
          if(value!=null && value.isNotEmpty) {
            setState(() {
              journeyBooking = value[0].bookings[0];
              isBooking = true;
              controller.show();
              requestSheetTitleHeight = 70;
            });
          }
          else
          {
            setState((){
              isBooking=false;
              requestSheetTitleHeight=0;
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
                requestSheetTitleHeight=70;
              });
            }
          }
          else
            {
              setState(()
            {
              isBooking=false;
              requestSheetTitleHeight=0;
            });
          }
        }
      });
    }
}

showPinsOnMapForJourney(String aLat,String aLng,String dLat,dLng)async
{
  if(currentLocation!=null){
    var currentPosition = LatLng(currentLocation.latitude,currentLocation.longitude);
    _markers.add(Marker(
        markerId: MarkerId('current'),
        position: currentPosition,
        icon: BitmapDescriptor.fromBytes(await getCurrentMarkerIcon())
    ));
  }
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(double.tryParse(aLat),
        double.tryParse(aLng));
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(double.tryParse(dLat),
        double.tryParse(dLng));
    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition
    ));
    // destination pin
    _markers.add(Marker(
      markerId: MarkerId('destPin'),
      position: destPosition,
    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines(aLat,aLng,dLat,dLng);
  }

Future<Uint8List> getCurrentMarkerIcon() async
{
  return  await getBytesFromAsset('assets/images/ic_car_black.png',120);
}

void showPinOnMapForGuardian()
{
    if(currentLocation!=null){
      setState(() {
        var currentPosition = LatLng(currentLocation.latitude,currentLocation.longitude);
        _markers.add(Marker(
            markerId: MarkerId('current'),
            position: currentPosition
        ));
      });
    }
  }

void setPolylines(String aLat,String aLng,String dLat,dLng) async
{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,PointLatLng(
        double.tryParse(aLat),
        double.tryParse(aLng)),PointLatLng(
        double.tryParse(dLat),
        double.tryParse(dLng)));
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude,point.longitude)
        );
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: AppColours.textFeildBG,
            points: polylineCoordinates
        ));
      });
    }
  }

Future<Uint8List> getBytesFromAsset(String path, int width) async
{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

String getDaysString(List<String> daysList){
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
}