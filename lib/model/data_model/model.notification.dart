class NotificationModel {
  String? from;
  String? to;
  String? notifId;
  String? scheduleId;
  String? senderUid;
  String? sentDate;
  String? sentTime;
  String? visitDate;
  String? doctUid;
  int? dateTime;
  String? readStatus;
  String? patientAppnointmentId;
  String? acceptStatus;
  String? doc_id;
  bool? remainder;

  NotificationModel(
      {this.remainder,
      this.readStatus,
      this.doc_id,
      this.acceptStatus,
      this.patientAppnointmentId,
      this.doctUid,
      this.from,
      this.to,
      this.notifId,
      this.scheduleId,
      this.senderUid,
      this.sentDate,
      this.sentTime,
      this.dateTime,
      this.visitDate});

  NotificationModel.fromMap(Map<String, dynamic> map) {
    from = map['from'];
    to = map['to'];
    notifId = map['notifId'];
    scheduleId = map['scheduleId'];
    senderUid = map['senderUid'];
    sentDate = map['sentDate'];
    sentTime = map['sentTime'];
    visitDate = map['visitDate'];
    doctUid = map['doctUid'];
    dateTime = map['dateTime'];
    readStatus = map['readStatus'];
    patientAppnointmentId = map['patientAppnointmentId'];
    acceptStatus = map['acceptStatus'];
    doc_id = map['doc_id'];
    remainder = map['createdDateTime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    map['from'] = from;
    map['to'] = to;
    map['notifId'] = notifId;
    map['scheduleId'] = scheduleId;
    map['senderUid'] = senderUid;
    map['sentDate'] = sentDate;
    map['sentTime'] = sentTime;
    map['visitDate'] = visitDate;
    map['doctUid'] = doctUid;
    map['dateTime'] = dateTime;
    map['readStatus'] = readStatus;
    map['patientAppnointmentId'] = patientAppnointmentId;
    map['acceptStatus'] = acceptStatus;
    map['doc_id'] = doc_id;
    map['createdDateTime'] = remainder;

    return map;
  }
}
