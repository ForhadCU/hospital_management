// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/main.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';

class NurseHomeScreen extends StatefulWidget {
  final String uId;
  const NurseHomeScreen({super.key, required this.uId});

  @override
  State<NurseHomeScreen> createState() => _NurseHomeScreenState();
}

class _NurseHomeScreenState extends State<NurseHomeScreen> {
  late FirebaseAuth mAuth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mAuth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CustomText(
        text: "Nurse Home",
      )),
      body: ElevatedButton(
        onPressed: (() {
          ServicesFirebaseAuth.mSignOut(mAuth);
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return LoginSceen();
          }));
        }),
        child: CustomText(text: 'SignOut'),
      ),
    );
  }
}
