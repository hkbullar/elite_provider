
import 'dart:convert';

import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/pojo/User.dart';
import 'package:elite_provider/screens/ChangePasswordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget
{

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _nameController = TextEditingController();
  var _mobileController = TextEditingController();
  var _addressController = TextEditingController();
  int maleBoxVal=0;

  var editButtonPressed=false;

  User userinfo;

  @override
  void initState() {
    Global.getUser().then((value) async {
      setState(()
      {
        userinfo = User.fromJson(json.decode(value));
        _nameController.text=userinfo.name;
      });

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Container(
                    width: 100,
                    height: 100,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColours.white,width: 4),
                        image: DecorationImage(
                          image: AssetImage("assets/images/ic_profile.png"),
                        )
                    ),
                  ),
                  editButtonPressed?FractionalTranslation(
                      translation: Offset(1.1,-2.0),
                      child: Container(
                          child: Icon(Icons.camera_alt_outlined,size: 20,color: AppColours.black,),
                          width:40,
                          height:40,
                          decoration: new BoxDecoration(
                              color: AppColours.golden_button_bg.withOpacity(0.8),
                              shape: BoxShape.circle))):SizedBox(),
                  SizedBox(height: editButtonPressed?0:35),

                  FractionalTranslation(
                      translation: Offset(0,-0.6),
                      child: Text("John Deo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColours.white),)),
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
                    decoration: CommonWidgets.loginFormDecoration("Full Name",Icons.mail_outline),
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
                  TextFormField(
                    enabled: editButtonPressed?true:false,
                    textInputAction: TextInputAction.next,
                    controller: _mobileController,
                    style: TextStyle(color: Colors.white),
                    decoration: CommonWidgets.loginFormDecoration("Mobile Number",Icons.phone_android_outlined),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enabled: editButtonPressed?true:false,
                    textInputAction: TextInputAction.next,
                    controller: _addressController,
                    style: TextStyle(color: Colors.white),
                    decoration: CommonWidgets.loginFormDecoration("Address",Icons.home_outlined),
                  ),
                  SizedBox(height: 20),
                  CommonWidgets.goldenFullWidthButton("Change Password",onClick: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePasswordScreen()));
                  }),
                  SizedBox(height: 20),
                  CommonWidgets.goldenFullWidthButton(editButtonPressed?"Save Changes":"Edit Profile",onClick: (){
                    setState(() {
                      editButtonPressed=!editButtonPressed;
                    });
                  }),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      )
    );
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
}