// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/item_ojondataList.dart';

class OjonAndWeekListWidget extends StatefulWidget {
  const OjonAndWeekListWidget({Key? key}) : super(key: key);

  @override
  State<OjonAndWeekListWidget> createState() => _OjonAndWeekListWidgetState();
}

class _OjonAndWeekListWidgetState extends State<OjonAndWeekListWidget> {
  late final List<Ojon> ojonList;
  double titleTextSize = 18;
  @override
  void initState() {
    super.initState();
    ojonList = MyServices.mGetOjonData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyScreenSize.mGetHeight(context, 35),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          // color: MyColors.demo1,
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          //heading
          Container(
            color: MyColors.c1,
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            child: CustomText(
              text: 'সাপ্তাহিক ওজন',
              fontsize: titleTextSize,
              fontcolor: MyColors.textOnPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          //List
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 6, left: 18, right: 18, bottom: 6),
            color: MyColors.col,
            child: Column(children: [
              //List heading
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "সপ্তাহ নং",
                          fontcolor: MyColors.textOnPrimary,
                          fontsize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "ওজন কেজি",
                          fontcolor: MyColors.textOnPrimary,
                          fontsize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //horizontal Line
              Divider(
                height: 1,
                thickness: 1,
                color: MyColors.textOnPrimary,
              ),
              //List Body
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 2),
                  child: ListView.builder(
                      itemCount: ojonList.length,
                      itemBuilder: (context, index) {
                        return OjonDataListItem(
                            week: ojonList[index].week,
                            ojon: ojonList[index].weight);
                      }),
                ),
              )
            ]),
          ))
        ],
      ),
    );
  }
}
