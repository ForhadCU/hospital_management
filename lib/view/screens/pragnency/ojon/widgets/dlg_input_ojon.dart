// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class InputOjonDialog extends StatefulWidget {
  const InputOjonDialog({Key? key}) : super(key: key);

  @override
  State<InputOjonDialog> createState() => _InputOjonDialogState();
}

class _InputOjonDialogState extends State<InputOjonDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      /* insetAnimationDuration: Duration(microseconds: 3000),
      insetAnimationCurve: Curves.bounceInOut, */
      insetPadding: EdgeInsets.all(16),
      child: Container(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            color: MyColors.c2,
            alignment: Alignment.center,
            child: CustomText(
              text: 'আপনার প্রাথমিক ওজন ও উচ্চতা দিন',
              fontWeight: FontWeight.w600,
              fontcolor: MyColors.textOnPrimary,
              fontsize: 18,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Weight
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'ওজন',
                            fontcolor: Colors.grey,
                            fontsize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.0',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: 'কেজি',
                            fontWeight: FontWeight.w500,
                            fontsize: 16,
                            fontcolor: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.0',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: 'পাউন্ড',
                            fontWeight: FontWeight.w500,
                            fontsize: 16,
                            fontcolor: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              //Height
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'উচ্চতা',
                            fontcolor: Colors.grey,
                            fontsize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0.0',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            text: 'সেমি',
                            fontWeight: FontWeight.w500,
                            fontsize: 16,
                            fontcolor: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text: 'ফিট',
                                    fontWeight: FontWeight.w500,
                                    fontsize: 16,
                                    fontcolor: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CustomText(
                                    text: 'ইঞ্চি',
                                    fontWeight: FontWeight.w500,
                                    fontsize: 16,
                                    fontcolor: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: 'বাতিল',
                    fontcolor: MyColors.c3,
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  CustomText(
                    text: 'সংরক্ষণ',
                    fontcolor: MyColors.c3,
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          )
        ]),
      ),
    );
  }
}
