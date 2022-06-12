
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class ViewGraphButton {
  static Widget viewGraphButton = Container(
    decoration: const BoxDecoration(
        color: MyColors.pink1,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
    margin: const EdgeInsets.only(bottom: 10),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: const CustomText(
      text: 'For more, Click Here',
      fontsize: 14,
      fontcolor: MyColors.textOnPrimary,
    ),
  );
}
