/*
//
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:elite_provider/dashboard/DashBoardScreen.dart';
// import 'package:elite_provider/global/API.dart';
// import 'package:elite_provider/global/AppColours.dart';
// import 'package:elite_provider/global/CommonWidgets.dart';
// import 'package:elite_provider/global/Constants.dart';
// import 'package:elite_provider/global/EliteAppBar.dart';
// import 'package:elite_provider/global/Global.dart';
// import 'package:elite_provider/global/PLoader.dart';
// import 'package:elite_provider/pojo/GetDocumentsPojo.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../global/CommonWidgets.dart';
// import '../pojo/User.dart';
//
// class DocumentsScreen extends StatefulWidget
// {
//  final int userType;
//  final bool isLogin;
//   DocumentsScreen(this.userType,this.isLogin);
//   @override
//   _DocumentsScreenState createState() => _DocumentsScreenState(userType,isLogin);
// }
//
// class _DocumentsScreenState extends State<DocumentsScreen> {
//
//   _DocumentsScreenState(this.userType,this.isLogin);
//
//   int userType;
//   PLoader loader;
//   bool isLogin;
//   File _liveImage,_rcImage,_idImage;
//   DocDetail _liveImageDoc,_rcImageDoc,_idImageDoc;
//   bool _loading = false;
//   bool uploadButtonVisibility=false;
//   User userinfo;
//   @override
//   void initState() {
//     loader=PLoader(context);
//     Global.getUser().then((value) async {
//       setState(()
//       {
//         userinfo = User.fromJson(json.decode(value));
//       });
//
//     });
//     if(isLogin){
//       _loading=true;
//       getDocumentsAPI();
//     }
//     buttonView();
//     super.initState();
//   }
//   final picker = ImagePicker();
//
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return Scaffold(
//       backgroundColor: AppColours.black,
//       key: scaffoldKey,
//       appBar: EliteAppBar("Upload Documents"),
//       body: _loading?Center(child: screenloader(context)):SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: userinfo!=null?Text("Hello ${userinfo.name} you won't be able to Enter to the app till all of your documents get verified.",textAlign: TextAlign.center,style: TextStyle(color: AppColours.white,fontSize: 14),):SizedBox(),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Live Picture",style: TextStyle(color: AppColours.white,fontSize: 18),),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: (){
//                         if(_liveImage==null){
//                           if(_liveImageDoc==null){
//                             selectPickerType(0);
//                           }
//                           else{
//                             if(_liveImageDoc.approve==2){
//                               selectPickerType(0);
//                             }
//                           }
//                         }
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: AppColours.textFeildBG,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           border: Border.all(width: 4,color: AppColours.off_white)
//                         ),
//                         height: Global.getHeight(context,divider: 7),
//                         child: _liveImageDoc==null && _liveImage!=null?Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.file(_liveImage),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: IconButton(
//                                 alignment: Alignment.topRight,
//                                 onPressed: (){
//                                   setState(() {
//                                     _liveImage=null;
//                                     buttonView();
//                                   });
//                                 },
//                                 icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
//                               ),
//                             )
//                           ],
//                         ) :_liveImageDoc!=null?Stack(
//                             alignment: Alignment.center,
//                           children: [
//                             CommonWidgets.networkImage(_liveImageDoc.image),
//                             _liveImageDoc.approve==0?Text("Awaiting Approval",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColours.white),):_liveImageDoc.approve==1?Text("Accepted",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),):SizedBox(),
//                             _liveImageDoc.approve==2?Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70):SizedBox()
//                           ],
//                         ):Icon(Icons.add_circle_outline,color: AppColours.white,size: 70),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               _liveImageDoc!=null && _liveImageDoc.approve==2?Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Image rejected please upload a new Image",style: TextStyle(color: AppColours.red_logOut,fontSize: 18),),
//               ):SizedBox(),
//             userType==1?Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Vehicle Registration",style: TextStyle(color: AppColours.white,fontSize: 18),),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: (){
//                           if(_rcImage==null){
//                             if(_rcImageDoc==null){
//                               selectPickerType(1);
//                             }
//                             else{
//                               if(_rcImageDoc.approve==2){
//                                 selectPickerType(1);
//                               }
//                             }
//                           }
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: AppColours.textFeildBG,
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               border: Border.all(width: 4,color: AppColours.off_white)
//                           ),
//                           height: Global.getHeight(context,divider: 7),
//                           child:_rcImageDoc==null && _rcImage!=null?Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Image.file(_rcImage),
//                               Positioned(
//                                 top: 0,
//                                 right: 0,
//                                 child: IconButton(
//                                   alignment: Alignment.topRight,
//                                   onPressed: (){
//                                     setState(() {
//                                       _rcImage=null;
//                                       buttonView();
//                                     });
//                                   },
//                                   icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
//                                 ),
//                               )
//                             ],
//                           ) :_rcImageDoc!=null?Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               CommonWidgets.networkImage(_rcImageDoc.image),
//                               _rcImageDoc.approve==0?Text("Awaiting Approval",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColours.white),):_rcImageDoc.approve==1?Text("Accepted",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),):SizedBox(),
//                               _rcImageDoc.approve==2?Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70):SizedBox()
//                             ],
//                           ):Icon(Icons.add_circle_outline,color: AppColours.white,size: 70),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 _rcImageDoc!=null && _rcImageDoc.approve==2?Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Image rejected please upload a new Image",style: TextStyle(color: AppColours.red_logOut,fontSize: 18),),
//                 ):SizedBox(),
//               ],
//             ):SizedBox(),
//               SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("ID Proof",style: TextStyle(color: AppColours.white,fontSize: 18)),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                       onTap: (){
//                         if(_idImage==null){
//                           if(_idImageDoc==null){
//                             selectPickerType(2);
//                           }
//                           else{
//                             if(_idImageDoc.approve==2){
//                               selectPickerType(2);
//                             }
//                           }
//                         }
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: AppColours.textFeildBG,
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             border: Border.all(width: 4,color: AppColours.off_white)
//                         ),
//                         height: Global.getHeight(context,divider: 7),
//                         child: _idImageDoc==null && _idImage!=null?Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.file(_idImage),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: IconButton(
//                                 alignment: Alignment.topRight,
//                                 onPressed: (){
//                                   setState(() {
//                                     _idImage=null;
//                                     buttonView();
//                                   });
//                                 },
//                                 icon:  Icon(Icons.close,size: 30,color: AppColours.golden_button_bg),
//                               ),
//                             )
//                           ],
//                         ) :_idImageDoc!=null?Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             CommonWidgets.networkImage(_idImageDoc.image),
//                             _idImageDoc.approve==0?Text("Awaiting Approval",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColours.white),):_idImageDoc.approve==1?Text("Accepted",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.green),):SizedBox(),
//                             _idImageDoc.approve==2?Icon(Icons.add_circle_outline,color: AppColours.off_white,size: 70):SizedBox()
//                           ],
//                         ):Icon(Icons.add_circle_outline,color: AppColours.white,size: 70),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               _idImageDoc!=null && _idImageDoc.approve==2?Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text("Image rejected please upload a new Image",style: TextStyle(color: AppColours.red_logOut,fontSize: 18),),
//               ):SizedBox(),
//               uploadButtonVisibility?SizedBox(height: 20):SizedBox(),
//               uploadButtonVisibility?CommonWidgets.goldenFullWidthButton("Upload Documents",onClick: (){
//                 uploadButtonClick();
//               }):SizedBox(),
//               SizedBox(height: 20),
//               CommonWidgets.goldenFullWidthButton(isLogin?"Login with other account?":"Register with other email?",onClick: (){
//                showLogOutDialog(context);
//               }),
//             ],
//           ),
//         ),
//       )
//     );
//   }
//
//   uploadButtonClick() {
//       if(isLogin){
//         if(_liveImage!=null){
//           uploadPicProfile();
//         }
//         else if(_idImage!=null){
//           uploadPicID();
//         }
//         else if(_rcImage!=null){
//           uploadPicRC();
//         }
//       }
//       else{
//         if(validate()){
//           uploadPicProfile();
//         }
//       }
//   }
//
//   screenloader(BuildContext context){
//     return  CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(AppColours.golden_button_bg),
//     );
//   }
//
// uploadPicProfile() async {
//   loader.show();
//   if(_liveImageDoc!=null){
//
//   }else{
//
//   }
//   Map<String, dynamic> jsonPost =
//   {
//     Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
//     Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_PROFILE_PIC,
//     Constants.DOCUMENT_IMAGE: await MultipartFile.fromPath("picture", _liveImage.path),
//   };
//   FormData formData=FormData.from(jsonPost);
//   var token = await Global.getToken();
//   Dio dio = new Dio();
//   dio.options.baseUrl="https://eliteguardian.co.uk/api/";
//   dio.options.headers["Authorization"] = 'Bearer '+token;
//   dio.post("update-doc", data: formData).then((value) async {
//   if(value.statusCode==200 || value.statusCode==201){
//   if(_idImageDoc!=null){
//     uploadPicID();
//   }
//   }
//   else{
//     loader.hide();
//     Global.toast(context, value.statusMessage);
//   }
//   });
// }
//
// uploadPicID() async {
//   Map<String, dynamic> jsonPost =
//   {
//     Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
//     Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_ID_PIC,
//     Constants.DOCUMENT_IMAGE: await MultipartFile.fromPath("picture", _idImage.path),
//   };
//   FormData formData=FormData.from(jsonPost);
//   var token = await Global.getToken();
//   Dio dio = new Dio();
//   dio.options.baseUrl="https://eliteguardian.co.uk/api/";
//   dio.options.headers["Authorization"] = 'Bearer '+token;
//   dio.post("update-doc", data: formData).then((value) async {
//   if(value.statusCode==200 || value.statusCode==201){
//   Map<String, dynamic> map = json.decode(value.toString());
//
//   if(userType==1)
//   {
//     if(_rcImage!=null){
//       uploadPicRC();
//     }
//   }
//   else{
//     getDocumentsAPI();
//     loader.hide();
//   }
//   Global.toast(context, map["message"]);
//   }
//   else{
//     loader.hide();
//     Global.toast(context, value.statusMessage);
//   }
//   });
// }
//
// uploadPicRC() async {
//   Map<String, dynamic> jsonPost =
//   {
//     Constants.DOCUMENT_USER_TYPE: userType==1?Constants.DOCUMENT_USER_TYPE_DRIVER:Constants.DOCUMENT_USER_TYPE_GUARDIAN,
//     Constants.DOCUMENT_IMAGE_TYPE: Constants.DOCUMENT_RC_PIC,
//     Constants.DOCUMENT_IMAGE: await MultipartFile.fromPath("picture", _rcImage.path),
//   };
//   FormData formData=FormData.from(jsonPost);
//   var token = await Global.getToken();
//   Dio dio = new Dio();
//   dio.options.baseUrl="https://eliteguardian.co.uk/api/";
//   dio.options.headers["Authorization"] = 'Bearer '+token;
//   dio.post("update-doc", data: formData).then((value) async {
//   if(value.statusCode==200 || value.statusCode==201){
//   Map<String, dynamic> map = json.decode(value.toString());
//   loader.hide();
//   getDocumentsAPI();
//   Global.toast(context, map["message"]);
//   }
//   else{Global.toast(context, value.statusMessage);}
//   });
// }
//   Future getImage(int fileType,ImageSource source) async {
//     final pickedFile = await ImagePicker.pickImage(
//       maxHeight: 250,
//         maxWidth: 250,
//         imageQuality: 50,
//         source: source
//     );
//
//     setState(() {
//       if (pickedFile != null) {
//         if(fileType==0){
//           _liveImageDoc=null;
//           _liveImage = File(pickedFile.path);
//         }
//         if(fileType==1)
//         {
//           _rcImageDoc=null;
//           _rcImage = File(pickedFile.path);
//         }
//         if(fileType==2){
//           _idImageDoc=null;
//           _idImage = File(pickedFile.path);
//         }
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//   bool validate(){
//     if(_liveImage==null){
//       CommonWidgets.showMessage(context,"Please enter your latest clear Picture");
//       return false;
//     }
//     else if(userType==1 && _rcImage!=null){
//       CommonWidgets.showMessage(context,"Please upload the Pic of your vehicle registration");
//       return false;
//     }
//     else if(_idImage==null){
//       CommonWidgets.showMessage(context,"Please Upload the image of your identity proof");
//       return false;
//     }
//     return true;
//   }
//
//   selectPickerType(int fileType){
//     scaffoldKey.currentState.showBottomSheet(
//             (context) => Container(
//           height: Global.getHeight(context,divider: 3),
//           padding: EdgeInsets.all(25),
//           color: AppColours.golden_button_bg,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Pick Photo from :",style: TextStyle(color: AppColours.textFeildBG,fontSize: 22,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 30),
//                     CommonWidgets.blackFullWidthButton("Camera",onClick:() {
//                       Navigator.of(context).pop();
//                       getImage(fileType,ImageSource.camera);
//                       }
//                    ),
//                     SizedBox(height: 30,),
//                     CommonWidgets.blackFullWidthButton("Gallery",onClick: () {
//                       Navigator.of(context).pop();
//                       getImage(fileType,ImageSource.gallery);
//                     }),
//             ],
//           ),
//         ));
//   }
//   getDocumentsAPI(){
//     API(context).getDocuments(userType,onSuccess: (value){
//       verifyDocuments();
//       setState(() {
//         _loading=false;
//         if(value.docDetails.isNotEmpty){
//           setImage(value.docDetails[0]);
//           if(value.docDetails.length>1){
//             setImage(value.docDetails[1]);
//           }
//             if (value.docDetails.length > 2) {
//               setImage(value.docDetails[2]);
//             }
//         }
//       });
//     });
//   }
// setImage(DocDetail value){
//   if(value.imageType==Constants.DOCUMENT_PROFILE_PIC)
//     _liveImageDoc=value;
//   if(value.imageType==Constants.DOCUMENT_ID_PIC)
//     _idImageDoc=value;
//   if(value.imageType==Constants.DOCUMENT_RC_PIC)
//     _rcImageDoc=value;
//
//
// }
//
//   verifyDocuments() async {
//     if(_liveImageDoc!=null && _idImageDoc!=null && _rcImageDoc!=null){
//       if(_liveImageDoc.approve==1 && _idImageDoc.approve==1 && _rcImageDoc.approve==1){
//         SharedPreferences preferences =await Global.getSharedPref();
//         preferences.setBool(Constants.ISAPPROVED, true);
//         loader.hide();
//         Global.toast(context, "Documents Approved Successfully\nWelcome to Elite");
//         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoardScreen()));
//       }
//     }
//   }
//   buttonView(){
//     bool showButton=false;
//     if(_liveImage==null && _idImage==null && _rcImage==null){
//
//     }
//     setState(() {
//       uploadButtonVisibility=showButton;
//     });
//   }
//   showLogOutDialog(BuildContext context) {
//     // Create button
//     Widget okButton = TextButton(
//       child: Text("Log Out",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
//       onPressed: () {
//         setState(() {
//           Navigator.of(context).pop();
//           Global.removePreferences(context);
//         });
//       },
//     );
//     Widget cancelButton = TextButton(
//       child: Text("Cancel",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     // Create AlertDialog
//     AlertDialog alert = AlertDialog(
//         backgroundColor: AppColours.textFeildBG,
//         title: Text("Log out",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 20)),
//         content: Text("Do you really want to Log Out?",style: TextStyle(color: AppColours.golden_button_bg,fontSize: 14)),
//         actions: [cancelButton,okButton]);
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
*/
