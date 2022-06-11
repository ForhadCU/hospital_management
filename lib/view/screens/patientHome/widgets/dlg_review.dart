import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/AllText.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class AddReviewDialog extends StatefulWidget {
  final Function callback;
  const AddReviewDialog({super.key, required this.callback});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double rating = 4.0;
  int selectedRating = 0;
  String review = "";
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MyScreenSize.mGetHeight(context, 43),
        width: MyScreenSize.mGetWidth(context, 90),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Add_A_REVIEW,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              YOUR_RATING,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = 1;
                    });
                  },
                  child: Image.asset(
                    selectedRating > 0
                        ? "lib/assets/star_active.png"
                        : "lib/assets/star_active.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = 2;
                    });
                  },
                  child: Image.asset(
                    selectedRating > 1
                        ? "lib/assets/star_active.png"
                        : "lib/assets/star_unactive.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = 3;
                    });
                  },
                  child: Image.asset(
                    selectedRating > 2
                        ? "lib/assets/star_active.png"
                        : "lib/assets/star_unactive.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = 4;
                    });
                  },
                  child: Image.asset(
                    selectedRating > 3
                        ? "lib/assets/star_active.png"
                        : "lib/assets/star_unactive.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedRating = 5;
                    });
                  },
                  child: Image.asset(
                    selectedRating > 4
                        ? "lib/assets/star_active.png"
                        : "lib/assets/star_unactive.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              YOUR_REVIEW,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            TextField(
              style: TextStyle(color: Colors.grey, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Your review here...",
                contentPadding: EdgeInsets.zero,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade500, width: 0.5)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade500, width: 0.5)),
              ),
              onChanged: (val) {
                setState(() {
                  review = val;
                });
              },
            ),
            SizedBox(
              height: 24,
            ),
            bottomButtons1(),
          ],
        ),
      ),
    );
  }

  bottomButtons1() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // addReview();
                // print('Selected review: $selectedRating Review text: $review');
                widget.callback(selectedRating, review);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 5, 25, 0),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: MyColors.c3,
                ),
                child: Center(
                  child: Text(
                    SUBMIT,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
