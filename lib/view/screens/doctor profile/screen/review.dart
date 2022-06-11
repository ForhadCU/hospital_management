import 'package:flutter/material.dart';
import 'package:my_hospital_app/model/consts/AllText.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/data_model/model.review.dart';
import 'package:my_hospital_app/view/screens/doctor%20profile/widget/placeholder.dart';

class ReviewScreen extends StatefulWidget {
  final String doctorId;
  ReviewScreen(this.doctorId);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int rating = 4;
  int selectedRating = 0;
  String review = "";
  int userId = 1;
  bool showReviewDialog = false;
  ReviewClass? reviewClass;
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Container(),
              backgroundColor: MyColors.c3,
              flexibleSpace: header(),
            ),
            body: !isLoaded
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : reviewsList(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: MyColors.c2,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                setState(() {
                  showReviewDialog = true;
                });
              },
            ),
          ),
          showReviewDialog ? AddReviewDialog() : Container(),
        ],
      ),
    );
  }

  header() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.black,
                  ),
                  constraints: BoxConstraints(maxWidth: 30, minWidth: 10),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  REVIEW,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  reviewsList() {
    return reviewClass == null
        ? PlaceHolderScreen(
            iconPath: "assets/placeholders/review_holder.png",
            description: DOCTOR_REVIEWS_WILL_BE_DISPLAYED_HERE,
            message: NO_REVIEWS,
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: reviewClass == null
                      ? 0
                      : /*  reviewClass.data.length */ 4,
                  itemBuilder: (context, index) {
                    return reviewCard(index);
                  },
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
  }

  reviewCard(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'lib/assets/doc1.png',
                width: 60,
                height: 60,
              ) /* CachedNetworkImage(
              height: 60,
              width: 60,
              fit: BoxFit.cover,
              imageUrl: reviewClass.data[index].profilePic,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                      height: 50,
                      width: 50,
                      child: Center(child: Icon(Icons.image))),
              errorWidget: (context, url, error) => Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    Icons.account_circle,
                    color: LIGHT_GREY_TEXT,
                    size: 60,
                  ),
                ),
              ),
            ) */
              ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // reviewClass.data[index].name,
                    'name',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        double.parse(
                                    /* reviewClass.data[index].ratting */ '4.3') >
                                0.0
                            ? "lib/assets/star_active.png"
                            : "lib/assets/star_unactive.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        double.parse(
                                    /* reviewClass.data[index].ratting */ '4.3') >
                                1.0
                            ? "lib/assets/star_active.png"
                            : "lib/assets/star_unactive.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        double.parse(
                                    /* reviewClass.data[index].ratting */ '4.3') >
                                2.0
                            ? "lib/assets/star_active.png"
                            : "lib/assets/star_unactive.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        double.parse(
                                    /* reviewClass.data[index].ratting */ '4.3') >
                                3.0
                            ? "lib/assets/star_active.png"
                            : "lib/assets/star_unactive.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        double.parse(
                                    /* reviewClass.data[index].ratting */ '4.3') >
                                4.0
                            ? "lib/assets/star_active.png"
                            : "lib/assets/star_unactive.png",
                        height: 15,
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'review',
                          // reviewClass.data[index].review,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AddReviewDialog() {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                showReviewDialog = false;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black54,
            ),
          ),
          Center(
              child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: 0.5)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.shade500, width: 0.5)),
                  ),
                  onChanged: (val) {
                    setState(() {
                      review = val;
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                bottomButtons(),
              ],
            ),
          )),
        ],
      ),
    );
  }

  bottomButtons() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                // addReview();
                print('Selected review: $selectedRating Review text: $review');
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

  errorDialog(message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.error,
                  size: 80,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  processingDialog(message) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(LOADING),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.black12, fontSize: 14),
                  ),
                )
              ],
            ),
          );
        });
  }
}
