

import 'dart:io';

import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/EliteAppBar.dart';
import 'package:elite_provider/global/Global.dart';
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

  File _liveImage,_rcImage,_idImage;

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

            SizedBox(height: 20,),
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
            SizedBox(height: 20,),
            CommonWidgets.goldenFullWidthButton("Upload Documents",onClick: (){

            }),
          ],
        ),
      )
    );
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
  selectPickerType(int fileType){
    scaffoldKey.currentState
        .showBottomSheet(
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
}