import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';
import 'package:my_hospital_app/model/data_model/model.doctors.dart';
import 'package:my_hospital_app/model/data_model/model.notification.dart';
import 'package:my_hospital_app/model/data_model/model.schedule.dart';

class ServicesFirestore {
  static final CollectionReference collRefUser =
      FirebaseFirestore.instance.collection(ConstKeys.userCollRef);
  static final CollectionReference collRefAdmin =
      FirebaseFirestore.instance.collection(ConstKeys.adminCollRef);
  static final CollectionReference collRefDoctor =
      FirebaseFirestore.instance.collection(ConstKeys.doctorCollRef);
  static final CollectionReference collRefPatients =
      FirebaseFirestore.instance.collection(ConstKeys.patientCollRef);
  static final CollectionReference collRefNurse =
      FirebaseFirestore.instance.collection(ConstKeys.nurseCollRef);
  /*  static final DocumentReference adminDocRef =
      ServicesFirestore.collRefAdmin.doc(); */

  static Future<void> mAppointmentReq(
      String doctUid,
      String myUid,
      String from,
      String to,
      String visitDate,
      String scheduleId,
      String sentDate,
      String sentTime) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    NotificationModel model = NotificationModel(
        from: from,
        to: to,
        visitDate: visitDate,
        senderUid: myUid,
        doctUid: doctUid,
        sentDate: sentDate,
        sentTime: sentTime,
        scheduleId: scheduleId,
        notifId: '');

    await db
        .collection(ConstKeys.adminCollRef)
        .doc('gEmAMDRZYXtkJOklftDk')
        .collection(ConstKeys.notifications)
        .add(model.toMap())
        .then((value) => db
            .collection(ConstKeys.adminCollRef)
            .doc('gEmAMDRZYXtkJOklftDk')
            .collection(ConstKeys.notifications)
            .doc(value.id)
            .update({'notifId': value.id}));
  }

  static Future<List<ScheduleModel>> mFetchSchedules(
      String doctUid, String selectedDate) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<ScheduleModel> list = [];
    List<String> bookedScheIdList = [];

//read Notification of specific doctor
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
        .collection(ConstKeys.doctorCollRef)
        .doc(doctUid)
        .collection(ConstKeys.notifications)
        .get();

    for (var element in querySnapshot.docs) {
      print(
          "selectedDate: $selectedDate   visitedDate: ${element.get('visit_date')}");
      if (element.get('visit_date') == selectedDate) {
        bookedScheIdList.add(element.get('schedule_id'));
        db
            .collection(ConstKeys.doctorCollRef)
            .doc(doctUid)
            .collection(ConstKeys.schedules)
            .doc(element.get('schedule_id'))
            .update({"status": false});
      } else{
        db
            .collection(ConstKeys.doctorCollRef)
            .doc(doctUid)
            .collection(ConstKeys.schedules)
            .doc(element.get('schedule_id'))
            .update({"status": true});
      }
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot1 = await db
        .collection(ConstKeys.doctorCollRef)
        .doc(doctUid)
        .collection(ConstKeys.schedules)
        .get();

    list =
        querySnapshot1.docs.map((e) => ScheduleModel.fromMap(e.data())).toList();
    /*  Future.delayed(Duration(milliseconds: 2000)).then((value) => null) */
    return list;
  }

  static Future<List<Doctor>> mReadSpecialDoctors(String catName) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    List<Doctor> specialDoctorModelList = [];
    List<ScheduleModel> scheduleModelList = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshotDetails =
        await db.collection(ConstKeys.doctorCollRef).get();
    QuerySnapshot<Map<String, dynamic>> querySnapshotSchedules = await db
        .collection(ConstKeys.doctorCollRef)
        .doc("EM8maKc2FJ2WLM9HSfIW")
        .collection(ConstKeys.schedules)
        .get();

    //convert querySnapshot
    List<Doctor> doctorModelList =
        querySnapshotDetails.docs.map((e) => Doctor.fromMap(e.data())).toList();
    List<ScheduleModel> scheduleList = querySnapshotSchedules.docs
        .map((e) => ScheduleModel.fromMap(e.data()))
        .toList();

    for (var i = 0; i < doctorModelList.length; i++) {
      Doctor doctor = doctorModelList[i];
      if (doctor.category == catName) {
        //get schedule collection for this doctor doc
        QuerySnapshot<Map<String, dynamic>> querySnapshotSchedules = await db
            .collection(ConstKeys.doctorCollRef)
            .doc(doctor.userid)
            .collection(ConstKeys.schedules)
            .get();
        List<ScheduleModel> scheduleList = querySnapshotSchedules.docs
            .map((e) => ScheduleModel.fromMap(e.data()))
            .toList();

        //add all data into DoctorModel
        specialDoctorModelList.add(Doctor(
            userid: doctor.userid,
            name: doctor.name,
            category: doctor.category,
            rating: doctor.rating,
            email: doctor.email,
            schedule_start: doctor.schedule_start,
            schedule_end: doctor.schedule_end,
            scheduleModelList: scheduleList));
      }
    }
    return specialDoctorModelList;
  }

  static Future<List<Doctor>> mReadAllDoctors() async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection(ConstKeys.doctorCollRef).get();
    List<Doctor> doctorModelList = snapshot.docs
        .map((docSnapshot) => Doctor.fromMap(docSnapshot.data()))
        .toList();

    //get one by one
    /* for (var i = 0; i < doctorModelList.length; i++) {
      Doctors model = doctorModelList[i];
      print(model.name);
    } */
    return doctorModelList;
  }

  static Future<String?> mCheckUserType(String userId) async {
    //checking for Admin
/*     ServicesFirestore.collRefAdmin.get().then((querySnapshot) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        print("Admin userid: ${querySnapshot.docs[i].get('userid')}");
        if (querySnapshot.docs[i].get('userid') == userId) {
          return ConstKeys.admin;
        }
      }
    }); */

    QuerySnapshot querySnapshotAdmin =
        await ServicesFirestore.collRefAdmin.get();
    for (var i = 0; i < querySnapshotAdmin.docs.length; i++) {
      print("Admin userid: ${querySnapshotAdmin.docs[i].get('userid')}");

      if (querySnapshotAdmin.docs[i].get('userid') == userId) {
        return ConstKeys.admin;
      }
    }
    //checking for Doctor
    /*    ServicesFirestore.collRefDoctor.get().then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        print("Doctor userid: ${value.docs[i].get('userid')}");

        if (value.docs[i].get('userid') == userId) {
          return ConstKeys.doctor;
        }
      }
    }); */

    QuerySnapshot querySnapshotDoctor =
        await ServicesFirestore.collRefDoctor.get();
    for (var i = 0; i < querySnapshotDoctor.docs.length; i++) {
      print("Admin userid: ${querySnapshotDoctor.docs[i].get('userid')}");

      if (querySnapshotDoctor.docs[i].get('userid') == userId) {
        return ConstKeys.doctor;
      }
    }

    //checking for Nurse
/*     ServicesFirestore.collRefNurse.get().then((querySnapshot) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        print("Nurse userid: ${querySnapshot.docs[i].get('userid')}");

        if (querySnapshot.docs[i].get('userid') == userId) {
          return ConstKeys.nurse;
        }
      }
    }); */

    QuerySnapshot querySnapshotNurse =
        await ServicesFirestore.collRefNurse.get();
    for (var i = 0; i < querySnapshotNurse.docs.length; i++) {
      print("Admin userid: ${querySnapshotNurse.docs[i].get('userid')}");

      if (querySnapshotNurse.docs[i].get('userid') == userId) {
        return ConstKeys.nurse;
      }
    }

    //checking for Patient
    /* ServicesFirestore.collRefPatients.get().then((querySnapshot) {
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        print("Patient userid: ${querySnapshot.docs[i].get('userid')}");

        if (querySnapshot.docs[i].get('userid') == userId) {
          return ConstKeys.patient;
        }
      }
    }); */

    QuerySnapshot querySnapshotPatient =
        await ServicesFirestore.collRefPatients.get();
    for (var i = 0; i < querySnapshotPatient.docs.length; i++) {
      print("Patient userid: ${querySnapshotPatient.docs[i].get('userid')}");

      if (querySnapshotPatient.docs[i].get('userid') == userId) {
        return ConstKeys.patient;
      }
    }
  }

  static Future mSaveData(
      {required String userType,
      required String email,
      required String pass,
      required String username,
      required String phone,
      required userId}) async {
    if (userType == (ConstKeys.admin)) {
      ServicesFirestore.collRefAdmin.add({
        /* ConstKeys.uKeyEmail: email,
          ConstKeys.uKeyPass: pass,
          ConstKeys.uKeyName: username,
          ConstKeys.uKeyPhone: phone, */
        ConstKeys.uKeyEmail: MyServices.mEncode(email),
        ConstKeys.uKeyPass: MyServices.mEncode(pass),
        ConstKeys.uKeyName: MyServices.mEncode(username),
        ConstKeys.uKeyPhone: MyServices.mEncode(phone),
        ConstKeys.uCategory: userType,
        ConstKeys.uKeyUid: userId,
        ConstKeys.uKeyCreatedDate: DateTime.now().millisecondsSinceEpoch,
      });
    } else if (userType == (ConstKeys.doctor)) {
      ServicesFirestore.collRefDoctor.add({
        /* ConstKeys.uKeyEmail: email,
          ConstKeys.uKeyPass: pass,
          ConstKeys.uKeyName: username,
          ConstKeys.uKeyPhone: phone, */
        ConstKeys.uKeyEmail: MyServices.mEncode(email),
        ConstKeys.uKeyPass: MyServices.mEncode(pass),
        ConstKeys.uKeyName: MyServices.mEncode(username),
        ConstKeys.uKeyPhone: MyServices.mEncode(phone),
        ConstKeys.uCategory: userType,
        ConstKeys.uKeyUid: userId,
        ConstKeys.uKeyCreatedDate: DateTime.now().millisecondsSinceEpoch,
      });
    } else if (userType == (ConstKeys.patient)) {
      ServicesFirestore.collRefPatients.add({
        /* ConstKeys.uKeyEmail: email,
          ConstKeys.uKeyPass: pass,
          ConstKeys.uKeyName: username,
          ConstKeys.uKeyPhone: phone, */
        ConstKeys.uKeyEmail: MyServices.mEncode(email),
        ConstKeys.uKeyPass: MyServices.mEncode(pass),
        ConstKeys.uKeyName: MyServices.mEncode(username),
        ConstKeys.uKeyPhone: MyServices.mEncode(phone),
        ConstKeys.uCategory: userType,
        ConstKeys.uKeyUid: userId,
        ConstKeys.uKeyCreatedDate: DateTime.now().millisecondsSinceEpoch,
      });
    } else if (userType == (ConstKeys.nurse)) {
      ServicesFirestore.collRefNurse.add({
        /* ConstKeys.uKeyEmail: email,
          ConstKeys.uKeyPass: pass,
          ConstKeys.uKeyName: username,
          ConstKeys.uKeyPhone: phone, */
        ConstKeys.uKeyEmail: MyServices.mEncode(email),
        ConstKeys.uKeyPass: MyServices.mEncode(pass),
        ConstKeys.uKeyName: MyServices.mEncode(username),
        ConstKeys.uKeyPhone: MyServices.mEncode(phone),
        ConstKeys.uCategory: userType,
        ConstKeys.uKeyUid: userId,
        ConstKeys.uKeyCreatedDate: DateTime.now().millisecondsSinceEpoch,
      });
    }
  }
}

class ServicesFirebaseAuth {
  static void mSignOut(FirebaseAuth mAuth) {
    mAuth.signOut();
  }
}
