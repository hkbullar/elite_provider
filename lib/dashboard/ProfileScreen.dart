
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget
{

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _nameController = TextEditingController();
  int maleBoxVal=0;

  var editButtonPressed=false;

  @override
  void initState() {
    setState(() {
      _nameController.text="John Deo";
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
                    width: 130,
                    height: 130,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColours.white,width: 6),
                        image: DecorationImage(
                          image: AssetImage("assets/images/ic_profile.png"),
                        )
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
                      child: Text("John Deo",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: AppColours.white),)),
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
                    initialValue: "john.deo@gmail.com",
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.white),
                    decoration: CommonWidgets.loginFormDecoration("Full Name",Icons.mail_outline),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              if(editButtonPressed)
                              maleBoxVal=0;
                            });
                          },
                          child: Card(
                            color: maleBoxVal==0?AppColours.golden_button_bg:AppColours.textFeildBG,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Image.asset(Constants.LOCAL_IMAGE+"man_black.png",height: 30,color: maleBoxVal==0?AppColours.black:AppColours.white,),
                                  SizedBox(height: 10),
                                  Text("MALE",style: TextStyle(color: maleBoxVal==0?AppColours.black:AppColours.white),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              if(editButtonPressed)
                              maleBoxVal=1;
                            });

                          },
                          child: Card(
                            color: maleBoxVal==1?AppColours.golden_button_bg:AppColours.textFeildBG,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Image.asset(Constants.LOCAL_IMAGE+"woman_black.png",height: 30,color: maleBoxVal==1?AppColours.black:AppColours.white,),
                                  SizedBox(height: 10),
                                  Text("FEMALE",style: TextStyle(color: maleBoxVal==1?AppColours.black:AppColours.white),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              if(editButtonPressed)
                              maleBoxVal=2;
                            });
                          },
                          child: Card(
                            color: maleBoxVal==2?AppColours.golden_button_bg:AppColours.textFeildBG,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Column(
                                children: [
                                  Image.asset(Constants.LOCAL_IMAGE+"intersex_black.png",height: 30,color: maleBoxVal==2?AppColours.black:AppColours.white,),
                                  SizedBox(height: 10,),
                                  Text("I'M ME",style: TextStyle(color: maleBoxVal==2?AppColours.black:AppColours.white),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            color: AppColours.golden_button_bg,
                            child: Text("Change Password",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: 18),),
                            onPressed: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ChangePasswordScreen()));
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            color: AppColours.golden_button_bg,
                            child: Text(editButtonPressed?"Save Changes":"Edit Profile",style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: 18),),
                            onPressed: (){
                                  setState(() {
                                    editButtonPressed=!editButtonPressed;
                                  });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}