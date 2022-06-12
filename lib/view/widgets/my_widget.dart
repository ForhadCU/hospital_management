// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class MyWidgets {
  static Widget appointment(
      {required String name,
      required String appointmentId,
      required String gender,
      required String age,
      required String mobile,
      required String appointementDate,
      required String appointmentTime,
      required String appointmentType,
      required String appointmentStatus}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(1, 1),
          blurRadius: 2,
        )
      ]),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            CustomText(
              text: "Md. Latifur Rahaman",
              // text: name,
              fontWeight: FontWeight.bold,
              fontsize: 18,
            )
          ],
        ),
        Row(
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
            CircleAvatar(
              radius: 20,
              backgroundColor: MyColors.colorAccent,
              child: CircleAvatar(
                  backgroundColor: MyColors.colorAccent,
                  radius: 16,
                  backgroundImage: AssetImage('lib/assets/ic_edit.png')),
            )
          ],
        ),
        MyWidgets.widget_1(value: appointmentId, key: 'AppoinemtId'),
        MyWidgets.widget_1(value: gender, key: 'Gender'),
        MyWidgets.widget_1(value: age, key: 'Age'),
        MyWidgets.widget_1(value: mobile, key: 'Mobile Number'),
        MyWidgets.widget_1(value: appointementDate, key: 'Appointment Date'),
        MyWidgets.widget_1(value: appointmentTime, key: 'Appoinment Time'),
        MyWidgets.widget_1(value: appointmentType, key: 'Appointment Type'),
        MyWidgets.widget_1(value: appointmentStatus, key: 'Appointment Status')
      ]),
    );
  }

  static Widget widget_1({required String key, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              CustomText(
                text: "$key :",
                fontsize: 16,
                fontWeight: FontWeight.w400,
              )
            ],
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Row(
            children: [
              CustomText(
                text: value,
                fontsize: 16,
              )
            ],
          ))
        ],
      ),
    );
  }

  static Widget notification({required String appointFrom, required String appointTo}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white,
      boxShadow: [BoxShadow(
        color: Colors.black26,
        offset: Offset(1,2),
        blurRadius: 2,
      )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            CustomText(text: "Appointment", fontWeight: FontWeight.bold, fontsize: 16,)
            ,

          ],),
          MyWidgets.widget_1(key: "From", value: appointFrom,
          )
          ,
          MyWidgets.widget_1(key: "To", value: appointTo)
      ]),
    );
  }
}
