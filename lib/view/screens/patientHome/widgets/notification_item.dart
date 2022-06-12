// ignore_for_file: prefer_const_constructors
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/widgets/my_widget.dart';

class PatientNotiItem extends StatelessWidget {
  final String name;
  final String appointmentId;
  final String gender;
  final String age;
  final String mobile;
  final String appointementDate;
  final String appointmentTime;
  final String appointmentType;
  final String appointmentStatus;
  final Function callback;
  const PatientNotiItem(
      {super.key,
      required this.callback,
      required this.name,
      required this.appointmentId,
      required this.gender,
      required this.age,
      required this.mobile,
      required this.appointementDate,
      required this.appointmentTime,
      required this.appointmentType,
      required this.appointmentStatus});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          callback();
        },
        child: Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 1,
            )
          ]),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                appointmentStatus == 'Pending'
                    ? CustomText(text: 'Your appointment is pending.')
                    : appointmentStatus == 'Reject'
                        ? CustomText(text: 'Your appointment is rejected.')
                        : CustomText(text: 'Your appointment is confirmed.')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [CustomText(text: appointmentTime)],
            )
            /* Row(
              children: [
                Expanded(
                    child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black12,
                )),
                SizedBox(
                  width: 10,
                ),
                ClipOval(
                    child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 1)
                      ]),
                  child: Image.asset(
                    'lib/assets/ic_edit.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                ))
                /* CircleAvatar(
                    radius: 20,
                    backgroundColor: MyColors.colorAccent,
                    child: CircleAvatar(
                        backgroundColor: MyColors.colorAccent,
                        radius: 16,
                        backgroundImage: AssetImage('lib/assets/ic_edit.png')),
                  ) */
              ],
            ),
            MyWidgets.widget_1(value: appointmentId, key: 'AppoinemtId'),
            MyWidgets.widget_1(value: gender, key: 'Gender'),
            MyWidgets.widget_1(value: age, key: 'Age'),
            MyWidgets.widget_1(value: mobile, key: 'Mobile Number'),
            MyWidgets.widget_1(value: appointementDate, key: 'Appointment Date'),
            MyWidgets.widget_1(value: appointmentTime, key: 'Appoinment Time'),
            MyWidgets.widget_1(value: appointmentType, key: 'Appointment Type'),
            MyWidgets.widget_1(
                value: appointmentStatus, key: 'Appointment Status') */
          ]),
        ),
      ),
    );
  }
}
