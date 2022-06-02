// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/dlg_input_ojon.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/wdgt.graphPart.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/wdgt.ojonAndWeekPart.dart';

class OjonScreen extends StatefulWidget {
  OjonScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OjonScreen> createState() => _OjonScreenState();
}

class _OjonScreenState extends State<OjonScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const CustomText(
          text: 'ওজন',
          fontsize: 24,
          fontcolor: MyColors.textOnPrimary,
          fontWeight: FontWeight.normal,
        ),
        backgroundColor: MyColors.c2,
        actions: [
          IconButton(
              onPressed: () {
                print('Ojon Icon Butto0n');
                //show ojon input dialog
                showDialog(
                    context: context, builder: (context) => InputOjonDialog());
              },
              icon: Image.asset(
                'lib/assets/images/add_note_weight_icon.png',
                color: Colors.white,
              )),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Ojon and Week List
              OjonAndWeekListWidget(),
              SizedBox(
                height: 10,
              ),

              //Graph List
              GraphWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
