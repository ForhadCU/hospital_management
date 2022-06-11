// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/addAppointments/scr.add_appointments.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/profile.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/iconButtons.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/user_banner.dart';

class PatientHome extends StatefulWidget {
  final String uid;
  const PatientHome({super.key, required this.uid});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  late FirebaseAuth mAuth;
  late String gmail;
  late String name;
  late String phone;

  @override
  void initState() {
    super.initState();
    CustomStatusBar.mGetWhiteStatusbar();
    mAuth = FirebaseAuth.instance;
    print('uid: ' + widget.uid);
    ServicesFirestore.mGetUserInfo(widget.uid).then((value) {
      setState(() {
        gmail = value['email'];
        name = value['name'];
        phone = value['phone'];
      });
    });
    /*    gmail = 'patient@gmail.com';
    name = 'Mr. Tester';
    name = '0187892728283'; */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 36),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          //header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  print("LogOut Clicked");
                  ServicesFirebaseAuth.mSignOut(mAuth);
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LoginSceen();
                  }));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    child: CustomText(
                      text: "<< Logout",
                      fontWeight: FontWeight.w400,
                      fontcolor: Colors.blue,
                      fontsize: 16,
                    )),
              ),
              InkWell(
                  onTap: () {
                    // print('object');
                    // ServicesFirestore.mUpdateDoctorCollection();
                    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(1654882887995);
                    DateTime date2 = DateTime.now();
                    
                    print(date);
                  },
                  child: UserBanner.userBanner(name: "Patient")),
            ],
          ),
          SizedBox(
            height: 16,
          ),

          //body
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //profile and records icon
              InkWell(
                onTap: () {
                  /* showDialog(
                      context: context,
                      builder: (context) {
                        return MyProfileDialog(
                          gmail: gmail,
                          personName: name,
                          mobile: phone,
                        );
                      }); */
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PatientProfileScreen(
                      uid: widget.uid,
                      name: name,
                      gmail: gmail,
                      phone: phone,
                    );
                  }));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_person.png',
                        title: "My Profile"),
                    IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_history.png',
                        title: "My Records"),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Divider(
                height: 1,
                thickness: 2,
                color: MyColors.app2,
              ),

              //Wallpaper
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('lib/assets/patient1.jpg'),
                    height: MyScreenSize.mGetHeight(context, 30),
                    width: MyScreenSize.mGetWidth(context, 100),
                    fit: BoxFit.fill,
                  )
                ],
              ),

              Divider(
                height: 1,
                thickness: 2,
                color: MyColors.app2,
              ),
              SizedBox(
                height: 16,
              ),
              //Bottom Modules
              //1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddAppointments(uid: widget.uid))),
                      child: IconAndText.iconAndText(
                          imageUrl: 'lib/assets/ic_add_appointment.png',
                          title: "Add Appointment"),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    AdminAppointmentSceen()))); */
                      },
                      child: IconAndText.iconAndText(
                          imageUrl: 'lib/assets/appointments.png',
                          title: "Appointments"),
                    ),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_notification.png',
                        title: "Notification"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_health_detector.png',
                        title: "Health Detector"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_medical_guide.png',
                        title: "Medi Guide"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_bloodbank.png',
                        title: "Blood Bank"),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_doctors.png',
                        title: "Doctors"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_nurses.png', title: "Nurses"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_help.png', title: "Help"),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    ));
  }
}
