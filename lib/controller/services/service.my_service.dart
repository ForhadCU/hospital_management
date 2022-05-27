import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyServices {


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
}
