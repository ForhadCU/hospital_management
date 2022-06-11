import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/widgets/dialog/profile_edit_dlg.dart';

class PatientProfileScreen extends StatefulWidget {
  final String uid;
  final String name;
  final String gmail;
  final String phone;
  const PatientProfileScreen(
      {super.key,
      required this.uid,
      required this.name,
      required this.gmail,
      required this.phone});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late String personName;
  late String mobile;
  late String gmail;
  late String age;
  late String address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomStatusBar.mGetPrimaryStatusBar();
    gmail = widget.gmail;
    mobile = widget.phone;
    personName = widget.name;
    age = '24';
    address = 'Fateyabad, Chittagong';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.c3,
          title: CustomText(
            text: 'Profile',
            fontWeight: FontWeight.w400,
            fontcolor: Colors.white,
            fontsize: 22,
          )),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 24),
          padding: EdgeInsets.only(right: 14, left: 14, bottom: 24, top: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'lib/assets/user1.jpeg',
                            width: 72,
                            height: 72,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: personName,
                              fontWeight: FontWeight.bold,
                              fontsize: 20,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: gmail,
                              fontsize: 14,
                            ),
                            SizedBox(height: 4),
                            CustomText(
                              text: mobile,
                              fontsize: 14,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){

                      showDialog(
                          context: context,
                          builder: (context) {
                            return ProfileEditDialog(
                                callback: (String name, String g, String phone,
                                    String a, String addr) {
                                  personName = name;
                                  gmail = g;
                                  mobile = phone;
                                  age = a;
                                  address = addr;
                                  print(widget.uid);
                                  ServicesFirestore.mUpdatePatientData(
                                      widget.uid,
                                      MyServices.mEncode(name),
                                      MyServices.mEncode(g),
                                      MyServices.mEncode(phone));
                                  setState(() {});
                                },
                                name: personName,
                                gmail: gmail,
                                mobile: mobile,
                                age: age,
                                address: address);
                          });
                  
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Icon(Icons.edit)],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                height: 1,
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: 'Age',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: ':',
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CustomText(
                            text: age,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: 'Height',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: ':',
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CustomText(
                            text: '4\' 3\'\'',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: 'Weight',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: ':',
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CustomText(
                            text: '64 kg',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: 'Address',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      CustomText(
                        text: ':',
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          CustomText(
                            text: address,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
