
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidgets{

 static InputDecoration loginFormDecoration(String text,IconData data){
    return InputDecoration(
      prefixIcon: Icon(data,color: AppColours.white,),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      fillColor: AppColours.textFeildBG,
      hintStyle: TextStyle( color: AppColours.off_white),
      hintText: text,
    );
  }
 //check the validation
 static bool isValidate(GlobalKey<FormState> formKey) {
   final FormState form = formKey.currentState;
   if (form.validate()) {
     return true;
   } else {
     return false;
   }
 }
  static Widget settingsIcon(IconData icon){
   return Container(
       padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         color: AppColours.black,
         borderRadius: BorderRadius.circular(100),),
       child: Icon(
         icon,
         color: AppColours.golden_button_bg,
       ));
  }
}