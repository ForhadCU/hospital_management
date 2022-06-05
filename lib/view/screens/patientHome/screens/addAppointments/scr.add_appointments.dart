import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/firebaseController/services.firestore.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/data_model/model.doctors.dart';
import 'package:my_hospital_app/view/screens/patientHome/screens/addAppointments/widget/category.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/dlg_book_appointment.dart';
import 'package:my_hospital_app/view/screens/patientHome/widgets/doctor_banner.dart';

class AddAppointments extends StatefulWidget {
  const AddAppointments({super.key});

  @override
  State<AddAppointments> createState() => _AddAppointmentsState();
}

class _AddAppointmentsState extends State<AddAppointments> {
  late List<Doctor> doctorsModelList;
  late List<Doctor> specialDoctorsModelList;
  late String catName;
  String topDoctors = "Top Doctors";

  @override
  void initState() {
    super.initState();
    CustomStatusBar.mGetPrimaryStatusBar();
    doctorsModelList = [];
    catName = "Catergory name";
    // ServicesFirestore.mGetSpecialDoctors("catName");
    ServicesFirestore.mReadAllDoctors().then((value) {
      setState(() {
        doctorsModelList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const CustomText(
          text: "Add Appointment",
          fontWeight: FontWeight.w500,
          fontcolor: Colors.white,
        ),
        backgroundColor: MyColors.c3,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Category part
            Container(
              padding: const EdgeInsets.all(8),
              child: const CustomText(
                text: "Category",
                fontWeight: FontWeight.bold,
                fontsize: 24,
                fontcolor: Colors.grey,
              ),
            ),
            /* const SizedBox(
              height: 3,
            ), */
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 12,
            ),
            //Category list
            Container(
              height: MyScreenSize.mGetHeight(context, 10),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // itemCount: doctorsModelList.length,
                itemCount: MyData.categoryList.length,
                itemBuilder: (context, index) {
                  return CategoryView(
                      callback: (String catName) {
                        ServicesFirestore.mReadSpecialDoctors(catName)
                            .then((value) {
                          setState(() {
                            topDoctors = catName;
                            doctorsModelList = value;
                          });
                        });
                      },
                      catName: MyData.categoryList[index]);
                },
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            //Doctors part
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: CustomText(
                          text: "$topDoctors (${doctorsModelList.length})",
                          fontWeight: FontWeight.bold,
                          fontsize: 24,
                          fontcolor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black26,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: doctorsModelList.isEmpty
                        ? const Center(
                            child: CustomText(
                              text: "Sorry! not avialables.",
                              fontWeight: FontWeight.w500,
                              fontcolor: Colors.grey,
                              fontsize: 18,
                            ),
                          )
                        : ListView.builder(
                            itemCount: doctorsModelList.isEmpty
                                ? 0
                                : doctorsModelList.length,
                            itemBuilder: (context, index) {
                              Doctor doctor = doctorsModelList[index];

                              return DoctorBanner(
                                  callback: () {
                                    /* print(
                                        doctor.scheduleModelList![1].from); */
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return BookAppointmentDialog(
                                            doct_uid: doctor.userid!,
                                            scheduleModelList:
                                                doctor.scheduleModelList!,
                                            personName: doctor.name!,
                                            gmail: doctor.email!,
                                            rating: doctor.rating!,
                                            consultationFee:
                                                "${index * 10 + 60}\$",
                                            category: doctor.category!,
                                          );
                                        });
                                  },
                                  name: doctor.name!,
                                  category: doctor.category!,
                                  rating: doctor.rating!,
                                  schFrom: doctor.schedule_start!,
                                  schTo: doctor.schedule_end!);
                            }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
