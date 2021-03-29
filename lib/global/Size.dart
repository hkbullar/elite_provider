import 'package:flutter/cupertino.dart';

class Size{

  static MediaQueryData _mediaQueryData;
   static double _screenWidth;
  static double _screenHeight;
  static double _heightRatio=0.20;
  static double _widthRatio=0.10;
  static double _sizeRatio=0.08;
  void init(BuildContext con)
  {
    _mediaQueryData = MediaQuery.of(con);
    _screenWidth=_mediaQueryData.size.width;
    _screenHeight=_mediaQueryData.size.height;
  }

  static double height(double height)
  {
    return (height/100)*(_screenHeight*_heightRatio);
  }

  static double width(double width)
  {
    return (width/100)*(_screenWidth*_widthRatio);
  }
  static double size(double size)
  {
    return ((_screenWidth+_screenHeight)/100)*(_sizeRatio*size);
  }
}