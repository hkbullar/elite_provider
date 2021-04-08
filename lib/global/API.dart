import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elite_provider/dashboard/DashBoardScreen.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/global/PLoader.dart';
import 'package:elite_provider/global/ServiceHttp.dart';
import 'package:elite_provider/pojo/CurrentJobPojo.dart';
import 'package:elite_provider/pojo/DriverCurrentJobPojo.dart';
import 'package:elite_provider/pojo/DriverBookingsPojo.dart';
import 'package:elite_provider/pojo/ErrorPojo.dart';
import 'package:elite_provider/pojo/GetDocumentsPojo.dart';
import 'package:elite_provider/pojo/GuardianBookingsPojo.dart';
import 'package:elite_provider/pojo/LoginPojo.dart';
import 'package:elite_provider/pojo/OnlineOfflinePojo.dart';
import 'package:elite_provider/pojo/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API{
  BuildContext context;
  API(this.context);
  login(Map jsonPost)
  {
  PLoader loader=PLoader(context);
  loader.show();
  ServiceHttp().httpRequestPost("login",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setBool(Constants.ISAPPROVED, false);
          preferences.setString(Constants.USER_ROLE, loginPojo.role);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));

          loader.hide();
          Global.toast(context, "Logged In Successfully\nWelcome to Elite");
          addUserForChat(loginPojo.user);
          Global.userType().then((value)
          {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));

            if(value==Constants.USER_ROLE_DRIVER)
            {
            //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DocumentsScreen(1, true)));
            }
            else if(value==Constants.USER_ROLE_GUARD)
            {
            //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DocumentsScreen(2, true)));
            }
          });
        }, onError: (value) {
          loader.hide();
          Map<String, dynamic> map = json.decode(value);
          CommonWidgets.showMessage(context,map["error"]);
        });
  }

  register(Map jsonPost,int userType){
    PLoader loader=PLoader(context);
    loader.show();
    ServiceHttp().httpRequestPost("register",map: jsonPost,
        onSuccess: (value) async {
          LoginPojo loginPojo= LoginPojo.fromJson(json.decode(value));
          SharedPreferences preferences =await Global.getSharedPref();
          preferences.setString(Constants.TOKEN, loginPojo.token);
          preferences.setString(Constants.USER_ROLE, loginPojo.role);
          preferences.setBool(Constants.ISREGISTERED, true);
          preferences.setBool(Constants.ISAPPROVED, false);
          preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));
          loader.hide();
          Global.toast(context, "Registered Successfully");
          addUserForChat(loginPojo.user);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
        }, onError: (value) {
          loader.hide();
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }

  getDocuments(int userType,{void onSuccess(GetDocumentsPojo value)}){
    Map<String, dynamic> jsonPost =
    {
      Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
    };
    ServiceHttp().httpRequestPost("getDocument",map: jsonPost,
        onSuccess: (value) async {
          GetDocumentsPojo loginPojo= GetDocumentsPojo.fromJson(json.decode(value));
          onSuccess(loginPojo);
        }, onError: (value) {
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }

  goOnlineOffline(bool isOnline,{void onSuccess(bool isOnline)}){

    Map<String, dynamic> jsonPost = {"status": isOnline?1:0};

    ServiceHttp().httpRequestPost("online-offline",map: jsonPost,
        onSuccess: (value){
          OnlineOfflinePojo pojo= OnlineOfflinePojo.fromJson(json.decode(value));
          if(pojo.user.onlineOffline==1){
           onSuccess(true);
          }else{
            onSuccess(false);
          }
        }, onError: (value) {
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }

  getDriverRequests(bool isAccepted,{void onSuccess(List<DriverBookingPojo> booking)}){

    Map<String, dynamic> jsonPost = {"status": isAccepted?1:0};

    ServiceHttp().httpRequestPost("getDriverBooking",map: jsonPost,
        onSuccess: (value){
          DriverBookingsPojo bookingsPojo= DriverBookingsPojo.fromJson(json.decode(value));
          onSuccess(bookingsPojo.booking);
        }, onError: (value) {
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }

  getGuardianRequests(bool isAccepted,{void onSuccess(List<GuardianBookingPojo> booking)}){

    Map<String, dynamic> jsonPost = {"status": isAccepted?1:0};

    ServiceHttp().httpRequestPost("getGuardBooking",map: jsonPost,
        onSuccess: (value){
          GuardianBookingsPojo bookingsPojo= GuardianBookingsPojo.fromJson(json.decode(value));
          onSuccess(bookingsPojo.booking);
        }, onError: (value) {
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }

  journeyAcceptReject(bool isRejected,bool isGuardian,int bookingID,{void onSuccess(),int driverGuardID}){
    String apiName="";
    Map<String, dynamic> jsonPost ={};
    if(isRejected && isGuardian)
    {
      apiName="reject-guard-booking";
      jsonPost ={
        Constants.REQUEST_AR_BOOKING_ID:bookingID,
        Constants.REQUEST_AR_GUARDIAN_ID:driverGuardID
      };
    }
    else if(!isRejected && isGuardian){

      apiName="accept-guradian-booking";

      jsonPost ={Constants.REQUEST_AR_BOOKING_ID:bookingID};
    }
    else if (isRejected && !isGuardian){
      apiName="reject-driver-booking";
      jsonPost={
        Constants.REQUEST_AR_BOOKING_ID:bookingID,
        Constants.REQUEST_AR_DRIVER_ID:driverGuardID
      };
    }
    else{
      apiName="accept-driver-booking";

      jsonPost = {Constants.REQUEST_AR_BOOKING_ID:bookingID};
    }
    ServiceHttp().httpRequestPost(apiName,map: jsonPost,
        onSuccess: (value) async {
      print(value);
          onSuccess();
        }, onError: (value) {
          CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
        });
  }
jobStartComplete(bool isInProgress,bool isGuardian,int driverId,int bookingId,{void onSuccess()}){
  String apiName="";
  Map<String, dynamic> jsonPost ={};
if(isInProgress && isGuardian){
  apiName="start_guardian_job";
  jsonPost ={
    Constants.JOB_SC_BOOKING_ID:bookingId,
    Constants.JOB_SC_CREATED_BY:driverId,
    Constants.JOB_SC_JOB_STATUS:1,
    Constants.JOB_SC_DRIVER_ID:driverId
  };
}
else if(!isInProgress && isGuardian){
  apiName="change_guard_start_job_status";
  jsonPost ={
    Constants.JOB_SC_BOOKING_ID:bookingId,
    Constants.JOB_SC_JOB_STATUS:2,
    Constants.JOB_SC_DRIVER_ID:driverId
  };
}
else if(isInProgress && !isGuardian){
  apiName="start_job";
  jsonPost ={
    Constants.JOB_SC_BOOKING_ID:bookingId,
    Constants.JOB_SC_CREATED_BY:driverId,
    Constants.JOB_SC_JOB_STATUS:1,
    Constants.JOB_SC_DRIVER_ID:driverId
  };
}
else{
  apiName="change_driver_start_job_status";
  jsonPost ={
    Constants.JOB_SC_BOOKING_ID:bookingId,
    Constants.JOB_SC_JOB_STATUS:2,
    Constants.JOB_SC_DRIVER_ID:driverId
  };
}
  ServiceHttp().httpRequestPost(apiName,map: jsonPost,
      onSuccess: (value) async {
        print(value);
        onSuccess();
      }, onError: (value) {
    print(value);
        CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
      });
}
getJourneyDetails({void onSuccess(dynamic booking)}){
  ServiceHttp().httpRequestGet("get_current_driver_job",
      onSuccess: (value){
    print(value);
        onSuccess(value);
      }, onError: (value) {
        CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
      });
}

getJobDetails({void onSuccess(dynamic booking)})
{
  ServiceHttp().httpRequestGet("get_current_guard_job",
      onSuccess: (value){
        onSuccess(value);
      }, onError: (value)
      {
        CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
      });
}

  addUserForChat(User user) async {
    await Location().getLocation().then((loc) async => {
    await FirebaseFirestore.instance.collection(Constants.USER_TABLE).where(Constants.USER_ID_F, isEqualTo: user.id).get().then((value) async {
    if(value.size==0) {
    FirebaseFirestore.instance.collection(Constants.USER_TABLE).doc(
    '${user.id}').set(
    {
    Constants.USER_NAME: user.name,
    Constants.USER_ID_F: user.id,
    Constants.USER_EMAIL: user.email,
    Constants.USER_LATITUDE: loc.latitude,
    Constants.USER_LONGITUDE: loc.longitude,
    });
    }
    else{
    FirebaseFirestore.instance.collection(Constants.USER_TABLE).doc(
    '${user.id}').update(
    {
    Constants.USER_NAME: user.name,
    Constants.USER_ID_F: user.id,
    Constants.USER_EMAIL: user.email,
    Constants.USER_LATITUDE: loc.latitude,
    Constants.USER_LONGITUDE: loc.longitude,
    });
    }
    })
    });
  }

  updateUserLocation(LocationData loc){
    Global.getUser().then((value) async {
        User user = User.fromJson(json.decode(value));
        FirebaseFirestore.instance.collection(Constants.USER_TABLE).doc(
            '${user.id}').update(
            {
              Constants.USER_NAME: user.name,
              Constants.USER_ID_F: user.id,
              Constants.USER_EMAIL: user.email,
              Constants.USER_LATITUDE: loc.latitude,
              Constants.USER_LONGITUDE: loc.longitude,
            });

      Map<String, dynamic> jsonPost =
      {
      Constants.UPDATE_L_USER_ID: user.id,
      Constants.UPDATE_L_LATITUDE: loc.latitude,
      Constants.UPDATE_L_LONGITUDE: loc.longitude,
      };
        ServiceHttp().httpRequestPost("update_latitude_longitude",map: jsonPost,
            onSuccess: (value){
            }, onError: (value) {
              CommonWidgets.showMessage(context, ErrorPojo.fromJson(json.decode(value)).errors.error[0]);
            });
    });

  }

  changePassword(Map jsonPost){
    PLoader loader=PLoader(context);
    loader.show();
    ServiceHttp().httpRequestPost("change-password-user",map: jsonPost,
        onSuccess: (value) async {
          loader.hide();
          Map<String, dynamic> map = json.decode(value);
          int status=map["status"];
          if(status==200 || status==201)
          {
            Global.toast(context, "Password Changed Successfully");
            Navigator.of(context).pop();
          }
          else
          {
            CommonWidgets.showMessage(context,map["message"]);
          }
        }, onError: (value) {
          loader.hide();
          Map<String, dynamic> map = json.decode(value);
          CommonWidgets.showMessage(context,map["error"]);
        });
  }
}