import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/main.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';

class DoctorHome extends StatefulWidget {
  final String userId;
  const DoctorHome({super.key, required this.userId});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  late FirebaseAuth mAuth;

  @override
  void initState() {
    super.initState();
    mAuth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const CustomText(
        text: "Doctor Home",
      )),
      body: InkWell(
        onTap: () {
          ServicesFirebaseAuth.mSignOut(mAuth);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginSceen()));
        },
        child: Center(
            child: CustomText(
          text: "SignOut",
          fontcolor: Colors.blue,
        )),
      ),
    );
  }
}
