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

  NotificationModel(
      {this.readStatus,
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

    return map;
  }
}
