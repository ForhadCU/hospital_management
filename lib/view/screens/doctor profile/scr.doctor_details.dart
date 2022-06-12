// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/AllText.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/dlg_book_appointment.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/dlg_review.dart';

import 'screen/review.dart';

class DoctorDetails extends StatefulWidget {
  final String uid;
  final String doct_uid;
  final String personName;
  final String gmail;
  final String rating;
  final String consultationFee;
  final String category;
  // final List<ScheduleModel> scheduleModelList;

  DoctorDetails(
      {required this.uid,
      required this.doct_uid,
      required this.category,
      required this.consultationFee,
      required this.personName,
      // required this.scheduleModelList,
      required this.gmail,
      required this.rating});

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  bool isLoggedIn = true;
  bool isFethingDetails = false;
  double rating = 4.0;
  int selectedRating = 0;
  String review = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isFethingDetails == null
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            color: Colors.white,
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: Container(),
                backgroundColor: MyColors.c3,
                flexibleSpace: header(),
              ),
              body: body(),
            ),
          );
  }

  header() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  width: 5,
                ),
                Text(
                  // doctorDetail.data.name,
                  // 'Dr. Himel Chowdhury',
                  widget.personName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w800),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          // _makeCall(doctorDetail.data.phoneNo);
                        },
                        child: Image.asset(
                          "lib/assets/Phone.png",
                          height: 36,
                          width: 36,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          // _sendEmail(doctorDetail.data.email);
                        },
                        child: Image.asset(
                          "lib/assets/email.png",
                          height: 36,
                          width: 36,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  body() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                doctorProfileCard(),
                workingTimeAndServiceCard(),
              ],
            ),
          ),
        ),
        bottomButtons(),
      ],
    );
  }

  doctorProfileCard() {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'lib/assets/doc1.png',
                    width: 80,
                    height: 90,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // doctorDetail.data.name,
                          // 'Dr. Himel Chowdhury',
                          widget.personName,

                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          // doctorDetail.data.departmentName,
                          // 'Diagonist',
                          widget.category,

                          style: TextStyle(
                              color: Color.fromARGB(255, 7, 47, 116),
                              fontSize: 12),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReviewScreen(widget.doct_uid)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                // doctorDetail.data.ratting > 0
                                double.parse(widget.rating) >= 0
                                    ? "lib/assets/star_active.png"
                                    : "lib/assets/star_unactive.png",
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                double.parse(widget.rating) > 1
                                    ? "lib/assets/star_active.png"
                                    : "lib/assets/star_unactive.png",
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                double.parse(widget.rating) > 2
                                    ? "lib/assets/star_active.png"
                                    : "lib/assets/star_unactive.png",
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                double.parse(widget.rating) > 3
                                    ? "lib/assets/star_active.png"
                                    : "lib/assets/star_unactive.png",
                                height: 12,
                                width: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                double.parse(widget.rating) > 4
                                    ? "lib/assets/star_active.png"
                                    : "lib/assets/star_unactive.png",
                                height: 12,
                                width: 12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            "See all reviews",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _launchURL(doctorDetail.data.facebookId);
                          },
                          child: Image.asset(
                            "lib/assets/facebook.png",
                            height: 15,
                            width: 15,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            // _launchURL(doctorDetail.data.twitterId);
                          },
                          child: Image.asset(
                            "lib/assets/twitter.png",
                            height: 15,
                            width: 15,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            // _launchURL(doctorDetail.data.googleId);
                          },
                          child: Image.asset(
                            "lib/assets/google+.png",
                            height: 15,
                            width: 15,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            // _launchURL(doctorDetail.data.instagramId);
                          },
                          child: Image.asset(
                            "lib/assets/instagram.png",
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            // doctorDetail.data.aboutUs,
            '''A diagnostic test is any kind of medical test performed to aid in the diagnosis or detection of disease. Diagnostic tests can also be used to provide prognostic information onpeople with established disease. Processing of the answers, findings or other results.''',
            style: TextStyle(color: Colors.black45, fontSize: 11),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  workingTimeAndServiceCard() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // WORKING_TIME,
            "Working Time",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 3,
                mainAxisSpacing: 5),
            // itemCount: doctorDetail.data.timeTabledata.length,
            itemCount: MaaData.weekList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Image.asset("lib/assets/free-time.png"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        /*  weekDaysList[
                            doctorDetail.data.timeTabledata[index].day - 1] */
                        MaaData.weekList[index],
                        style: TextStyle(
                            color: Color.fromARGB(255, 10, 67, 114),
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        /* doctorDetail.data.timeTabledata[index].from +
                            " to " +
                            doctorDetail.data.timeTabledata[index].to, */
                        '09:00 AM to 08:30 PM',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            SERVICES,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 19),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            // doctorDetail.data.service,
            "A diagnostic procedure may be performed by various healthcare professionals such as a physician, physiotherapist, dentist, podiatrist, optometrist, nurse practitioner, healthcare scientist or physician assistant. This article uses diagnostician as any of these person categories.",

            style: TextStyle(fontSize: 13, color: Colors.black45),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  bottomButtons() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReviewScreen(widget.doct_uid))) */
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddReviewDialog(
                        callback: (int rating, String review) {
                      // print('$rating $review');
                    });
                  });
            },
            child: Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.fromLTRB(0, 5, 6, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: MyColors.c3,
              ),
              child: Image.asset("lib/assets/review.png"),
            ),
          ),
          //Button Book Appointment
          Expanded(
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return BookAppointmentDialog(
                        uid: widget.uid,
                        doct_uid: widget.doct_uid,
                        // scheduleModelList: widget.scheduleModelList,
                        personName: widget.personName,
                        gmail: widget.gmail,
                        rating: widget.rating,
                        consultationFee: "${135.00}\$",
                        category: widget.category,
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(6, 5, 12, 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: MyColors.c3,
                ),
                child: Center(
                  child: Text(
                    isLoggedIn ? BOOK_APPOINTMENT : LOGIN_TO_BOOK_APPOINTMENT,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

/*   bottomButtons1() {
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
  } */

/*   AddReviewDialog() {
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
                borderSide:
                    BorderSide(color: Colors.grey, width: 0.5)),
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
          height: 24,
        ),
        bottomButtons1(),
      ],
        ),
      ),
    );
  } */
}
