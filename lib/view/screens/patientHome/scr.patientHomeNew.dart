// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/doctor_banner.dart';

class PatientHomeNew extends StatefulWidget {
  const PatientHomeNew({super.key});

  @override
  State<PatientHomeNew> createState() => _PatientHomeNewState();
}

class _PatientHomeNewState extends State<PatientHomeNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: DoctorBanner(
      name: "Dr. Harunur Rahaman",
      category: "Dentist",
      rating: "4",
      schFrom: "10:30 AM",
      schTo: "05:00 PM",
    )));
  }
}
