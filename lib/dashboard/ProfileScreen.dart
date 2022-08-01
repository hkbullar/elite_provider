
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/global/PLoader.dart';
import 'package:elite_provider/global/Size.dart';
import 'package:elite_provider/pojo/EditProfilePojo.dart';
import 'package:elite_provider/pojo/User.dart';
import 'package:elite_provider/screens/ChangePasswordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget
{

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  int maleBoxVal=0;
  var editButtonPressed=false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  File _profileImage;

  User userinfo;

  @override
  void initState() {
    Global.getUser().then((value) async {
      setState(() {
        userinfo = User.fromJson(json.decode(value));
        _nameController.text=userinfo.name;
        _phoneController.text="${userinfo.phoneNo}";
        if(userinfo.gender!=null && userinfo.gender.isNotEmpty){
          if(userinfo.gender==Constants.USER_MALE){maleBoxVal=0;}
          else if(userinfo.gender==Constants.USER_FEMALE){maleBoxVal=1;}
          else if(userinfo.gender==Constants.USER_ME){maleBoxVal=2;}
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size().init(context);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        if(editButtonPressed)
                          selectPickerType();
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColours.white,width: 6),
                            image: DecorationImage(
                                image: profileImage())
                        ),
                      ),
                    ),
                    editButtonPressed?FractionalTranslation(
                        translation: Offset(1.5,-2.3),
                        child: Container(
                            child: Icon(Icons.camera_alt_outlined,size: 20,color: AppColours.black,),
                            width:40,
                            height:40,
                            decoration: new BoxDecoration(
                                color: AppColours.golden_button_bg.withOpacity(0.8),
                                shape: BoxShape.circle))):SizedBox(),
                    SizedBox(height: editButtonPressed?0:35),

                    FractionalTranslation(
                        translation: Offset(0,-0.5),
                        child: Text(userinfo!=null?userinfo.name:"wait",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColours.white),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      enabled: editButtonPressed?true:false,
                      validator: (value) => value.isEmpty ? 'Name cannot be blank': null,
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: CommonWidgets.loginFormDecoration("Full Name",Icons.person_outline),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: false,
                      controller: CommonWidgets.formFieldFixText(userinfo!=null?userinfo.email:""),
                      textInputAction: TextInputAction.next,
                      style: TextStyle(color: Colors.white),
                      decoration: CommonWidgets.loginFormDecoration("Email",Icons.mail_outline),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: editButtonPressed?true:false,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.done,
                      controller: _phoneController,
                      style: TextStyle(color: Colors.white),
                      decoration: CommonWidgets.loginFormDecoration("Phone Number",Icons.lock_outline),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        maleFemaleButton(0, "MALE", "man_black.png"),
                        maleFemaleButton(1, "FEMALE", "woman_black.png"),
                        maleFemaleButton(2, "I'M ME", "intersex_black.png")
                      ],
                    ),
                    SizedBox(height: 20),
                    CommonWidgets.goldenFullWidthButton("Change Password",onClick: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePasswordScreen()));
                    }),
                    SizedBox(height: 20),
                    CommonWidgets.goldenFullWidthButton(editButtonPressed?"Save Changes":"Edit Profile",onClick: (){
                      setState(() {
                        if(editButtonPressed)
                        {
                          editProfileClick();
                        }
                        editButtonPressed=!editButtonPressed;

                      });
                    })
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  profileImage(){
    if(_profileImage==null){
      if(userinfo!=null){
        if(userinfo.image!=null && userinfo.image.isNotEmpty){
          return NetworkImage(userinfo.image);
        }
        else{
          return AssetImage(Constants.LOCAL_IMAGE+"ic_profile.png");
        }
      }
      else{
        return AssetImage(Constants.LOCAL_IMAGE+"ic_profile.png");
      }
    }
    else{
      return FileImage(_profileImage);
    }
  }

  editProfileClick() async {
    String gender="";

    PLoader loader=PLoader(context);
    loader.show();

    if(maleBoxVal==0)gender=Constants.USER_MALE;
    if(maleBoxVal==1)gender=Constants.USER_FEMALE;
    if(maleBoxVal==2)gender=Constants.USER_ME;

    Map<String, dynamic> jsonPost = {
      Constants.EDIT_PROFILE_NAME: _nameController.text,
      Constants.EDIT_PROFILE_GENDER: gender,
      Constants.EDIT_PROFILE_PHONE_NUMBER: _phoneController.text!="null"?int.parse(_phoneController.text):"",
      Constants.EDIT_PROFILE_IMAGE:_profileImage!=null?await MultipartFile.fromFile(_profileImage.path):""
    };

    FormData formData=FormData.fromMap(jsonPost);
    var token = await Global.getToken();
    Dio dio = new Dio();
    dio.options.baseUrl=Constants.BASE_URL;
    //dio.options.headers['Accept'] = 'application/json';
    //dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = 'Bearer '+token;
    dio.post("update-profile", data: formData).then((value) async {
      if(value.statusCode==200 || value.statusCode==201){
        Map<String, dynamic> map = json.decode(value.toString());
        EditProfilePojo loginPojo= EditProfilePojo.fromJson(map);
        SharedPreferences preferences =await Global.getSharedPref();
        preferences.setString(Constants.USER_PREF,json.encode(loginPojo.user.toJson()));
        loader.hide();
        Global().toast(context, loginPojo.message);
        setState(() {
          userinfo=loginPojo.user;
        });
      }
      else{
        Global().toast(context, value.statusMessage);
      }
    });
  }

  Widget maleFemaleButton(int defButtonValue,String text,String image,{Function onClick}){
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            if(editButtonPressed)
              maleBoxVal=defButtonValue;
          });
        },
        child: Card(
          color: maleBoxVal==defButtonValue?AppColours.golden_button_bg:AppColours.textFeildBG,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Image.asset(Constants.LOCAL_IMAGE+image,height: 30,color: maleBoxVal==defButtonValue?AppColours.black:AppColours.white,),
                SizedBox(height: 10),
                Text(text,style: TextStyle(color: maleBoxVal==defButtonValue?AppColours.black:AppColours.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectPickerType(){
    scaffoldKey.currentState
        .showBottomSheet(
            (context) => Container(
          height: Size.size(250),
          padding: EdgeInsets.all(25),
          color: AppColours.golden_button_bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pick Photo from :",style: TextStyle(color: AppColours.textFeildBG,fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 30),
              CommonWidgets.blackFullWidthButton("Camera",onClick:(){
                Navigator.of(context).pop();
                getImage(ImageSource.camera);

              }),
              SizedBox(height: 30,),
              CommonWidgets.blackFullWidthButton("Gallery",onClick: () {
                Navigator.of(context).pop();
                getImage(ImageSource.gallery);
              }),
            ],
          ),
        ));
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(
        maxHeight: 200,
        maxWidth: 200,
        imageQuality: 50,
        source: source
    );

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }
}