import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class CategoryView extends StatelessWidget {
  final String catName;
  final Function callback;

  const CategoryView(
      {super.key, required this.catName, required this.callback});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            callback(catName);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: MyColors.c4, offset: Offset(1, 2), blurRadius: 1)
                ]),
            child: CustomText(
              text: catName,
              fontWeight: FontWeight.w400,
              fontcolor: MyColors.c3,
            ),
          ),
        ),
      ],
    );
  }
}
