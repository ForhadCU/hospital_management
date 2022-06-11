// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class MyProfileDialog extends StatelessWidget {
  final String personName;
  final String gmail;
  final String mobile;
  const MyProfileDialog(
      {super.key,
      required this.personName,
      required this.gmail,
      required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
        padding: EdgeInsets.only(right: 14, left: 14, bottom: 24, top: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: MyColors.c5,
              child: CircleAvatar(
                radius: 46,
                backgroundImage: AssetImage('lib/assets/ic_person.png'),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            CustomText(
              text: personName,
              fontWeight: FontWeight.bold,
              fontsize: 24,
            ),
            SizedBox(height: 4),
            CustomText(
              text: gmail,
              fontsize: 14,
            ),
            SizedBox(height: 4),
            CustomText(
              text: mobile,
              fontsize: 14,
            )
          ],
        ),
      ),
    );
  }
}
