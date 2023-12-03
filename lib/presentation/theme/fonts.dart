import 'package:flutter/material.dart';

class MyStyle{
  static TextStyle _small(Color color, FontWeight weight){
    return  TextStyle(
      fontSize: 16,
      fontWeight: weight,
      color: color,
    );
  }
  static TextStyle _middle(Color color, FontWeight weight){
    return  TextStyle(
      fontSize: 18,
      fontWeight: weight,
      color: color,
    );
  }

  static final smallBlack = _small(Colors.black87, FontWeight.normal);
  static final smallWhite = _small(Colors.white, FontWeight.normal);
  static final smallGrey = _small(Colors.grey, FontWeight.normal);
  static final middleBlack = _middle(Colors.black87, FontWeight.normal);
  static final middleWhite = _middle(Colors.white, FontWeight.normal);
  static final middleGrey = _middle(Colors.grey, FontWeight.normal);
  static final smallBlackBold = _small(Colors.black87, FontWeight.bold);
  static final smallWhiteBold = _small(Colors.white, FontWeight.bold);
  static final smallGreyBold = _small(Colors.grey, FontWeight.bold);
  static final middleBlackBold = _middle(Colors.black87, FontWeight.bold);
  static final middleWhiteBold = _middle(Colors.white, FontWeight.bold);
  static final middleGreyBold = _middle(Colors.grey, FontWeight.bold);
}