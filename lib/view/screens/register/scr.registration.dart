// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/serviceController/localServices.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/view/screens/login/scr.login.dart';
import 'package:my_hospital_app/view/widgets/background1.dart';
import 'package:page_transition/page_transition.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  late AnimationController _animationController;
  var _colorTwinProgressbar;
  // var _animation;
  bool isUsername = true;
  bool isEmail = true;
  bool isPhone = true;
  bool isPass = true;
  bool isConfirmPass = true;
  bool isLoading = false;
  // late User user;
  FirebaseAuth mAuth = FirebaseAuth.instance;
  String dropDownValue = "Select category";

  @override
  void initState() {
    // mAuth = FirebaseAuth.instance;
    // user = mAuth.currentUser!;

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _colorTwinProgressbar = ColorTween(begin: Colors.yellow, end: Colors.green)
        .animate(_animationController);
    _animationController.repeat();

//Control Phone number TextField
    phoneController.addListener(() {
      if (phoneController.text.length > 0) {
        if (phoneController.text.characters.first == "1") {
          setState(() {});
        } else {
          setState(() {});
        }
      }
      /*  if (phoneController.text.length == 10) {
        setState(() {});
      } */
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 24, top: 24),
                child: Text(
                  "Register".toUpperCase(),
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
                      fontSize: 32),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: usernameController,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontStyle: FontStyle.italic),
                    labelText: "Username",
                    errorText:
                        !isUsername ? ConstErrorMessage.usernameField : null,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontStyle: FontStyle.italic),
                    labelText: "Email",
                    errorText: !isEmail ? ConstErrorMessage.emailField : null,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                  // readOnly: phoneController.text.length == 10,
                  decoration: InputDecoration(
                      prefixText: '+880 ',
                      labelText: "Mobile Number",
                      errorStyle: TextStyle(fontStyle: FontStyle.italic),
                      // errorText: _mError()),
                      errorText: !isPhone
                          ? ConstErrorMessage.phoneField
                          : !phoneController.text.isEmpty
                              ? phoneController.text.characters.first != "1"
                                  ? ConstErrorMessage.phoneFieldWrongDigit
                                  : phoneController.text.length > 10
                                      ? ConstErrorMessage.phoneFieldNumExceeded
                                      : null
                              : null),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: passController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    errorStyle: TextStyle(fontStyle: FontStyle.italic),
                    errorText: !isPass ? ConstErrorMessage.passField : null,
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: confirmPassController,
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      errorStyle: TextStyle(fontStyle: FontStyle.italic),
                      errorText: !isConfirmPass
                          ? ConstErrorMessage.confirmPassField
                          : null),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: DropdownButton<String>(
                  value: dropDownValue,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                  underline: Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  onChanged: (data) {
                    setState(() {
                      dropDownValue = data!;
                    });
                  },
                  items: LocalServices.spinnerItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: isLoading
                    ? Container(
                        height: 32,
                        width: 32,
                        margin: EdgeInsets.only(right: 24),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: _colorTwinProgressbar,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _mInputValidation();
                          /* String s = MyServices.mEncode('Ab@c.d');
                          print(s); */
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.0,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: LinearGradient(colors: [
                                Colors.green,
                                // Color.fromARGB(255, 41, 255, 52)
                                Color.fromARGB(255, 65, 233, 152),
                              ])),
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            "SIGN UP",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ),
              Container(
                margin: EdgeInsets.only(right: 24, top: 20),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Already have an Account?"),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen())); */
                        Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 650),
                                type: PageTransitionType.leftToRight,
                                child: LoginSceen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Sign In",
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
              /* Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: InkWell(
                  onTap: () => {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Already Have an Account? Sign in",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)),
                    ),
                  ),
                ),
              ) */
            ],
          ),
        ),
      ),
    );
  }

  void _mInputValidation() {
    usernameController.text.isEmpty ? isUsername = false : isUsername = true;

    //check valid email input
    /*  var email = "tony@starkindustries.com"
bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email); */

    emailController.text.isEmpty
        ? isEmail = false
        : isEmail = true; //check User name field is empty or not
    /*    phoneController.text.isEmpty || phoneController.text.length < 11
        ? isPhone = false
        : isPhone = true;  */ //check Mobile number field is empty or not
    passController.text.isEmpty || passController.text.length < 6
        ? isPass = false
        : isPass = true; //check Password field is empty or not
    confirmPassController.text.isEmpty ||
            confirmPassController.text != passController.text
        ? isConfirmPass = false
        : isConfirmPass = true; ////check confirm password field is empty or not

    if (isUsername &&
        isEmail &&
        isPhone &&
        isPass &&
        isConfirmPass &&
        dropDownValue != 'Select category') {
      //do sign up
      setState(() {
        isLoading = true;
        mSignupUser(emailController.text, passController.text,
            usernameController.text, phoneController.text);
      });
    } else {
      setState(() {});
    }
  }

  Future<String?> mSignupUser(
      String email, String pass, String username, String phone) async {
    return Future.delayed(Duration(milliseconds: 0)).then((_) async {
      try {
        UserCredential authResult = await mAuth.createUserWithEmailAndPassword(
            email: email, password: pass);

        print(ConstPrintColor.printGreen +
            "Registered Successfull" +
            ConstPrintColor.endColor);
        User user = authResult.user!;
        await user.sendEmailVerification().then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Email confirmation has been sent",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black87,
                ))); //send verification email

        //save information into firebase
        /* ServicesFirestore.collRefUser.add({
          /* ConstKeys.uKeyEmail: email,
          ConstKeys.uKeyPass: pass,
          ConstKeys.uKeyName: username,
          ConstKeys.uKeyPhone: phone, */
          ConstKeys.uKeyEmail: MyServices.mEncode(email),
          ConstKeys.uKeyPass: MyServices.mEncode(pass),
          ConstKeys.uKeyName: MyServices.mEncode(username),
          ConstKeys.uKeyPhone: MyServices.mEncode(phone),
          ConstKeys.uCategory: dropDownValue,
          ConstKeys.uKeyUid: user.uid,
          ConstKeys.uKeyCreatedDate: DateTime.now().millisecondsSinceEpoch,
        }) */
        ServicesFirestore.mSaveData(
                userType: dropDownValue,
                email: MyServices.mEncode(email),
                pass: MyServices.mEncode(pass),
                username: MyServices.mEncode(username),
                phone: MyServices.mEncode('0'+phone),
                userId: user.uid)
            .then((value) {
          print(ConstPrintColor.printGreen +
              "Successfully save user info" +
              ConstPrintColor.endColor);

          //Navigate to Login Screen
          Navigator.pushReplacement(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 300),
                  child: LoginSceen(),
                  type: PageTransitionType.leftToRight));
        }).catchError((error) {
          print(ConstPrintColor.printRed +
              "Error: ${error.toString()}" +
              ConstPrintColor.endColor);
        });
        /*  else {
          setState(() {
            isLoading = false;
          });
          print(ConstPrintColor.printRed +
              "Error in Registraion" +
              ConstPrintColor.endColor);
        } */
      } on FirebaseException catch (e) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              e.message.toString(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: Duration(milliseconds: 2000),
          ));
        });
        print(ConstPrintColor.printBlue +
            e.message.toString() +
            ConstPrintColor.endColor);
      }
    });
  }

  _mError() {
    isPhone
        ? ConstErrorMessage.phoneField
        : /* phoneController.text.characters.first != "1" && !phoneController.text.isEmpty
                            ? ConstErrorMessage.phoneFieldWrongDigit
                            :  */
        null;
  }
}
