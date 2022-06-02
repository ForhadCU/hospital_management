// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class UserBanner {
  static Widget userBanner({required String name}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: 16, left: 24, top: 8, bottom: 8),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(-1, 2), blurRadius: 1)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          color: MyColors.c3),
      child: CustomText(
        text: name,
        fontWeight: FontWeight.w500,
        fontcolor: Colors.white,
        fontsize: 16,
      ),
    );
  }
}
