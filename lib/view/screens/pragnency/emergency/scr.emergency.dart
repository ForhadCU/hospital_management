// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/screens/pragnency/emergency/widgets/item.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: MyColors.c2,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Title Text",
            fontWeight: FontWeight.bold,
            fontsize: 16,
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListItemEmergency(
                  title: "Title $index",
                  desc: "This is description $index",
                  imgUrl: "lib/assets/images/e1.jpg",
                );
              })
        ],
      ),
    );
  }
}
