import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: CustomText(
          text: "Notification",
          fontcolor: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        body: Container());
  }
}
