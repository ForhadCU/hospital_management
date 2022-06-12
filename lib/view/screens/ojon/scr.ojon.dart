import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.keywords.dart';
import 'package:my_hospital_app/model/model.max_min_weightlist.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:my_hospital_app/view/screens/ojon/widgets/dlg_input_primary_ojon.dart';
import 'package:my_hospital_app/view/screens/ojon/widgets/wdgt.graphPart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/dlg_input_ojon.dart';
import 'widgets/wdgt.ojonAndWeekPart.dart';

class OjonScreen extends StatefulWidget {
  const OjonScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OjonScreen> createState() => _OjonScreenState();
}

class _OjonScreenState extends State<OjonScreen> {
  late bool isSetPrimaryWeight = false;
  double primaryWeight = 0.00;
  List<double> currentWeightsList = [];
  List<double> minWeight = [];
  List<double> maxWeight = [];
  late SharedPreferences sharedPreferences;
  late int _actualWeeks = 0;
  late int _runningWeeks = 0;
  late int _currentRoundValue = 0;
  late int _currentFrucValueAsInt = 0;
  late double _lastUpdatedWeight = 0.00;
  late List<Ojon> maxOjonList = [];
  late List<Ojon> minOjonList = [];
  late List<Ojon> currentOjonList = [];
  late List<Ojon> maxOjonList1 = [];

  @override
  void initState() {
    super.initState();
    MyServices.mGetSharedPrefIns().then((value) {
      setState(() {
        sharedPreferences = value;
        currentWeightsList =
            MyServices.mGetWeightList(sharedPreferences: sharedPreferences);
        // _priWeight = sharedPreferences.getDouble(MyKeywords.primaryWeight)!;
        _actualWeeks = sharedPreferences.getInt(MyKeywords.actualRunningWeeks)!;
        _runningWeeks = _actualWeeks + 1;

        //check initially primary weight existed or not
        isSetPrimaryWeight = MyServices.mCheckPrimaryWeight(
            sharedPreferences: sharedPreferences);
        print(isSetPrimaryWeight);
        if (!isSetPrimaryWeight) {
          showDialog(
              context: context,
              builder: (context) => InputPrimaryOjonDialog(
                    callBack: (double w, double h) {
                      setState(() {
                        MyServices.mCalcAndSavePriBMI(
                            sharedPreferences: sharedPreferences,
                            weight: w,
                            height: h);
                        primaryWeight = w;
                        isSetPrimaryWeight = true;
                        MyServices.mSetLastUpdatedWeight(
                            sharedPreferences: sharedPreferences, w: w);
                        _lastUpdatedWeight = MyServices.mGetLastUpdatedWeight(
                            sharedPreferences: sharedPreferences);
                        _currentRoundValue = _lastUpdatedWeight.floor();
                        MyServices.mSetFrucValueAsInt(
                            priWeight: _lastUpdatedWeight,
                            callback: (int value) {
                              _currentFrucValueAsInt = value;
                            });

                        //get Graph data
                        final List<MaxMinWeightListModel> list =
                            MyServices.mGetMaxMinWeihtList(
                                // oldWeightList: currentWeightsList,
                                isItFirsttime: true,
                                runningWeeks: _runningWeeks,
                                oldWeightList: currentWeightsList,
                                bmi: sharedPreferences
                                    .getDouble(MyKeywords.primaryBMI)!,
                                primaryWeight: primaryWeight);
                        for (var i = 0; i < list.length; i++) {
                          MaxMinWeightListModel listModel = list[i];
                          maxOjonList = listModel.maxWeightList;
                          minOjonList = listModel.minWeightList;
                          // currentOjonList = listModel.currentWeightList;
                        }
                      });
                    },
                  ));
        } else {
          setState(() {
            _lastUpdatedWeight = MyServices.mGetLastUpdatedWeight(
                sharedPreferences: sharedPreferences);
            _currentRoundValue = _lastUpdatedWeight.floor();
            MyServices.mSetFrucValueAsInt(
                priWeight: _lastUpdatedWeight,
                callback: (int value) {
                  _currentFrucValueAsInt = value;
                });
            primaryWeight = MyServices.mGetPrimaryWeight(
                sharedPreferences: sharedPreferences);
            isSetPrimaryWeight = true;

            //get Graph data
            final List<MaxMinWeightListModel> list =
                MyServices.mGetMaxMinWeihtList(
                    // oldWeightList: currentWeightsList,
                    isItFirsttime: false,
                    runningWeeks: _runningWeeks,
                    oldWeightList: currentWeightsList,
                    bmi: sharedPreferences.getDouble(MyKeywords.primaryBMI)!,
                    primaryWeight: primaryWeight);
            for (var i = 0; i < list.length; i++) {
              MaxMinWeightListModel listModel = list[i];
              maxOjonList = listModel.maxWeightList;
              minOjonList = listModel.minWeightList;
              currentOjonList = listModel.currentWeightList;
              /* for (var element in currentOjonList) {
                print(element.week + ": " + element.weight);
              } */
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const CustomText(
          text: 'ওজন',
          fontsize: 24,
          fontcolor: MyColors.textOnPrimary,
          fontWeight: FontWeight.normal,
        ),
        backgroundColor: MyColors.pink2,
        actions: [
          IconButton(
              onPressed: () {
                //show ojon input dialog
                showDialog(
                    context: context,
                    builder: (context) => isSetPrimaryWeight
                        ? InputOjonDialog(
                            currentRoundValue: _currentRoundValue,
                            currentFrucValueAsInt: _currentFrucValueAsInt,
                            runningWeeks: _runningWeeks,
                            callback: (double w) {
                              setState(() {
                                _lastUpdatedWeight = w;
                                _currentRoundValue = _lastUpdatedWeight.floor();
                                MyServices.mSetFrucValueAsInt(
                                    priWeight: _lastUpdatedWeight,
                                    callback: (int value) {
                                      _currentFrucValueAsInt = value;
                                    });
                                MyServices.mSetLastUpdatedWeight(
                                    sharedPreferences: sharedPreferences, w: w);
                                currentWeightsList =
                                    MyServices.mUpdateCurrentWeightList(
                                        sharedPreferences: sharedPreferences,
                                        updatedWeight: w,
                                        actRunningWeek: _actualWeeks);
                                // print("Current weightlist : "+currentWeightsList.toString());
                                //get graph data
                                /*  currentOjonList =
                                    MyServices.mGetCurrentWeightList(
                                        primaryWeight: primaryWeight,
                                        oldWeightList: currentWeightsList,
                                        runningWeeks: _runningWeeks); */

                                /*      for (var i = 0;
                                    i < currentOjonList.length;
                                    i++) {
                                  Ojon ojon = currentOjonList[i];
                                  print("Ojon " + ojon.weight);
                                } */

                                /*  final List<MaxMinWeightListModel> list =
                                    MyServices.mGetMaxMinWeihtList(
                                        oldWeightList: currentWeightsList,
                                        bmi: sharedPreferences
                                            .getDouble(MyKeywords.primaryBMI)!,
                                        primaryWeight: primaryWeight);
                                for (var i = 0; i < list.length; i++) {
                                  MaxMinWeightListModel listModel = list[i];
                                  maxOjonList = listModel.maxWeightList;
                                  minOjonList = listModel.minWeightList;
                                  currentOjonList = listModel.currentWeightList;
                                } */
                              });
                            },
                          )
                        : InputPrimaryOjonDialog(
                            callBack: (double w, double h) {
                              setState(() {
                                MyServices.mCalcAndSavePriBMI(
                                    sharedPreferences: sharedPreferences,
                                    weight: w,
                                    height: h);
                                primaryWeight = w;
                                isSetPrimaryWeight = true;
//for existed weight
                                MyServices.mSetLastUpdatedWeight(
                                    sharedPreferences: sharedPreferences, w: w);
                                _lastUpdatedWeight =
                                    MyServices.mGetLastUpdatedWeight(
                                        sharedPreferences: sharedPreferences);
                                _currentRoundValue = _lastUpdatedWeight.floor();
                                MyServices.mSetFrucValueAsInt(
                                    priWeight: _lastUpdatedWeight,
                                    callback: (int value) {
                                      _currentFrucValueAsInt = value;
                                    });
                              });
                            },
                          ));
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
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Ojon and Week List
              OjonAndWeekListWidget(
                  primaryWeight: primaryWeight,
                  currentWeights: currentWeightsList),
              const SizedBox(
                height: 10,
              ),

              //Graph List
              GraphWidget(
                primaryWeight: primaryWeight,
                maxOjonList: maxOjonList1,
                minOjonList: minOjonList,
                currentOjonList: currentOjonList,
                isSetPrimaryWeight: isSetPrimaryWeight,
                callback: (double w, double h) {
                  setState(() {
                    MyServices.mCalcAndSavePriBMI(
                        sharedPreferences: sharedPreferences,
                        weight: w,
                        height: h);

                    primaryWeight = w;
                    isSetPrimaryWeight = true;

                    //for existed weight
                    MyServices.mSetLastUpdatedWeight(
                        sharedPreferences: sharedPreferences, w: w);
                    _lastUpdatedWeight = MyServices.mGetLastUpdatedWeight(
                        sharedPreferences: sharedPreferences);
                    _currentRoundValue = _lastUpdatedWeight.floor();
                    MyServices.mSetFrucValueAsInt(
                        priWeight: _lastUpdatedWeight,
                        callback: (int value) {
                          _currentFrucValueAsInt = value;
                        });
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
