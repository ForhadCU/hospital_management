// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/view/screens/adminHome/scr.adminHome.dart';
import 'package:my_hospital_app/view/screens/doctorHome/scr.doctorHome.dart';
import 'package:my_hospital_app/view/screens/nurseHome/scr.nurseHome.dart';
import 'package:my_hospital_app/view/screens/patientHome/scr.patientHome.dart';
import 'package:my_hospital_app/view/screens/register/scr.registration.dart';
import 'package:page_transition/page_transition.dart';

import '../../widgets/background1.dart';

class LoginSceen extends StatefulWidget {
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  var _colorTweenProgressbar;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  late FirebaseAuth _mAuth;
  bool isEmail = true;
  bool isPass = true;
  bool isloading = false;

  @override
  void initState() {
    _mAuth = FirebaseAuth.instance;

/* //check if user logged in before
    _mAuth.authStateChanges().listen(
      (User? u) {
        if (u != null && u.emailVerified) {
          print(ConstPrintColor.printGreen +
              "User currently signed In" +
              ConstPrintColor.endColor);

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

          // user = ;
        }
      },
    ); */

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _colorTweenProgressbar = ColorTween(begin: Colors.yellow, end: Colors.green)
        .animate(_animationController);

    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Back button pressed')));
        return false;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      shadows: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          offset: Offset(1, 1),
                          blurRadius: 1,
                        )
                      ],
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        errorStyle: TextStyle(fontStyle: FontStyle.italic),
                        errorText:
                            !isEmail ? ConstErrorMessage.emailField : null),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        errorStyle: TextStyle(fontStyle: FontStyle.italic),
                        errorText:
                            !isPass ? ConstErrorMessage.passField : null),
                    obscureText: true,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 24, top: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isloading
                              ? Container(
                                  padding: EdgeInsets.all(5.0),
                                  height: 32,
                                  width: 32,
                                  child: CircularProgressIndicator(
                                    valueColor: _colorTweenProgressbar,
                                    strokeWidth: 2,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    _mInputValidation();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40.0,
                                    width: size.width * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(80.0),
                                        gradient: LinearGradient(colors: [
                                          /* Color.fromARGB(255, 255, 136, 34),
                                  Color.fromARGB(255, 255, 177, 41) */
                                          Colors.blue,
                                          Colors.blueAccent,
                                        ])),
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      "LOGIN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "- OR -",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Sign in with",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 0, 0, 0)),
                            ),
                          ),

                          //Sign in with google
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                RawMaterialButton(
                                    onPressed: () {},
                                    elevation: 2.0,
                                    constraints: BoxConstraints(
                                        maxWidth: 40,
                                        minWidth: 40,
                                        maxHeight: 40,
                                        minHeight: 40),
                                    shape: CircleBorder(),
                                    fillColor: Colors.white,
                                    // constraints: BoxConstraints(maxw),
                                    child: Image(
                                      image: AssetImage(
                                        "lib/assets/ic_google.png",
                                      ),
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 2.0,
                                  constraints: BoxConstraints(
                                      maxWidth: 40,
                                      minWidth: 40,
                                      maxHeight: 40,
                                      minHeight: 40),
                                  shape: CircleBorder(),
                                  fillColor: Colors.white,
                                  child: Icon(
                                    ConstKeys.iconPhone,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Text("Don't have an Account?"),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 650),
                                            child: RegistrationScreen(),
                                            type: PageTransitionType
                                                .rightToLeft));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2661FA)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mInputValidation() {
    emailController.text.isEmpty
        ? isEmail = false
        : isEmail = true; //check Mobile number field is empty or not
    passController.text.isEmpty || passController.text.length < 6
        ? isPass = false
        : isPass = true; //check Password field is empty or not

    if (isEmail && isPass) {
      //do sign up
      setState(() {
        isloading = true;
        _mSignInUSer(emailController.text, passController.text);
      });
    } else {
      setState(() {});
    }
  }

  Future<String?> _mSignInUSer(String email, String pass) {
    return Future.delayed(Duration(milliseconds: 300)).then((_) async {
      try {
        UserCredential authResult = await _mAuth.signInWithEmailAndPassword(
            email: email, password: pass);
        /*  _user = authResult.user;
        String uid = _user!.uid; */
       String currentUserId = _mAuth.currentUser!.uid;
       
        print(ConstPrintColor.printGreen +
            "Login Successfull" +
            ConstPrintColor.endColor);
        print(ConstPrintColor.printCyan +
            currentUserId+
            ConstPrintColor.endColor);
                  //Check userType

        ServicesFirestore.mGetUserType(currentUserId).then((value) {
          
          if (value == "Patient") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return PatientHome(uid: currentUserId);
            }));
          } else if (value == "Doctor") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return DoctorHome(userId: currentUserId);
            }));
          } else if (value == "Admin") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return AdminHome(uid: currentUserId);
            }));
          } else if (value == "Nurse") {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return NurseHome(uId: currentUserId);
            }));
          } else {
            print(value);
          }
        });

        /*  String? userType = ServicesFirestore.mCheckUserType(uid);
          print(userType);
          _user!.emailVerified
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                  if (userType == ConstKeys.patient) {
                    return PatientHome(uid: uid);
                  } else if (userType == ConstKeys.doctor) {
                    return DoctorHomeScreen(uId: uid);
                  } else if (userType == ConstKeys.nurse) {
                    return NurseHomeScreen(uId: uid);
                  } else {
                    return AdminHome(uid: uid);
                  }

                  // return AdminHome(uid: uid);
                })
                  /* PageTransition(
                    duration: Duration(milliseconds: 300),
                    child: AdminHome(
                      uid: uid,
                    ),
                    type: PageTransitionType.leftToRight) */
                  )
              : _mGetMessage();
        }); */
        /* ServicesFirestore.mCheckUserType(uid).then((userType) {
          print(userType);

          //Check userType
          _user!.emailVerified
              ? Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                  if (userType == ConstKeys.patient) {
                    return PatientHome(uid: uid);
                  } else if (userType == ConstKeys.doctor) {
                    return DoctorHomeScreen(uId: uid);
                  } else if (userType == ConstKeys.nurse) {
                    return NurseHomeScreen(uId: uid);
                  } else {
                    return AdminHome(uid: uid);
                  }

                  // return AdminHome(uid: uid);
                })
                  /* PageTransition(
                    duration: Duration(milliseconds: 300),
                    child: AdminHome(
                      uid: uid,
                    ),
                    type: PageTransitionType.leftToRight) */
                  )
              : _mGetMessage();
        }); */
      } on FirebaseException catch (e) {
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.message.toString(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 4000),
        ));
      }
    });
  }

  _mGetMessage() {
    setState(() {
      isloading = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please verify your email"),
        duration: Duration(seconds: 3),
      ));
    });
  }
}
