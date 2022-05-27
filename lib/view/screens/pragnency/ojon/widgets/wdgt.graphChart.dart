import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'wdgt.landscapeGraph.dart';

class OjonGraphChart extends StatefulWidget {
  OjonGraphChart({Key? key}) : super(key: key);

  @override
  State<OjonGraphChart> createState() => OjonGraphChartState();
}

class OjonGraphChartState extends State<OjonGraphChart> {
  final List<Ojon> ojonData = MyServices.mGetOjonDataForGraph();
  final List<Ojon> ojonData1 = MyServices.mGetOjonDataForGraph1();
  final List<Ojon> ojonData2 = [];
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (() {
          print("Clicked");
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => GraphLandScape())));
        }),
        child: Stack(
          children: [
            SfCartesianChart(
              
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: TextStyle(fontSize: 12)
              ),
              series: <ChartSeries>[
                //Render Line Chart
                LineSeries<Ojon, num>(
                  name: 'নুন্যতম ওজন',
                    dataSource: ojonData,
                    xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
                    yValueMapper: (Ojon ojon, _) => int.parse(ojon.weight)),
                LineSeries<Ojon, num>(
                  name: 'বর্তমান ওজন',
                    dataSource: ojonData1,
                    xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
                    yValueMapper: (Ojon ojon, _) => int.parse(ojon.weight)),
                LineSeries<Ojon, num>(
                  name: 'সর্বোচ্চ ওজন',
                    dataSource: ojonData2,
                    xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
                    yValueMapper: (Ojon ojon, _) => int.parse(ojon.weight)),
              ],
            ),
            Container(color: Colors.transparent)
          ],
        ));
  }
}
