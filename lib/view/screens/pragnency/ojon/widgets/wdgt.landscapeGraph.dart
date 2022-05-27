import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class GraphLandScape extends StatefulWidget {
  const GraphLandScape({Key? key}) : super(key: key);

  @override
  State<GraphLandScape> createState() => _GraphLandScapeState();
}

class _GraphLandScapeState extends State<GraphLandScape> {
  final List<Ojon> ojonData = MyServices.mGetOjonDataForGraph();
  final List<Ojon> ojonData1 = MyServices.mGetOjonDataForGraph1();
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true
        ),
        series: <ChartSeries>[
          //Render Line Chart
          LineSeries<Ojon, num>(
              dataSource: ojonData,
              xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
              yValueMapper: (Ojon ojon, _) => int.parse(ojon.weight)),
          LineSeries<Ojon, num>(
              dataSource: ojonData1,
              xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
              yValueMapper: (Ojon ojon, _) => int.parse(ojon.weight))
        ],
      ),
    );
  }
}
