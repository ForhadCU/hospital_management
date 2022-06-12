// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/widgets/my_widget.dart';

class PatientAppointmentItem extends StatelessWidget {
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
  final String acceptStatus;
  const PatientAppointmentItem(
      {super.key,
      required this.acceptStatus,
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
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 1),
            blurRadius: 2,
          )
        ]),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(height: 4,)
          ,
           Row(
            children: [
              CustomText(
                text: 'Dr. Ayesha Akter',
                // text: name,
                fontWeight: FontWeight.bold,
                fontsize: 18,
              )
            ],
          ),
           SizedBox(
                height: 10,
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
                height: 16,
              ),
              
            ],
          ),
           MyWidgets.widget_1(value: 'Patient 1', key: 'From'),
          MyWidgets.widget_1(value: 'female', key: 'Gender'),
          MyWidgets.widget_1(value: '28', key: 'Age'),
          MyWidgets.widget_1(value: '01819673265', key: 'Mobile Number'),
          MyWidgets.widget_1(value: appointementDate, key: 'Visit Date'),
          MyWidgets.widget_1(value: appointmentTime, key: 'Appoinment Time'),
          MyWidgets.widget_1(
              value: acceptStatus, key: 'Appointment Status'),
          SizedBox(
            height: 10,
          ),
       
        ]),
      ),
    );
  }
}
