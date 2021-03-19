

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elite_provider/global/API.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/EliteAppBar.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/global/PLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentsScreen extends StatefulWidget
{
  int userType;
  DocumentsScreen(this.userType);
  @override
  _DocumentsScreenState createState() => _DocumentsScreenState(userType);
}

class _DocumentsScreenState extends State<DocumentsScreen> {

  _DocumentsScreenState(this.userType);

  int userType;
  PLoader loader;
  File _liveImage,_rcImage,_idImage;
  @override
  void initState() {
    loader=PLoader(context);
    getDocumentsAPI();
    super.initState();
  }
  final picker = ImagePicker();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: AppColours.black,
        key: scaffoldKey,
      appBar: EliteAppBar("Upload Documents"),
      body: Padding(
        padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Live Picture",style: TextStyle(color: AppColours.white,fontSize: 18),),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      selectPickerType(0);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColours.textFeildBG,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 4,color: AppColours.off_white)
                      ),
                      height: Global.getHeight(context,divider: 7),
                      child: _liveImage!=null?Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(_liveImage),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              alignment: Alignment.topRight,
                              onPressed: (){
                                setState(() {
                                  _liveImage=null;
                                });
                              },
                              icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
                            ),
                          )
                        ],
                      ) :Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70),
                    ),
                  ),
                ),
              ],
            ),
          userType==1?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Vehicle Registration",style: TextStyle(color: AppColours.white,fontSize: 18),),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){selectPickerType(1);},
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColours.textFeildBG,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 4,color: AppColours.off_white)
                        ),
                        height: Global.getHeight(context,divider: 7),
                        child: _rcImage!=null?Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(_rcImage),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                alignment: Alignment.topRight,
                                onPressed: (){
                                  setState(() {
                                    _rcImage=null;
                                  });
                                },
                                icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
                              ),
                            )
                          ],
                        ):Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ):SizedBox(),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("ID Proof",style: TextStyle(color: AppColours.white,fontSize: 18),),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      selectPickerType(2);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColours.textFeildBG,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 4,color: AppColours.off_white)
                      ),
                      height: Global.getHeight(context,divider: 7),
                      child: _idImage!=null?Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(_idImage),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              alignment: Alignment.topRight,
                              onPressed: (){
                                setState(() {
                                  _idImage=null;
                                });
                              },
                              icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
                            ),
                          )
                        ],
                      ):Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CommonWidgets.goldenFullWidthButton("Upload Documents",onClick: (){
              uploadButtonClick();
            }),
          ],
        ),
      )
    );
  }

  uploadButtonClick() async {


      loader.show();
      uploadPicProfile();


  }
uploadPicProfile() async {
  Map<String, dynamic> jsonPost =
  {
    Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
    Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_PROFILE_PIC,
  };
  FormData formData=FormData.fromMap(jsonPost);
  formData.files.add(MapEntry(Constants.DOCUMENT_IMAGE, await MultipartFile.fromFile(_liveImage.path)));
  var token = await Global.getToken();
  Dio dio = new Dio();
  dio.options.baseUrl="https://eliteguardian.co.uk/api/";
  dio.options.headers["Authorization"] = 'Bearer '+token;
  dio.post("update-doc", data: formData).then((value) async {
  if(value.statusCode==200 || value.statusCode==201){
  Map<String, dynamic> map = json.decode(value.toString());

  uploadPicID();
  //loader.hide();
  Global.toast(context, map["message"]);
  }
  else{
    loader.hide();
    Global.toast(context, value.statusMessage);
  }
  });
}

uploadPicID() async {
  Map<String, dynamic> jsonPost =
  {
    Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
    Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_ID_PIC,
  };
  FormData formData=FormData.fromMap(jsonPost);
  formData.files.add(MapEntry(Constants.DOCUMENT_IMAGE, await MultipartFile.fromFile(_idImage.path)));
  var token = await Global.getToken();
  Dio dio = new Dio();
  dio.options.baseUrl="https://eliteguardian.co.uk/api/";
  dio.options.headers["Authorization"] = 'Bearer '+token;
  dio.post("update-doc", data: formData).then((value) async {
  if(value.statusCode==200 || value.statusCode==201){
  Map<String, dynamic> map = json.decode(value.toString());

  if(userType==1)
  {
    uploadPicRC();
  }
  else{
    loader.hide();
  }
  Global.toast(context, map["message"]);
  }
  else{
    loader.hide();
    Global.toast(context, value.statusMessage);
  }
  });
}
uploadPicRC() async {
  Map<String, dynamic> jsonPost =
  {
    Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
    Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_RC_PIC,
  };
  FormData formData=FormData.fromMap(jsonPost);
  formData.files.add(MapEntry(Constants.DOCUMENT_IMAGE, await MultipartFile.fromFile(_rcImage.path)));
  var token = await Global.getToken();
  Dio dio = new Dio();
  dio.options.baseUrl="https://eliteguardian.co.uk/api/";
  dio.options.headers["Authorization"] = 'Bearer '+token;
  dio.post("update-doc", data: formData).then((value) async {
  if(value.statusCode==200 || value.statusCode==201){
  Map<String, dynamic> map = json.decode(value.toString());
  loader.hide();
  Global.toast(context, map["message"]);
  }
  else{Global.toast(context, value.statusMessage);}
  });
}
  Future getImage(int fileType,ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        if(fileType==0){_liveImage = File(pickedFile.path);}
        if(fileType==1){_rcImage = File(pickedFile.path);}
        if(fileType==2){_idImage = File(pickedFile.path);}
      } else {
        print('No image selected.');
      }
    });
  }

  bool validate(){
    if(_liveImage==null){
      CommonWidgets.showMessage(context,"Please enter your latest clear Picture");
      return false;
    }
    else if(userType==1 && _rcImage!=null){
      CommonWidgets.showMessage(context,"Please upload the Pic of your vehicle registration");
      return false;
    }
    else if(_idImage==null){
      CommonWidgets.showMessage(context,"Please Upload the image of your identity proof");
      return false;
    }
    return true;
  }

  selectPickerType(int fileType){
    scaffoldKey.currentState.showBottomSheet(
            (context) => Container(
          height: Global.getHeight(context,divider: 3),
          padding: EdgeInsets.all(25),
          color: AppColours.golden_button_bg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pick Photo from :",style: TextStyle(color: AppColours.textFeildBG,fontSize: 22,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30),
                    CommonWidgets.blackFullWidthButton("Camera",onClick:() =>getImage(fileType,ImageSource.gallery)),
                    SizedBox(height: 30,),
                    CommonWidgets.blackFullWidthButton("Gallery",onClick: ()=>getImage(fileType,ImageSource.camera)),
            ],
          ),
        ));
  }
  getDocumentsAPI(){
    API(context).getDocuments(userType,onSuccess: (value){
     print(value.message);
    });
  }
}