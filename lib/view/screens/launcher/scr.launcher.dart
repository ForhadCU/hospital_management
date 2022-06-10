import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/view/screens/adminHome/scr.adminHome.dart';
import 'package:my_hospital_app/view/screens/doctorHome/scr.doctorHome.dart';
import 'package:my_hospital_app/view/screens/nurseHome/scr.nurseHome.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHome.dart';
import 'package:my_hospital_app/view/screens/splash%20screen/scr.splash.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  late FirebaseAuth _auth;
  bool isChecking = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    Future.delayed(const Duration(milliseconds: 4500)).then((value) async {
      if (_auth.currentUser != null) {
        //signed in
        print('Signed in');
        ServicesFirestore.mGetUserType(_auth.currentUser!.uid).then((value) {

          if (value == "Patient") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return PatientHome(uid: _auth.currentUser!.uid);
            }));
          } else if (value == "Doctor") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return DoctorHome(userId: _auth.currentUser!.uid);
            }));
          } else if (value == "Admin") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return AdminHome(uid: _auth.currentUser!.uid);
            }));
          } else if (value == "Nurse") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return NurseHome(uId: _auth.currentUser!.uid);
            }));
          } else {
            print(value);
          }
        });
      } else {
        //not Signed in
        print("not signed in");

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isChecking
          ? const Center(
              child: Image(image: AssetImage('lib/assets/gif_loading1.gif')),
              // child: DotBlickLoader(),
            )
          : const Center(
              child: Text('Checked'),
            ),
    );
  }
}
