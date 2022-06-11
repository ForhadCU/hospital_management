// ignore_for_file: non_constant_identifier_names

import 'package:my_hospital_app/model/data_model/model.schedule.dart';

class Doctor {
  String? userid;
  String? name;
  String? category;
  String? rating;
  String? email;
  String? schedule_end;
  String? schedule_start;
  List<ScheduleModel>? scheduleModelList;

  Doctor(
      {
      this.scheduleModelList,
      this.userid,
      this.name,
      this.category,
      this.rating,
      this.email,
      this.schedule_start,
      this.schedule_end
      });
/*   Doctors(
      {required this.userid,
      required this.name,
      required this.category,
      required this.rating,
      required this.email,
      required this.schedule_start,
      required this.schedule_end});
 */
  Doctor.fromMap(Map<String, dynamic> map) {
    userid = map['userid'];
    name = map['Name'];
    category = map['Qualification'];
    rating = map['Rating'];
    email = map['Email'];
    schedule_start = map['schedule_start'];
    schedule_end = map['schedule_end'];
  }
  /* Doctor.fromMap(Map<String, dynamic> map) {
    userid = map['userid'];
    name = map['name'];
    category = map['category'];
    rating = map['rating'];
    email = map['email'];
    schedule_start = map['schedule_start'];
    schedule_end = map['schedule_end'];
  } */
}
