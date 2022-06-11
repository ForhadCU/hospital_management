// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/view/screens/adminHome/scr.adminHome.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/notifiaction/widget/noti_item.dart';
import 'package:my_hospital_app/view/screens/launcher/scr.launcher.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHome.dart';
import 'package:my_hospital_app/view/screens/splash%20screen/scr.splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    /*  home:  AdminNotiItem(
          name: "name",
          appointmentId: "appointmentId",
          gender: "gender",
          age: "age",
          mobile: "mobile",
          appointementDate: "appointementDate",
          appointmentTime: "appointmentTime",
          appointmentType: "appointmentType",
          appointmentStatus: "appointmentStatus"), */
      // home:  AdminHome(uid: "",),
      // home:  PatientHome(uid: "",),
      // home: const SplashScreen(),
      home: const LauncherScreen(),
    );
  }
}
