import 'package:flutter/cupertino.dart';

class Global{

  static double getHeight(BuildContext con,{double divider}){
    double aDivider=1;
    if(divider!=null){aDivider=divider;}
    return MediaQuery.of(con).size.height/aDivider;
  }

}