
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class PLoader{
  BuildContext _context;
  ProgressDialog pr;
  PLoader(this._context);
  show() async {
    if(pr==null){
      pr= ProgressDialog(
          _context,
          type: ProgressDialogType.normal,
          isDismissible: false
      );
      pr.style(
          padding: EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
          message: 'Please Wait...',
          borderRadius: 8.0,
          backgroundColor: AppColours.golden_button_bg,
          progressWidget: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColours.black),),
          elevation: 10.0,
          messageTextStyle: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
      );
      await pr.show();
    }
    else
   {
     if(!pr.isShowing()){
       await pr.show();
     }
    }
  }
  hide(){
    if(pr!=null){
      if(pr.isShowing()){
        pr.hide();
      }
    }
}
}