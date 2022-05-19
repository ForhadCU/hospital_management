import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_hospital_app/model/consts/keywords.dart';

class ServicesFirestore {
 
  static final CollectionReference collRefUser = FirebaseFirestore.instance
      .collection(ConstKeys.userCollRef);

}

