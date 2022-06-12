// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:animated_widgets/animated_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/notifiaction/scr.notification.dart';
import 'package:my_hospital_app/view/screens/launcherSlides/scr.launcher_slides.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/addAppointments/scr.add_appointments.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/appointments.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/notifications.dart';
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
  late String docId;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    CustomStatusBar.mGetWhiteStatusbar();
    mAuth = FirebaseAuth.instance;
    print('uid: ' + widget.uid);

    ServicesFirestore.mCheckRemainders(uid: widget.uid);
    ServicesFirestore.mGetUserInfo(widget.uid).then((value) {
      gmail = value['email'];
      name = value['name'];
      phone = value['phone'];
      docId = value['docId'];
      FirebaseFirestore.instance
          .collection(ConstKeys.patientCollRef)
          .doc(docId)
          .collection(ConstKeys.appointments)
          .snapshots()
          .listen((docSnapshot) {
        counter = 0;
        print('called');
        for (var i = 0; i < docSnapshot.docs.length; i++) {
          if (docSnapshot.docs[i][ConstKeys.readStatus] == "unread") {
            counter++;
          }
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return LoginSceen();
                      }));
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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

                        //minutes diff
                        /*    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(1654882887995);
                    DateTime date2 = DateTime.now();
                    
                    print(date2.difference(date).inMinutes); */
                        /*  print('date: ' +
                        DateFormat('Mddyyyy hh:mm a').format(DateTime.now())); */
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
                        ShakeAnimatedWidget(
                          enabled: counter > 0 ? true : false,
                          duration: Duration(milliseconds: 2000),
                          shakeAngle: Rotation.deg(z: 15),
                          curve: Curves.easeInExpo,
                          child: GFIconBadge(
                            position: GFBadgePosition.topEnd(end: 0, top: 0),
                            child: GFIconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: ((context) {
                                  return PatientNotificationScreen(
                                    docId: docId,
                                  );
                                })));
                              },
                              icon: Icon(
                                Icons.notifications,
                              ),
                              shape: GFIconButtonShape.standard,
                              type: GFButtonType.transparent,
                              iconSize: GFSize.MEDIUM,
                            ),
                            counterChild: GFBadge(
                              shape: GFBadgeShape.circle,
                              child: Text("$counter"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  /*   Divider(
                height: 1,
                thickness: 2,
                color: MyColors.app2,
              ), */

                  //Wallpaper
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('lib/assets/gif_health_guide.gif'),
                        height: MyScreenSize.mGetHeight(context, 40),
                        width: MyScreenSize.mGetWidth(context, 100),
                        fit: BoxFit.fill,
                      )
                    ],
                  ),

                  /*  Divider(
                height: 1,
                thickness: 2,
                color: MyColors.app2,
              ), */
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
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddAppointments(uid: widget.uid))),
                          child: IconAndText.iconAndText(
                              imageUrl: 'lib/assets/ic_add_appointment.png',
                              title: "Add Appointment"),
                        ),
                      ),
                      // SizedBox(width: 20,)

                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        PatientAppointmentScreen(
                                          docId: docId,
                                        ))));
                          },
                          child: IconAndText.iconAndText(
                              imageUrl: 'lib/assets/appointments.png',
                              title: "Appointments"),
                        ),
                      ),
                      // SizedBox(width: 30,),

                      Expanded(
                        child: IconAndText.iconAndText(
                            imageUrl: 'lib/assets/ic_history.png',
                            title: "My Records"),
                      ),
                      // SizedBox(width: 35,)

                      /*  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_notification.png',
                        title: "Notification"),
                  ), */
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
                        child: InkWell(
                          onTap: (){

                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LauncherSlidesScreen();
                          }));
                       
                          },
                          child: IconAndText.iconAndText(
                              imageUrl: 'lib/assets/ic_health_detector.png',
                              title: "Pregnancy tracker"),
                        ),
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
                            imageUrl: 'lib/assets/ic_nurses.png',
                            title: "Nurses"),
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
