import 'package:flutter/material.dart';

class PlaceHolderScreen extends StatelessWidget {
  final String? iconPath;
  final String? message;
  final String? description;

  PlaceHolderScreen({this.iconPath, this.message, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              // iconPath,
              'lib/assets/doc1.png',
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "message",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "description",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black26,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
