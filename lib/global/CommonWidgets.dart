
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
 static Widget goldenFullWidthButton(String text,{Function onClick})
 {
   return Row(
       children: [
         Expanded(
           child: RaisedButton(
               padding: EdgeInsets.all(14),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8.0)),
               color: AppColours.golden_button_bg,
               child: Text(text,style: TextStyle(color: AppColours.black,fontWeight: FontWeight.bold,fontSize: 18),),
               onPressed: onClick),
         )]);
 }
 static Widget blackFullWidthButton(String text,{Function onClick})
 {
   return Row(
       children: [
         Expanded(
           child: RaisedButton(
               padding: EdgeInsets.all(14),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8.0)),
               color: AppColours.textFeildBG,
               child: Text(text,style: TextStyle(color: AppColours.golden_button_bg,fontWeight: FontWeight.bold,fontSize: 18),),
               onPressed: onClick),
         )]);
 }
  Widget requestTextContainer(String title,String text,IconData icon){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       SizedBox(height: 10,),
       Padding(
         padding: const EdgeInsets.only(left: 6,bottom: 6),
         child: Text(title,style: TextStyle(color: AppColours.white,fontSize: 16),),
       ),
       Container(
         decoration: BoxDecoration(
             color: AppColours.textFeildBG,
             borderRadius: BorderRadius.all(Radius.circular(10))
         ),
         child: Padding(
           padding: const EdgeInsets.all(12.0),
           child: Row(
             children: [
               Icon(icon,color: AppColours.white,),
               SizedBox(width: 5,),
               Expanded(child: Text(text,style: TextStyle(color: AppColours.white,fontSize: 16),)),
             ],
           ),
         ),
       ),
       SizedBox(height: 10,),
     ],
   );
  }
}