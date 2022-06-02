// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/view/screens/launcher/scr.launcher.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHome.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHomeNew.dart';

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
      home:  PatientHome(uid: "",),
      // home: const LaucherScreen(),
    );
  }
}

