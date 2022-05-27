// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/view/screens/adminHome/scr.adminHome.dart';
import 'package:my_hospital_app/view/screens/doctorHome/scr.doctorHome.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:my_hospital_app/view/screens/nurseHome/scr.nurseHome.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHome.dart';
import 'package:page_transition/page_transition.dart';

class LaucherScreen extends StatefulWidget {
  const LaucherScreen({super.key});

  @override
  State<LaucherScreen> createState() => _LaucherScreenState();
}

class _LaucherScreenState extends State<LaucherScreen> {
  User? _user;
  late FirebaseAuth _mAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mAuth = FirebaseAuth.instance;
    _user = _mAuth.currentUser;
    // String uid = _user.uid;

    Future.delayed(Duration(milliseconds: 3000)).then((value) {
      //check if user logged in before
      _mAuth.authStateChanges().listen(
        (User? u) {
          if (u != null && u.emailVerified) {
            print(ConstPrintColor.printGreen +
                "User currently signed In" +
                ConstPrintColor.endColor);

            ServicesFirestore.mCheckUserType(_user!.uid).then((userType) {
              print(userType);

              //Check userType
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                if (userType == ConstKeys.patient) {
                  return PatientHome(uid: _user!.uid);
                } else if (userType == ConstKeys.doctor) {
                  return DoctorHomeScreen(uId: _user!.uid);
                } else if (userType == ConstKeys.nurse) {
                  return NurseHomeScreen(uId: _user!.uid);
                } else {
                  return AdminHome(uid: _user!.uid);
                }

                // return AdminHome(uid: uid);
              }));
            });

            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: AdminHome(
                      uid: _user!.uid,
                    ),
                    type: PageTransitionType.rightToLeft));
          } else {
            print(ConstPrintColor.printYellow +
                "User is not signed in currently " +
                ConstPrintColor.endColor);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginSceen()));
            // user = ;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.pink,
        // child: CustomText(text: "Please wait..."),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 4,)
            ,
            CustomText(text: 'Please wait...')
          ],
        ),
      ),
    );
  }
}
