import 'package:flutter/material.dart';

class ConstKeys {
  static const IconData iconPhone =
      IconData(0xe4a2, fontFamily: 'MaterialIcons');
  static const String userCollRef = "USERS";
  static const String adminCollRef = "ADMINS";
  static const String adminDocId = "gEmAMDRZYXtkJOklftDk";
  static const String patientDocId = "a7psj74icnNIJsCZGShG";
  // static const String doctorCollRef = "DOCTORS";
  static const String doctorCollRef = "DOCTOR";
  static const String patientCollRef = "PATIENTS";
  static const String nurseCollRef = "NURSES";
  static const String doctor = "Doctor";
  static const String patient = "Patient";
  static const String admin = "Admin";
  static const String nurse = "Nurse";
  static const String schedules = "Schedules";
  static const String notifications = "Notifications";
  static const String appointments = "Appointments";
  static const String readStatus = "readStatus";

  ///////***********************////////////

  static const String collRefTimeRecord = "TimeRecord";
  static const String timeno = "timeno";
  static const String elapsedtime = "elapsedtime";
  static const String empno = "empno";
  static const String isaccepted = "isaccepted";
  static const String starttime = "starttime";
  static const String endtime = "endtime";
  static const String comment = "comment";
  static const String userfullname = "userfullname";

  static const String avatarurl = "avatarurl";
  static const String subtitle = "subtitle";
  static const String desc = "desc";
  static const String noticeid = "noticeid";
  static const String noticeimgurl = "noticeimgurl";
  static const String title = "title";
  static const String userid = "userid";
  static const String uploaddate = "uploaddate";
  static const String status = "status";

  static const String uKeyEmail = "email";
  static const String uKeyName = "name";
  static const String uKeyCreatedDate = "createddate";
  static const String uKeyPass = "password";
  static const String uKeyPhone = "phone";
  static const String uKeyUid = "userid";
  static const String uCategory = "category";

  static const String teamCollRef = "TEAMS";

  static const String joinTeamId = "jt";
  static const String createTeamId = "ct";
}

class ConstPrintColor {
  static const String printBlack = "\x1B[30m";
  static const String printRed = "\x1B[31m";
  static const String printGreen = "\x1B[32m";
  static const String printYellow = "\x1B[33m";
  static const String printBlue = "\x1B[34m";
  static const String printMagenta = "\x1B[35m";
  static const String printCyan = "\x1B[36m";
  static const String printWhite = "\x1B[37m";
  static const String endColor = "\x1B[0m";
}

class ConstErrorMessage {
  static const String usernameField = "*Required username";
  static const String emailField = "*Required email address";
  static const String phoneField = "*Required valid mobile number";
  static const String phoneFieldNumExceeded = "Less than 10 digits";
  static const String phoneFieldWrongDigit = "First digit must be 1";
  static const String passField = "*Requied at least 6 characters";
  static const String confirmPassField = "Password doesn't match";
}

class MyKeywords {
  static const String startdate = 'startdate';
  static const String enddate = 'enddate';
  static const String loggedin = 'loggedin';
  static const String totaldays = 'totaldays';
}
