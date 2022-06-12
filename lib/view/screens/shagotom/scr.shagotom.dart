// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_hospital_app/controller/services/service.colors_array.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/consts/const.keywords.dart';
import 'package:my_hospital_app/view/screens/dayetto/scr.dayetto.dart';
import 'package:my_hospital_app/view/screens/jiggasha/scr.jiggasha.dart';
import 'package:my_hospital_app/view/screens/khabar/scr.khabar.dart';
import 'package:my_hospital_app/view/screens/note/scr.note.dart';
import 'package:my_hospital_app/view/screens/pragnency/emergency/scr.emergency.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/scr.ojon.dart';
import 'package:my_hospital_app/view/screens/shagotom/widgets/wdgt.shaptahikPoriborton.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../scale/scr.scale.dart';
import 'widgets/wdgt.ek_nojore.dart';

class ShagotomScreen extends StatefulWidget {
  const ShagotomScreen({Key? key}) : super(key: key);

  @override
  State<ShagotomScreen> createState() => _ShagotomScreenState();
}

class _ShagotomScreenState extends State<ShagotomScreen> {
  late int runningDays;
  late int totalRunningDays;
  late int runningWeeks;
  late int runningMonths;
  late int totalRemaingingDays;
  late DateTime startDate;
  late DateTime endDate;
  late DateTime today;
  late List<Color> timestarColorList;
  double iconHeight = 38;
  double? iconWidth = 38;

  @override
  void initState() {
    super.initState();
    _mValueInit(); //initailize declared variable
    _mLoadData(); //load data from SharedPref
    _mGetColorList(); //Get Colors array for timestar blocks
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.pink2,
        leading: const Icon(
          Icons.arrow_back,
          color: MyColors.textOnPrimary,
        ),
        title: const CustomText(
          text: MaaData.welcome,
          fontcolor: MyColors.textOnPrimary,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontsize: 24,
        ),
        actions: [
          Image.asset('lib/assets/images/menu.png', width: 23, height: 23),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.pink2,
        onPressed: () {
          showMaterialModalBottomSheet(
              context: context,
              builder: (context) => Container(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  // height: MyScreenSize.mGetHeight(context, 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //1
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmergencyScreen())),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'lib/assets/images/emergency_i.png'),
                                  width: iconWidth,
                                  height: iconHeight,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Emergency")
                              ],
                            ),
                          ),

//2
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => DayettoScreen())),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'lib/assets/images/responsibilities_i.png'),
                                  width: iconWidth,
                                  height: iconHeight,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Responsibilities")
                              ],
                            ),
                          ),

//3
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => KhabarScreen()));
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  image: AssetImage(
                                      'lib/assets/images/food_i.png'),
                                  width: iconWidth,
                                  height: iconHeight,
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("Food")
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
//4
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OjonScreen()));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'lib/assets/images/line_chart_for_weight.png'),
                                    width: iconWidth,
                                    height: iconHeight,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Weight")
                                ],
                              ),
                            ),

//5
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NoteScreen()));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'lib/assets/images/note_i.png'),
                                    width: iconWidth,
                                    height: iconHeight,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Note")
                                ],
                              ),
                            ),

//6
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => JiggashaScreen()));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'lib/assets/images/ic_action_help.png'),
                                    width: iconWidth,
                                    height: iconHeight,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text("Help")
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )));
        },
        child: Image(
          image: AssetImage('lib/assets/images/ic_action_tiles_large.png'),
          width: 38,
          height: 38,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //vEk nojore
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ScalScreen(
                        runningDays: runningDays,
                        runningWeeks: runningWeeks,
                        runningMonths: runningMonths == 0 ? 1 : runningMonths,
                        totalRunningDays: totalRunningDays,
                        totalRemaingingDays: totalRemaingingDays,
                        timestarColorList: timestarColorList);
                  }));
                },
                child: EkNojoreView(
                    runningDays: runningDays,
                    runningWeeks: runningWeeks,
                    totalRemaingingDays: totalRemaingingDays,
                    timestarColorList: timestarColorList),
              ),
              SizedBox(
                height: 16,
              ),

              ShaptahikPoriborton(
                  callback: () {},
                  runningDays: runningDays,
                  runningWeeks: runningWeeks,
                  totalRunningDays: totalRunningDays)
              //Shaptahik Poriborton
            ],
          ),
        ),
      ),
    );
  }

  void _mLoadData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String? s = _pref.getString(MyKeywords.startdate);
    String? e = _pref.getString(MyKeywords.enddate);
    int? totatDays = _pref.getInt(MyKeywords.totaldays);

    startDate = DateTime.parse(s!);
    endDate = DateTime.parse(e!);

    totalRunningDays = MyServices.mGettotalDaysBtween(startDate, today);

    setState(() {
      runningDays = (totalRunningDays % 7);
      runningWeeks = (totalRunningDays / 7).floor();
      runningMonths = (totalRunningDays / 30).ceil();

      totalRemaingingDays = totatDays! - totalRunningDays;

      _pref.setInt(MyKeywords.runningDays, runningDays);
      _pref.setInt(MyKeywords.actualRunningWeeks, runningWeeks);
      _pref.setInt(MyKeywords.runningMonths, runningMonths);
      _pref.setInt(MyKeywords.totalRemaingingDays, totalRemaingingDays);
    });
  }

  void _mGetColorList() async {
    timestarColorList = await MyColorArray.mGetTimestartColorArray();
    // print(timestartColorList.length);
  }

  void _mValueInit() {
    today = DateTime.now();
    runningDays = 0;
    runningWeeks = 0;
    totalRunningDays = 0;
    totalRemaingingDays = 0;
    timestarColorList = [];
  }
}
