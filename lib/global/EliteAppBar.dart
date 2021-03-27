
import 'package:elite_provider/global/AppColours.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EliteAppBar extends PreferredSize {
 final String title;
  EliteAppBar(this.title);
  @override
  Size get preferredSize => Size.fromHeight(55); // set height of your choice

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title,style: TextStyle(color: AppColours.white),),
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

  }
}