// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  final String uid;
  const AdminHome({super.key, required this.uid});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      child: Text(
        'Admin Home. Uid: ${widget.uid}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    )));
  }
}
