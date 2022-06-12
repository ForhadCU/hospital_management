// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:animated_widgets/animated_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/appointment/scr.appointment.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/history_graph.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/notifiaction/scr.notification.dart';
import 'package:my_hospital_app/view/screens/adminHome/screen/notifiaction/widget/noti_item.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/iconButtons.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/user_banner.dart';
import 'package:my_hospital_app/view/widgets/dialog/profileView.dart';

class AdminHome extends StatefulWidget {
  final String uid;
  const AdminHome({super.key, required this.uid});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late FirebaseAuth mAuth;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    //statusbar setting
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white));

    mAuth = FirebaseAuth.instance;

    FirebaseFirestore.instance
        .collection(ConstKeys.adminCollRef)
        .doc(ConstKeys.adminDocId)
        .collection(ConstKeys.notifications)
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
              UserBanner.userBanner(name: "Admin"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MyProfileDialog(
                                personName: "Person's Full Name",
                                gmail: 'person74644@gmail.com',
                                mobile: '01819764312');
                          });
                    },
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_person.png',
                        title: "My Profile"),
                  ),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: ((context) {
                            return MyNotificationScreen();
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
              SizedBox(
                height: 14,
              ),
              /*  Divider(
                height: 1,
                thickness: 2,
                color: MyColors.app2,
              ), */

              //Wallpaper
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('lib/assets/gif_admin.gif'),
                    height: MyScreenSize.mGetHeight(context, 35),
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
                      onTap: () {
                        print("Clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminAppointmentScreen()));
                      },
                      child: IconAndText.iconAndText(
                          imageUrl: 'lib/assets/appointments.png',
                          title: "Appointments"),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return HistoryGraph();
                        }));
                      },
                      child: IconAndText.iconAndText(
                          imageUrl: 'lib/assets/ic_history.png',
                          title: "Medical Records"),
                    ),
                  ),

                  /*  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyNotificationScreen()));
                      },
                      child: IconAndText.iconAndText(
                          imageUrl: 'lib/assets/ic_notification.png',
                          title: "Notification"),
                    ),
                  ), */
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_patient.png',
                        title: "Our Patients"),
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
                        imageUrl: 'lib/assets/ic_doctors.png',
                        title: "Doctors"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_nurses.png', title: "Nurses"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_service.png',
                        title: "Services"),
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
                        imageUrl: 'lib/assets/ic_bloodbank.png',
                        title: "Blood Bank"),
                  ),
                  Expanded(
                    child: IconAndText.iconAndText(
                        imageUrl: 'lib/assets/ic_profile.png',
                        title: "About Us"),
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
