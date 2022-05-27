// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class IconAndText {
/*   String imageUrl;
  String title;
  IconAndText({required this.imageUrl, required this.title}); */

  static Widget iconAndText({required String imageUrl, required String title}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: MyColors.secondTrimster,
            radius: 24,
            child: CircleAvatar(
              backgroundColor: MyColors.secondTrimster,
              radius: 16,
              backgroundImage: AssetImage(imageUrl),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          CustomText(
            text: title,
          )
        ],
      ),
    );
  }
}
