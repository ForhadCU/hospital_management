// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/data_model/model.schedule.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/sche_view.dart';
import 'package:my_hospital_app/view/widgets/dot_blink_loader.dart';

class BookAppointmentDialog extends StatefulWidget {
  final String personName;
  final String gmail;
  final String rating;
  // final List<ScheduleModel> scheduleModelList;
  final String consultationFee;
  final String category;
  final String doct_uid;
  final String uid;

  const BookAppointmentDialog(
      {super.key,
      required this.uid,
      required this.doct_uid,
      required this.category,
      required this.consultationFee,
      // required this.scheduleModelList,
      required this.personName,
      required this.gmail,
      required this.rating});

  @override
  State<BookAppointmentDialog> createState() => _BookAppointmentDialogState();
}

class _BookAppointmentDialogState extends State<BookAppointmentDialog> {
  late List<ScheduleModel> scheduleModelList;
  late bool isGotSchedule;
  DateTime startDate = DateTime.now();
  late String startDateStr = DateFormat("yMMMMd").format(startDate);
  late bool isRequestingAppointment;
  String from = '';
  String to = '';
  String scheduleId = '';
  String senderDocid = '';
  String sentDate = '';
  String sentTime = '';
  String visitDate = '';
  // String myUid = ConstKeys.patientDocId;
  String myUid = '';

  @override
  void initState() {
    super.initState();
    isGotSchedule = false;
    scheduleModelList = [];
    isRequestingAppointment = false;
    myUid = widget.uid;
    ServicesFirestore.mGetDocId(widget.uid).then((value) {
      setState(() {
        senderDocid = value;
      });
    });
    //call getSche method,
    ServicesFirestore.mFetchSchedules(widget.doct_uid, startDateStr)
        .then((value) {
      setState(() {
        scheduleModelList = value;
        isGotSchedule = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: MyScreenSize.mGetHeight(context, 66),
          color: MyColors.c3,

          // padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipOval(
                          child: Image.asset(
                        "lib/assets/doc1.png",
                        fit: BoxFit.fill,
                        width: 64.0,
                        height: 64.0,
                      )),
                      SizedBox(
                        height: 16,
                      ),
                      CustomText(
                        text: widget.personName,
                        fontWeight: FontWeight.w500,
                        fontsize: 18,
                        fontcolor: MyColors.textOnPrimary,
                      ),
                      SizedBox(height: 4),
                      CustomText(
                        text: widget.category,
                        fontsize: 14,
                        fontcolor: MyColors.textOnPrimary,
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: widget.rating,
                            fontWeight: FontWeight.w500,
                            fontcolor: Colors.white,
                          ),
                          Icon(
                            Icons.star,
                            color: MyColors.ratingColor,
                            size: 14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //Rounded part
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: MyScreenSize.mGetHeight(context, 42),
                  width: MyScreenSize.mGetWidth(context, 78),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1, -2),
                            blurRadius: 1,
                            color: Colors.black26)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(46),
                          topRight: Radius.circular(46))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //callender
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (() {
                              _mSelectDate(context);
                            }),
                            child: Container(
                              height: 30,
                              width: MyScreenSize.mGetWidth(context, 38),
                              decoration: BoxDecoration(
                                  color: MyColors.textOnPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 126, 52, 255),
                                        offset: Offset(1, 1),
                                        blurRadius: 1)
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Color.fromARGB(255, 126, 52, 255),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  CustomText(
                                    text: startDateStr,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          CustomText(
                            text: "Available Schedules",
                            fontcolor: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black12,
                      ),
                      /*  SizedBox(
                        height: 6,
                      ), */

                      //Schedule list
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MyScreenSize.mGetWidth(context, 70),
                            height: 50,
                            // color: MyColors.c5,
                            child: !isGotSchedule
                                ? DotBlickLoader()
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: scheduleModelList.isEmpty
                                        ? 0
                                        : scheduleModelList.length,
                                    // itemCount: scheduleModelList.isEmpty ? 0 : scheduleModelList.length,
                                    itemBuilder: (context, index) {
                                      ScheduleModel model =
                                          scheduleModelList[index];
                                      return ScheduleView(
                                          status:
                                              scheduleModelList[index].status!,
                                          scheFrom:
                                              scheduleModelList[index].from!,
                                          scheTo: scheduleModelList[index].to!,
                                          scheId: scheduleModelList[index]
                                              .schedule_id!,
                                          callback: () {
                                            from = model.from!;
                                            to = model.to!;
                                            scheduleId = model.schedule_id!;
                                            visitDate = startDateStr;
                                          });
                                    }),
                          ),
                        ],
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        height: 26,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: Colors.black38,
                            size: 18,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: "Chittagong Medical College Hospital",
                            fontcolor: Colors.black45,
                            fontsize: 14,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'lib/assets/ic_dollar.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.fill,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CustomText(
                            text: "500 TAKA",
                            fontcolor: Colors.black54,
                            fontsize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (() {
                              setState(() {
                                isRequestingAppointment = true;
                              });
                              if (from != '') {
                                final int dateTime =
                                    DateTime.now().millisecondsSinceEpoch;
                                ServicesFirestore.mAppointmentReq(
                                        widget.doct_uid,
                                        myUid,

                                        senderDocid,
                                        from,
                                        to,
                                        visitDate,
                                        scheduleId,
                                        MyServices.mGetCurrentDate(),
                                        MyServices.mGetCurrentTime(),
                                        dateTime)
                                    .then((value) {
                                  // Navigator.pop(context);

                                  isRequestingAppointment = false;
                                  Navigator.pop(context);
                                });
                              } else {
                                setState(() {
                                  isRequestingAppointment = false;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: CustomText(
                                    text: "Please choose schedule",
                                    fontWeight: FontWeight.bold,
                                    fontcolor: MyColors.textOnPrimary,
                                  )));
                                });
                              }
                            }),
                            child: isRequestingAppointment
                                ? Row(
                                    children: [
                                      DotBlickLoader(),
                                    ],
                                  )
                                : Container(
                                    height: 36,
                                    width: MyScreenSize.mGetWidth(context, 60),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 156, 99, 255),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          /* BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 1),
                                        blurRadius: 1) */
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        CustomText(
                                          text: "Book Appointment",
                                          fontWeight: FontWeight.bold,
                                          fontcolor: Colors.white,
                                          fontsize: 16,
                                        )
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  _mSelectDate(BuildContext context) async {
    DateTime? selectDate = startDate;
    showDatePicker(
            context: context,
            initialDate: selectDate,
            firstDate: DateTime.now(),
            // firstDate: DateTime(DateTime.now().year + 1),
            // lastDate: selectDate)
            lastDate: DateTime.now().add(const Duration(days: 10)))
        .then((value) async {
      setState(() {
        isGotSchedule = false;
      });
      selectDate = value;
      if (selectDate != null && selectDate != startDate) {
        startDate = selectDate!;
        startDateStr = DateFormat("yMMMMd").format(startDate);
        ServicesFirestore.mFetchSchedules(widget.doct_uid, startDateStr)
            .then((value) {
          setState(() {
            isGotSchedule = true;
            scheduleModelList = value;
          });
        });
      }
    });
  }
}
