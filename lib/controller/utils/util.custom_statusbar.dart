
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class CustomStatusBar {
  static mGetWhiteStatusbar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white));
  }

  static mGetPrimaryStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: MyColors.c3));
  }
}
