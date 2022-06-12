// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/consts/const.keywords.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:my_hospital_app/model/model.daiyetto.dart';
import 'package:my_hospital_app/model/model.emergency.dart';
import 'package:my_hospital_app/model/model.history.dart';
import 'package:my_hospital_app/model/model.jiggasha.dart';
import 'package:my_hospital_app/model/model.kahbar.dart';
import 'package:my_hospital_app/model/model.max_min_weightlist.dart';
import 'package:my_hospital_app/model/model.note.dart';
import 'package:my_hospital_app/model/model.symp.dart';
import 'package:my_hospital_app/model/model.symp_intensity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sqflite_services.dart';

class MyServices {
  static Future<List<HistoryModel>> mGetHistoryGraphValue() async {
    List<String> xValueList = MaaData.xValueList;
    List<String> yValueList = MaaData.yValueList;
    List<HistoryModel> historyModelList = [];
    List<String> valueList = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('DOCTORS').get();
      for (var element in querySnapshot.docs) {
        valueList.add(element.id);
      }

    for (var i = 0; i < xValueList.length; i++) {
      historyModelList
          .add(HistoryModel(xValue: xValueList[i], yValue: yValueList[i]));
    }

    return historyModelList;
  } 
   static Future<List<HistoryModel>> mGetHistoryGraphValue2() async {
    List<String> xValueList = MaaData.xValueList2;
    List<String> yValueList = MaaData.yValueList2;
    List<HistoryModel> historyModelList = [];
    List<String> valueList = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await db.collection('DOCTORS').get();
      for (var element in querySnapshot.docs) {
        valueList.add(element.id);
      }

    for (var i = 0; i < xValueList.length; i++) {
      historyModelList
          .add(HistoryModel(xValue: xValueList[i], yValue: yValueList[i]));
    }

    return historyModelList;
  }

  static String mGetCurrentTime() {
    DateTime d = DateTime.now();
    String s = DateFormat('hh:mm a').format(d);

    return s;
  }

  static String mGetCurrentDate() {
    DateTime d = DateTime.now();
    String s = DateFormat('yMMMMd').format(d);

    return s;
  }

  static String mEncode(String orginalStr) {
    //Using Caesar Chiper Encryption Method
    List<String> UpperCharList = [];
    List<String> LowerCharList = [];
    // String orginalStr = "Abc@ Zy";
    // String orginalStr = "Def@ Cb";
    int k = 3;

    //Uppercase Letters
    for (var i = 65; i <= 90; i++) {
      UpperCharList.add(String.fromCharCode(i));
    }
    //LowerCase Letters
    for (var i = 97; i <= 122; i++) {
      LowerCharList.add(String.fromCharCode(i));
    }

//Encode
    for (var i = 0; i < orginalStr.length; i++) {
      String updatedSubStr = orginalStr[i];
      int currentCharAscii = orginalStr.codeUnitAt(i);

      if (currentCharAscii >= 65 && currentCharAscii <= 90) {
        int p = UpperCharList.indexOf(orginalStr[i]);
        updatedSubStr = UpperCharList.elementAt((k + p) % 26);
      } else if (currentCharAscii >= 97 && currentCharAscii <= 122) {
        int p = LowerCharList.indexOf(orginalStr[i]);
        updatedSubStr = LowerCharList.elementAt((k + p) % 26);
      }

      orginalStr = orginalStr.substring(0, i) +
          updatedSubStr +
          orginalStr.substring(i + 1);
    }

    /*    print("Updated Caeser-Chiper Encode String is : $orginalStr");
  */

    return orginalStr;
  }

  static String mDecode(String orginalStr) {
    //Using Caesar Chiper Encryption Method

    List<String> UpperCharList = [];
    List<String> LowerCharList = [];
    // String orginalStr = "Abc@ Zy";
    // String orginalStr = "Def@ Cb";
    int k = 3;

    //Uppercase Letters
    for (var i = 65; i <= 90; i++) {
      UpperCharList.add(String.fromCharCode(i));
    }
    //LowerCase Letters
    for (var i = 97; i <= 122; i++) {
      LowerCharList.add(String.fromCharCode(i));
    }

//Decode
    for (var i = 0; i < orginalStr.length; i++) {
      String updatedSubStr = orginalStr[i];
      int currentCharAscii = orginalStr.codeUnitAt(i);

      if (currentCharAscii >= 65 && currentCharAscii <= 90) {
        int p = UpperCharList.indexOf(orginalStr[i]);
        updatedSubStr = UpperCharList.elementAt((p - k) % 26);
      } else if (currentCharAscii >= 97 && currentCharAscii <= 122) {
        int p = LowerCharList.indexOf(orginalStr[i]);
        updatedSubStr = LowerCharList.elementAt((p - k) % 26);
      }

      orginalStr = orginalStr.substring(0, i) +
          updatedSubStr +
          orginalStr.substring(i + 1);
    }
    //  print("Updated Caeser-Chiper Decode String is : $orginalStr");
    return orginalStr;
  }

  static int mGettotalDaysBtween(DateTime startDate, DateTime endDate) {
    int totalDaysBetween = _mGetDiffBetween(startDate, endDate);
    return totalDaysBetween;
  }

  static int _mGetDiffBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  static String getBangNumFormat(int num) {
    String numStr = '';
    if (num == 2 || num == 3) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[1];
    } else if (num == 4) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[2];
    } else if (num == 6) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[3];
    } else if (num <= 10) {
      numStr = mGenerateBangNum(num) + MaaData.bangDateSuffix[0];
    } else if (num <= 45) {
      numStr = mGenerateBangNum(num) + MaaData.bangDateSuffix[4];
    }

    return numStr;
  }

  static num getTimestarNum(int days) {
    if (days <= 26) {
      return (days / 13).ceil().toInt();
    } else {
      return 3;
    }
  }

  static String mGenerateBangNum(int num) {
    String inputStr = num.toString();
    String outputStr = '';

    for (var i = 0; i < inputStr.length; i++) {
      outputStr = outputStr + MaaData.bangNum[int.parse(inputStr[i])];
    }
    return outputStr;
  }

  static List<Ojon> mGetOjonData() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjons();
    List<String> dummyWeeks = mGetDummyWeeks();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<Ojon> mGetOjonDataForGraph() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjonsForGraph();
    List<String> dummyWeeks = mGetDummyWeeksForGraph();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon;
      if (i == 20) {
        ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      }
      ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<Ojon> mGetOjonDataForGraph1() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjonsForGraph1();
    List<String> dummyWeeks = mGetDummyWeeksForGraph();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon;
      if (i == 20) {
        ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      }
      ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<String> mGetDummyOjons() {
    final List<String> dummyOjons = [];
    const int l = 41;
    const String element1 = "0.0";
    const String elememnt2 = "---";

    for (var i = 0; i < l; i++) {
      if (i == 0) {
        dummyOjons.add(element1);
      }
      dummyOjons.add(elememnt2);
    }
    return dummyOjons;
  }

  static List<String> mGetDummyWeeks() {
    final List<String> dummyWeeks = [];
    const int l = 41;
    const String elememnt3 = "প্রাথমিক ওজন";
    for (var i = 0; i < l; i++) {
      if (i == 0) {
        dummyWeeks.add(elememnt3);
      }
      dummyWeeks.add(i.toString());
    }
    return dummyWeeks;
  }

  static List<String> mGetDummyOjonsForGraph() {
    final List<String> dummyOjons = [];
    const int l = 41;

    for (var i = 0; i < l; i++) {
      if (i % 2 == 1) {
        dummyOjons.add((i + 6).toString());
      } else if (i == 0) {
        dummyOjons.add(i.toString());
      }
      dummyOjons.add((i + 4).toString());
    }
    return dummyOjons;
  }

  static List<String> mGetDummyOjonsForGraph1() {
    final List<String> dummyOjons = [];
    const int l = 41;

    for (var i = 0; i < l; i++) {
      if (i % 5 == 0) {
        dummyOjons.add((i + 2).toString());
      }
      dummyOjons.add(i.toString());
    }
    return dummyOjons;
  }

  static List<String> mGetDummyWeeksForGraph() {
    final List<String> dummyWeeks = [];
    const int l = 41;
    for (var i = 0; i < l; i++) {
      dummyWeeks.add(i.toString());
    }
    return dummyWeeks;
  }

  static List<KhabarModel> mGetKhabarModelList() {
    List<KhabarModel> list = [];
    List<String> title = MaaData.foodTitles;
    List<String> desc = MaaData.foodDesc;
    List<String> imgUri = MaaData.foodImages;
    for (var i = 0; i < title.length; i++) {
      list.add(
          KhabarModel(title: title[i], desc: desc[i], imgAssetUri: imgUri[i]));
    }
    return list;
  }

  static List<DayettoModel> mGetDayettoModelList() {
    List<DayettoModel> list = [];
    List<String> title = MaaData.respTitle;
    List<String> desc = MaaData.respDesc;
    List<String> imgUri = MaaData.respImgAssetUri;
    for (var i = 0; i < title.length; i++) {
      list.add(
          DayettoModel(title: title[i], desc: desc[i], imgAssetUri: imgUri[i]));
    }
    return list;
  }

  static List<EmergencyModel> mGetEmergencyModelList() {
    List<EmergencyModel> list = [];
    List<String> title = MaaData.emergDataTitle;
    List<String> desc = MaaData.emergencyDesc;
    List<String> imgUri = MaaData.emergImageAssetUri;
    for (var i = 0; i < title.length; i++) {
      list.add(EmergencyModel(
          title: title[i], desc: desc[i], imgAssetUri: imgUri[i]));
    }
    return list;
  }

  static List<JiggashaModel> mGetJiggashaModelList() {
    List<JiggashaModel> list = [];
    List<String> questions = MaaData.questions;
    List<String> answers = MaaData.answers;
    for (var i = 0; i < questions.length; i++) {
      list.add(JiggashaModel(ques: questions[i], ans: answers[i]));
    }
    return list;
  }

  static Future<Map<String, dynamic>> mUpdateNoteSympScreen(
      NoteModel noteModel,
      String note,
      String currentDate,
      SympIntenSityModel sympIntenSityModel,
      String symptoms,
      List<SymptomsModel> sympDataModelList,
      List<String> actualSympIntensity,
      List<String> actualSympNames) async {
    //note part
    if (noteModel.note != note) {
      int n = await SqfliteServices.addNote(noteModel);
      print("Num of Inserted note item: $n");
      /*   List<NoteModel> noteModelList =
                              await SqfliteServices.mFetchNotes(); */
      List<NoteModel> currentNote =
          await SqfliteServices.mFetchCurrentNote(currentDate);
      // print(noteModelList.length);
      if (currentNote.isNotEmpty) {
        note = currentNote[0].note;
      } else {
        note = "";
      }
    }
    //symptom part
    if (sympIntenSityModel.symptoms != symptoms) {
      int n = await SqfliteServices.addSympIntensity(sympIntenSityModel);

      SqfliteServices.mFetchCurrentSympIntensity(currentDate)
          .then((symptomModelList) {
        SympIntenSityModel model = symptomModelList[0];
        symptoms = model.symptoms;
        sympDataModelList =
            MyServices.mGetSympDataList(sympIntensityStr: symptoms);
        actualSympNames = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympNames'];
        actualSympIntensity = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympIntensity'];
      });
      // print(sympIntenSityModel.symptoms);
    }
    return {
      "note": note,
      "symptoms": symptoms,
      "sympDataModelList": sympDataModelList,
      "actualSympNames": actualSympNames,
      "actualSympIntensity": actualSympIntensity
    };
  }

  static Map<String, dynamic> mGetSympIntensityStr(
      List<SymptomsModel> sympDataList) {
    String sympIntensityStr = "";
    const String separator = ",";
    List<String> actualSympIntensity = [];
    List<String> actualSympNames = [];
    for (var i = 0; i < sympDataList.length; i++) {
      SymptomsModel currentModel = sympDataList[i];
      sympIntensityStr = sympIntensityStr +
          currentModel.sympIntesity +
          (i == sympDataList.length - 1 ? "" : ",");
      //get actual list
      if (currentModel.sympIntesity != "") {
        actualSympIntensity.add(currentModel.sympIntesity);
        actualSympNames.add(currentModel.sympName);
      }
    }
    // List<String> strlist = sympIntensityStr.split(",");
    // print(strlist);
    return {
      "symptoms": sympIntensityStr,
      "actualSympIntensity": actualSympIntensity,
      "actualSympNames": actualSympNames
    };
  }

  static List<SymptomsModel> mGetSympDataList(
      {required String sympIntensityStr}) {
    List<SymptomsModel> list = [];
    List<String> symptomNames = MaaData.Symptoms;
    List<String> sympIntensities = sympIntensityStr.split(",");
    // print(sympIntensities.length);
    SymptomsModel model;
    for (var i = 0; i < symptomNames.length; i++) {
      list.add(new SymptomsModel(
          sympName: symptomNames[i], sympIntesity: sympIntensities[i]));
    }

    return list;
  }

  static List<Ojon> mGetCurrentWeightList(
      {required List<double> oldWeightList,
      required int runningWeeks,
      required double primaryWeight}) {
    List<Ojon> currentWeightList = [];
    Ojon currentOjon;
    currentOjon = Ojon(week: 0.toString(), weight: primaryWeight.toString());
    currentWeightList.add(currentOjon);

    List<double> updatedCurrentList = oldWeightList..insert(0, primaryWeight);
    double currentWeightLastValue = primaryWeight;
    //Currrent Weights
    for (var i = 1; i <= runningWeeks; i++) {
      Map<String, dynamic> weekValuMap =
          getWeekValue(i, updatedCurrentList, currentWeightLastValue);
      currentWeightLastValue = weekValuMap['lastValue'] ?? 0;
      // print(weekValuMap['step']);
      int times = 1;
      for (var j = 0; j < weekValuMap['step']; j++) {
        updatedCurrentList[i + j] = ((weekValuMap['inc']) * 2.2) * times++ +
            (i == 0 ? updatedCurrentList[i] : updatedCurrentList[i - 1]);
        print('Up: ${updatedCurrentList[i + j]}');
        currentWeightList.add(Ojon(
            week: (i + j).toString(),
            weight: (updatedCurrentList[i + j]).toStringAsFixed(2)));
      }
      i = weekValuMap['step'] + i - 1;
    }
    return currentWeightList;
  }

  static List<MaxMinWeightListModel> mGetMaxMinWeihtList(
      {/* required List<double> oldWeightList, */

      required double bmi,
      required double primaryWeight,
      required int runningWeeks,
      required List<double> oldWeightList,
      required bool isItFirsttime}) {
    List<MaxMinWeightListModel> maxminWeightList = [];
    List<Ojon> minWeightList = [];
    List<Ojon> maxWeightList = [];
    List<Ojon> currentWeightList = [];
    Ojon minOjon;
    Ojon maxOjon;
    Ojon currentOjon;

    minOjon = Ojon(week: 0.toString(), weight: primaryWeight.toString());
    maxOjon = Ojon(week: 0.toString(), weight: primaryWeight.toString());
    // currentOjon = Ojon(week: 0.toString(), weight: primaryWeight.toString());
/*     minOjon = Ojon(week: 0.toString(), weight: 0.toString());
    maxOjon = Ojon(week: 0.toString(), weight: 0.toString());
    currentOjon = Ojon(week: 0.toString(), weight: 0.toString()); */
    minWeightList.add(minOjon);
    maxWeightList.add(maxOjon);
    // currentWeightList.add(currentOjon);

    print("Current BMI: " + bmi.toString());

    if (bmi < 18.5) {
      //Under Weight
      print("Under");
      List<double> updatedMaxList = MaaData.underWtMx..insert(0, primaryWeight);
      List<double> updatedMinList = MaaData.underWtMn..insert(0, primaryWeight);
      // List<double> updatedCurrentList = oldWeightList..insert(0, primaryWeight);
      double maxlastValue = 0;
      double minlastValue = 0;
      double currentWeightLastValue = 0;

      //Max Weights
      for (var i = 1; i < updatedMaxList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMaxList, maxlastValue);
        maxlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMaxList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMaxList[i - 1];
          maxWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMaxList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }

      //Min Weights
      for (var i = 1; i < updatedMinList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMinList, minlastValue);
        minlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMinList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMinList[i - 1];
          minWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMinList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }

      /*    //Currrent Weights
      for (var i = 1; i < updatedCurrentList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedCurrentList, currentWeightLastValue);
        currentWeightLastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedCurrentList[i + j] =
              (weekValuMap['inc']) * times++ + updatedCurrentList[i - 1];
          currentWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedCurrentList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      } */
      if (!isItFirsttime) {
        currentWeightList = mGetCurrentWeightList(
            oldWeightList: oldWeightList,
            runningWeeks: runningWeeks,
            primaryWeight: primaryWeight);
      }

      maxminWeightList.add(MaxMinWeightListModel(
          minWeightList: minWeightList,
          maxWeightList: maxWeightList,
          currentWeightList: currentWeightList));

      /*   int j = 0;
      for (var element in updatedMaxList) {
        print("Index ${j} Updated maxWeight: $element");
        j++;
      }

      print("final value: ");
      for (var i = 0; i < maxWeightList.length; i++) {
        Ojon ojon = maxWeightList[i];
        print("Point $i :  (X, Y) = (${ojon.week}, ${ojon.weight}), ");
      } */
    } else if (bmi >= 18.5 && bmi < 25.0) {
      //Normal weight
      print("Normal");
      List<double> updatedMaxList = MaaData.normalWtMx
        ..insert(0, primaryWeight);
      List<double> updatedMinList = MaaData.normalWtMn
        ..insert(0, primaryWeight);
      double maxlastValue = 0;
      double minlastValue = 0;
      for (var i = 1; i < updatedMaxList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMaxList, maxlastValue);
        maxlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMaxList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMaxList[i - 1];
          maxWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMaxList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }
      for (var i = 1; i < updatedMinList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMinList, minlastValue);
        minlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMinList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMinList[i - 1];
          minWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMinList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }
      if (!isItFirsttime) {
        currentWeightList = mGetCurrentWeightList(
            oldWeightList: oldWeightList,
            runningWeeks: runningWeeks,
            primaryWeight: primaryWeight);
      }

      maxminWeightList.add(MaxMinWeightListModel(
          minWeightList: minWeightList,
          maxWeightList: maxWeightList,
          currentWeightList: currentWeightList));

      /*   int j = 0;
      for (var element in updatedMaxList) {
        print("Index ${j} Updated maxWeight: $element");
        j++;
      }

      print("final value: ");
      for (var i = 0; i < maxWeightList.length; i++) {
        Ojon ojon = maxWeightList[i];
        print("Point $i :  (X, Y) = (${ojon.week}, ${ojon.weight}), ");
      } */
    } else if (bmi >= 25.0 && bmi < 30.0) {
      //Over Weight
      print("OVer");
      List<double> updatedMaxList = MaaData.overWtMx..insert(0, primaryWeight);
      List<double> updatedMinList = MaaData.overWtMn..insert(0, primaryWeight);
      double maxlastValue = 0;
      double minlastValue = 0;
      for (var i = 1; i < updatedMaxList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMaxList, maxlastValue);
        maxlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMaxList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMaxList[i - 1];
          maxWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMaxList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }
      for (var i = 1; i < updatedMinList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMinList, minlastValue);
        minlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMinList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMinList[i - 1];
          minWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMinList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }

      if (!isItFirsttime) {
        currentWeightList = mGetCurrentWeightList(
            oldWeightList: oldWeightList,
            runningWeeks: runningWeeks,
            primaryWeight: primaryWeight);
      }

      maxminWeightList.add(MaxMinWeightListModel(
          minWeightList: minWeightList,
          maxWeightList: maxWeightList,
          currentWeightList: currentWeightList));

      /*   int j = 0;
      for (var element in updatedMaxList) {
        print("Index ${j} Updated maxWeight: $element");
        j++;
      }

      print("final value: ");
      for (var i = 0; i < maxWeightList.length; i++) {
        Ojon ojon = maxWeightList[i];
        print("Point $i :  (X, Y) = (${ojon.week}, ${ojon.weight}), ");
      } */
    } else if (bmi >= 30.0) {
      //Obess
      print("Obess");

      List<double> updatedMaxList = MaaData.obeseWtMx..insert(0, primaryWeight);
      List<double> updatedMinList = MaaData.obeseWtMn..insert(0, primaryWeight);
      // List<double> updatedCurrentList = oldWeightList..insert(0, primaryWeight);

      double maxlastValue = 0;
      double minlastValue = 0;
      double currentWeightLastValue = 0;

      for (var i = 1; i < updatedMaxList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMaxList, maxlastValue);
        maxlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMaxList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMaxList[i - 1];
          maxWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMaxList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }
      for (var i = 1; i < updatedMinList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedMinList, minlastValue);

        minlastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedMinList[i + j] =
              (weekValuMap['inc']) * times++ + updatedMinList[i - 1];
          minWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedMinList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      }

      if (!isItFirsttime) {
        currentWeightList = mGetCurrentWeightList(
            oldWeightList: oldWeightList,
            runningWeeks: runningWeeks,
            primaryWeight: primaryWeight);
      }

      /*     //Currrent Weights
      for (var i = 0; i < updatedCurrentList.length; i++) {
        Map<String, dynamic> weekValuMap =
            getWeekValue(i, updatedCurrentList, currentWeightLastValue);
        currentWeightLastValue = weekValuMap['lastValue'];
        int times = 1;
        for (var j = 0; j < weekValuMap['step']; j++) {
          updatedCurrentList[i + j] = (weekValuMap['inc']) * times++ +
              (i > 0 ? updatedCurrentList[i - 1] : updatedCurrentList[i]);
          currentWeightList.add(Ojon(
              week: (i + j).toString(),
              weight: (updatedCurrentList[i + j]).toStringAsFixed(2)));
        }
        i = weekValuMap['step'] + i - 1;
      } */

      maxminWeightList.add(MaxMinWeightListModel(
          minWeightList: minWeightList,
          maxWeightList: maxWeightList,
          currentWeightList: currentWeightList));
/* 
      int j = 0;
      for (var element in updatedMaxList) {
        print("Index ${j} Updated maxWeight: $element");
        j++;
      }

      print("final value: ");
      for (var i = 0; i < maxWeightList.length; i++) {
        Ojon ojon = maxWeightList[i];
        print("Point $i :  (X, Y) = (${ojon.week}, ${ojon.weight}), ");
      } */

    }
    return maxminWeightList;
  }

  static double mGetLastUpdatedWeight(
      {required SharedPreferences sharedPreferences}) {
    if (sharedPreferences.getDouble(MyKeywords.lastUpdatedWeight) != null) {
      return sharedPreferences.getDouble(MyKeywords.lastUpdatedWeight)!;
    } else {
      return 0.00;
    }
  }

  static void mSetLastUpdatedWeight(
      {required SharedPreferences sharedPreferences, required double w}) {
    sharedPreferences.setDouble(MyKeywords.lastUpdatedWeight, w);
  }

  static double mGetPrimaryWeight(
      {required SharedPreferences sharedPreferences}) {
    return sharedPreferences.getDouble(MyKeywords.primaryWeight)!;
  }

  static List<double> mUpdateCurrentWeightList(
      {required SharedPreferences sharedPreferences,
      required double updatedWeight,
      required int actRunningWeek}) {
    List<String> oldList =
        sharedPreferences.getStringList(MyKeywords.weihtList)!;
    oldList[actRunningWeek] = updatedWeight.toStringAsFixed(2);
    sharedPreferences.setStringList(MyKeywords.weihtList, oldList);
    oldList = sharedPreferences.getStringList(MyKeywords.weihtList)!;
    print("OjonList" + oldList.toString());
    List<double> oldListDoubleFormat = [];
    for (var i = 0; i < oldList.length; i++) {
      oldListDoubleFormat.add(double.parse(oldList[i]));
    }
    return oldListDoubleFormat;
  }

  //get weight list for OjonScreen WeekAndWeightList-part
  static List<double> mGetWeightList(
      {required SharedPreferences sharedPreferences}) {
    List<String> weihtList;
    if (sharedPreferences.getStringList(MyKeywords.weihtList) != null) {
      // print("weightlist is not null");
      List<double> weightListDoubleFormat = [];
      weihtList = sharedPreferences.getStringList(MyKeywords.weihtList)!;
      for (var i = 0; i < weihtList.length; i++) {
        weightListDoubleFormat.add(double.parse(weihtList[i]));
      }
      return weightListDoubleFormat;
    } else {
      weihtList = MyServices.mGetDummyOjons();
      // print("weightList is null");
      sharedPreferences.setStringList(MyKeywords.weihtList, weihtList);
      List<double> weightListDoubleFormat = [];
      for (var i = 0; i < weihtList.length; i++) {
        weightListDoubleFormat.add(double.parse(weihtList[i]));
      }
      return weightListDoubleFormat;
    }
  }

  static void mSetFrucValueAsInt(
      {required double priWeight, required Function callback}) {
    final String actValue = priWeight.toStringAsFixed(1);
    for (var i = 0; i < actValue.length; i++) {
      if (actValue[i] == '.') {
        callback(int.parse(actValue[i + 1]));
      } else
        continue;
    }
  }

  static Future<SharedPreferences> mGetSharedPrefIns() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref;
  }

  static void mCalcAndSavePriBMI(
      {required SharedPreferences sharedPreferences,
      required double weight,
      required double height}) {
    final double bmi = weight / (height / 100 * height / 100);

    sharedPreferences.setDouble(MyKeywords.primaryBMI, bmi);
    sharedPreferences.setDouble(MyKeywords.primaryWeight, weight);
    sharedPreferences.setDouble(MyKeywords.primaryHeight, height);
    sharedPreferences.setDouble(MyKeywords.lastUpdatedWeight, weight);
    if (sharedPreferences.getDouble(MyKeywords.primaryBMI) != null) {
      print("Data Entry successfull");
    }
  }

  /* static int mGettotalDaysBtween(DateTime startDate, DateTime endDate) {
    int totalDaysBetween = _mGetDiffBetween(startDate, endDate);
    return totalDaysBetween;
  }

  static int _mGetDiffBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  static String getBangNumFormat(int num) {
    String numStr = '';
    if (num == 2 || num == 3) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[1];
    } else if (num == 4) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[2];
    } else if (num == 6) {
      numStr = MaaData.bangNum[num] + MaaData.bangDateSuffix[3];
    } else if (num <= 10) {
      numStr = mGenerateBangNum(num) + MaaData.bangDateSuffix[0];
    } else if (num <= 45) {
      numStr = mGenerateBangNum(num) + MaaData.bangDateSuffix[4];
    }

    return numStr;
  }

  static num getTimestarNum(int days) {
    if (days <= 26) {
      return (days / 13).ceil().toInt();
    } else {
      return 3;
    }
  }

  static String mGenerateBangNum(int num) {
    String inputStr = num.toString();
    String outputStr = '';

    for (var i = 0; i < inputStr.length; i++) {
      outputStr = outputStr + MaaData.bangNum[int.parse(inputStr[i])];
    }
    return outputStr;
  }

  static List<Ojon> mGetOjonData() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjons();
    List<String> dummyWeeks = mGetDummyWeeks();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<Ojon> mGetOjonDataForGraph() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjonsForGraph();
    List<String> dummyWeeks = mGetDummyWeeksForGraph();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon;
      if (i == 20) {
        ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      }
      ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<Ojon> mGetOjonDataForGraph1() {
    List<Ojon> ojonData = [];
    List<String> dummyOjons = mGetDummyOjonsForGraph1();
    List<String> dummyWeeks = mGetDummyWeeksForGraph();
    for (var i = 0; i < dummyWeeks.length; i++) {
      Ojon ojon;
      if (i == 20) {
        ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      }
      ojon = Ojon(week: dummyWeeks[i], weight: dummyOjons[i]);
      ojonData.add(ojon);
    }
    return ojonData;
  }

  static List<String> mGetDummyOjons() {
    final List<String> dummyOjons = [];
    const int l = 40;
    const String element1 = "0.0";
    const String elememnt2 = "---";

    for (var i = 0; i < l; i++) {
      /* if (i == 0) {
        dummyOjons.add(element1);
      } */
      dummyOjons.add(element1);
    }
    return dummyOjons;
  }

  static List<String> mGetDummyWeeks() {
    final List<String> dummyWeeks = [];
    const int l = 41;
    // const String elememnt3 = "প্রাথমিক ওজন";
    for (var i = 0; i < l; i++) {
      /*  if (i == 0) {
        dummyWeeks.add(elememnt3);
        continue;
      } */
      dummyWeeks.add(i.toString());
    }
    return dummyWeeks;
  }

  static List<String> mGetDummyOjonsForGraph() {
    final List<String> dummyOjons = [];
    const int l = 41;

    for (var i = 0; i < l; i++) {
      if (i % 2 == 1) {
        dummyOjons.add((i + 6).toString());
      } else if (i == 0) {
        dummyOjons.add(i.toString());
      }
      dummyOjons.add((i + 4).toString());
    }
    return dummyOjons;
  }

  static List<String> mGetDummyOjonsForGraph1() {
    final List<String> dummyOjons = [];
    const int l = 41;

    for (var i = 0; i < l; i++) {
      if (i % 5 == 0) {
        dummyOjons.add((i + 2).toString());
      }
      dummyOjons.add(i.toString());
    }
    return dummyOjons;
  }

  static List<String> mGetDummyWeeksForGraph() {
    final List<String> dummyWeeks = [];
    const int l = 41;
    for (var i = 0; i < l; i++) {
      dummyWeeks.add(i.toString());
    }
    return dummyWeeks;
  } */

  static double mConvertKgToPound(String value) {
    return (double.parse(value) * MaaData.kgToPound);
  }

  static double mConvertPoundToKg(String value) {
    return (double.parse(value) / MaaData.kgToPound);
  }

  static int mConvertCmToFeet(String value) {
    final double v = double.parse(value);
    final double totalInch = v / MaaData.incToCm;
    final int feet = (totalInch / MaaData.feetToInch).floor();
    final int inch = (totalInch % MaaData.feetToInch).floor();

    return feet;
  }

  static int mConvertCmToInch(String value) {
    final double v = double.parse(value);
    final double totalInch = v / MaaData.incToCm;
    // final int feet = (totalInch / MaaData.feetToInch).floor();
    final int inch = (totalInch % MaaData.feetToInch).toInt();

    return inch;
  }

  static double mConvertFeetToCm(String f, String i) {
    final double feet = double.parse(f);
    final double inch = double.parse(i);

    final double totalInch = inch + feet * MaaData.feetToInch;
    final double totalCm = totalInch * MaaData.incToCm;

    return totalCm;
  }

  static bool mCheckPrimaryWeight(
      {required SharedPreferences sharedPreferences}) {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final double? primaryWeight;
    primaryWeight = sharedPreferences.getDouble(MyKeywords.primaryWeight);

    if (primaryWeight == null) {
      return false;
    } else {
      return true;
    }
  }

  static Map<String, dynamic> getWeekValue(
      int startPosition, List<double> list, double lastValue) {
    int step = 0;
    for (int i = startPosition; i < list.length; i++) {
      ++step;
      if (list[i] != 0.00) {
        double value = list[i] - lastValue;
        double stepInc = ((value / 2.2) / step);
        /*   print(
            'Start pos: $startPosition & Value is: ${value / 2.2} & step size: $step & Inc value: $stepInc'); */

        return {"inc": stepInc, "step": step, "lastValue": list[i]};
      }
    }

    return {"inc": 0, "step": 0};
  }
}
