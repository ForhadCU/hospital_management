class ScheduleModel {
  String? schedule_id;
  String? from;
  String? to;
  bool? status;

  ScheduleModel({this.schedule_id, this.from, this.to, this.status});


  ScheduleModel.fromMap(Map<String, dynamic> map){
    schedule_id = map['schedule_id'];
    from = map['from'];
    to = map['to'];
    status = map['status'];
  }
}
