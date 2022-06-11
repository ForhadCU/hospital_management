// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class DoctorBanner extends StatelessWidget {
  final String? name;
  final String? category;
  final String? rating;
  final String? schFrom;
  final String? schTo;
  final Function callback;
  const DoctorBanner(
      {super.key,
      required this.callback,
      required this.name,
      required this.category,
      required this.rating,
      required this.schFrom,
      required this.schTo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8, left: 2, right: 2),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: MyColors.c4, offset: Offset(1, 1), blurRadius: 1)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            //image
            Expanded(
                child: Row(
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image(
                    image: AssetImage(
                      "lib/assets/doc1.png",
                    ),
                    height: 64,
                    width: 64,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )),
            //Details
            Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:  name == null ? "Dr. Nullendro Shen": name!,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        CustomText(
                          text:  category == null ? "Dentist": category!,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: "Ratings: $rating",
                              fontWeight: FontWeight.w400,
                            ),
                            Icon(
                              Icons.star,
                              color: MyColors.ratingColor,
                              size: 12,
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CustomText(text: "$schFrom to $schTo"),
                          ],
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
