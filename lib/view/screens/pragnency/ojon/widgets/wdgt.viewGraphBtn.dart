// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class ViewGraphButton {
  static Widget viewGraphButton = Container(
    decoration: BoxDecoration(
        color: MyColors.c1,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    margin: EdgeInsets.only(bottom: 10),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: 6),
    child: CustomText(
      text: 'বিস্তারিত দেখতে গ্রাফ চাপুন',
      fontsize: 14,
      fontcolor: MyColors.textOnPrimary,
    ),
  );
}
