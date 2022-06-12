class SympIntenSityModel {
  String date;
  String symptoms;

  SympIntenSityModel({required this.date, required this.symptoms});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{"date": date, "symptoms": symptoms};
  }
}
