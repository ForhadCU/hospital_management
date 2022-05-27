// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/widgets/my_widgets.dart';

class AdminAppointmentSceen extends StatefulWidget {
  const AdminAppointmentSceen({super.key});

  @override
  State<AdminAppointmentSceen> createState() => AdminAppointmenSceentState();
}

class AdminAppointmenSceentState extends State<AdminAppointmentSceen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: CustomText(
          text: "Appointments",
          fontWeight: FontWeight.bold,
          fontcolor: MyColors.textOnPrimary,
        )),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: MyWidgets.appointment(
              name: "name",
              appointmentId: "appointmentId",
              gender: "gender",
              age: "age",
              mobile: "mobile",
              appointementDate: "appointementDate",
              appointmentTime: "appointmentTime",
              appointmentType: "appointmentType",
              appointmentStatus: "appointmentStatus"),
        ));
  }
}
