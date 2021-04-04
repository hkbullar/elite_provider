import 'package:elite_provider/global/API.dart';
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:elite_provider/global/Constants.dart';
import 'package:elite_provider/global/Global.dart';
import 'package:elite_provider/loginpages/SignUpScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Location location = new Location();

  var checkBoxValue=false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.LOCAL_IMAGE+"logo.png",height: MediaQuery.of(context).size.height/6,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/15),
              TextFormField(
                validator: (value) => value.isEmpty ? 'Email cannot be blank': null,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                focusNode: _usernameFocus,
                onFieldSubmitted: (term)
                {
                  _fieldFocusChange(context, _usernameFocus, _passwordFocus);
                },
                decoration: CommonWidgets.loginFormDecoration("Email",Icons.mail_outline),
              ),
              SizedBox(height: 20),
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Password cannot be blank': null,
                textInputAction: TextInputAction.next,
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                focusNode: _passwordFocus,
                onFieldSubmitted: (term)
                {
                  _fieldFocusChange(context, _usernameFocus, _passwordFocus);
                },
                decoration: CommonWidgets.loginFormDecoration("Password",Icons.lock_outline),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,color: AppColours.golden_button_bg,),
                            SizedBox(width: 5,),
                            Text('Remember me',style: TextStyle(color: AppColours.off_white,fontSize: 14),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text("Forgot Password ?",textAlign: TextAlign.end,style: TextStyle(color: AppColours.off_white,fontSize: 14),),
                  )),
                ],
              ),
              SizedBox(height: 25,),
              SizedBox(height: MediaQuery.of(context).size.width/99),
              CommonWidgets.goldenFullWidthButton("LOGIN",onClick: (){
                _loginClick();
              }),
              SizedBox(height: MediaQuery.of(context).size.height/15),
              InkWell(
                onTap: (){
                  selectSignUpTypeUI();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ',style: TextStyle(color: AppColours.off_white,fontSize: 16)),
                      Text('Signup Here',style: TextStyle(color: AppColours.golden_button_bg,fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigationToSignUp(userType)
  {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignUpScreen(userType)));
  }

  _loginClick()
  {
    if(CommonWidgets.isValidate(_formKey)) {
      Map jsonPost =
      {
        Constants.EMAIL: _emailController.text,
        Constants.PASSWORD: _passwordController.text,
      };
      permissionCode(jsonPost);
    }
  }
permissionCode(Map jsonPost) async {
  var status = await Permission.location.status;
  if (status.isDenied) {
    if (await Permission.location.request().isGranted)
    {
      loginAPI(jsonPost);
    }
    else
    {
    print("AA");
    }
  }
  else{
    loginAPI(jsonPost);
  }

// You can can also directly ask the permission about its status.
  if (await Permission.location.isRestricted) {
    if (await Permission.location.request().isGranted) {
      loginAPI(jsonPost);
    }
  }
}
  loginAPI(Map jsonPost){
    API(context).login(jsonPost);
    FocusScope.of(context).unfocus();
  }
  selectSignUpTypeUI(){
    scaffoldKey.currentState
        .showBottomSheet(
            (context) =>
                Container(
                        height: Global.getHeight(context,divider: 2.5),
                        padding: EdgeInsets.all(25),
                        color: AppColours.golden_button_bg,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text("Register as :",style: TextStyle(color: AppColours.textFeildBG,fontSize: 22,fontWeight: FontWeight.bold),),
                                SizedBox(height: 30,),
                                CommonWidgets.blackFullWidthButton("DRIVER",onClick: (){navigationToSignUp(1);}),
                                SizedBox(height: 30,),
                                CommonWidgets.blackFullWidthButton("GUARD",onClick: (){navigationToSignUp(2);}),
                                SizedBox(height: 30,),
                                CommonWidgets.blackFullWidthButton("SECURITY OFFICER",onClick: (){selectSecurityOfficerTypeUI();}),
            ],
          ),
        ));
  }
  selectSecurityOfficerTypeUI(){
    scaffoldKey.currentState
        .showBottomSheet(
            (context) =>
            Container(
              height: Global.getHeight(context,divider: 1.9),
              padding: EdgeInsets.all(25),
              color: AppColours.golden_button_bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Register as :",style: TextStyle(color: AppColours.textFeildBG,fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  CommonWidgets.blackFullWidthButton("Steward",onClick: (){navigationToSignUp(3);}),
                  SizedBox(height: 20,),
                  CommonWidgets.blackFullWidthButton("Security Guard",onClick: (){navigationToSignUp(4);}),
                  SizedBox(height: 20,),
                  CommonWidgets.blackFullWidthButton("Door Supervisor",onClick: (){navigationToSignUp(5);}),
                  SizedBox(height: 20,),
                  CommonWidgets.blackFullWidthButton("Close Protection Officerr",onClick: (){navigationToSignUp(6);}),
                  SizedBox(height: 20,),
                  CommonWidgets.blackFullWidthButton("CSAS Officer",onClick: (){navigationToSignUp(7);}),
                ],
              ),
            ));
  }
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus)
  {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}