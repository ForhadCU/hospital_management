

import 'package:my_hospital_app/model/data_model/model.ojon.dart';

class MaxMinWeightListModel {
  List<Ojon> minWeightList;
  List<Ojon> maxWeightList;
  List<Ojon> currentWeightList;

  MaxMinWeightListModel(
      {required this.minWeightList, required this.maxWeightList, required this.currentWeightList});
}
