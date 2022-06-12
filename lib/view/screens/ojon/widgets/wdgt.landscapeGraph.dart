import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphLandScape extends StatefulWidget {
  final double primaryWeight;
  final List<Ojon> maxOjonList;
  final List<Ojon> minOjonList;
  final List<Ojon> currentOjonList;
  const GraphLandScape(
      {Key? key,
      required this.primaryWeight,
      required this.maxOjonList,
      required this.minOjonList,
      required this.currentOjonList})
      : super(key: key);

  @override
  State<GraphLandScape> createState() => _GraphLandScapeState();
}

class _GraphLandScapeState extends State<GraphLandScape> {
    late Ojon ojon;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    ojon = widget.maxOjonList[40];

    
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
        legend: Legend(
          position: LegendPosition.bottom,
          isVisible: true,
          textStyle: const TextStyle(fontSize: 12)
        ),
        zoomPanBehavior:
            ZoomPanBehavior(enablePinching: true, enablePanning: true),
        primaryYAxis: NumericAxis(
          minimum: widget.primaryWeight,
                          maximum: double.parse(ojon.weight) + 44,

          interval: 4,
        ),
         primaryXAxis: NumericAxis(
                minimum: 0,
                maximum: 40,
                interval: 5
              ),
        series: <ChartSeries>[
          //Render Line Chart
          LineSeries<Ojon, num>(
              name: 'নুন্যতম ওজন',
              dataSource: widget.minOjonList,
              xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
              yValueMapper: (Ojon ojon, _) => double.parse(ojon.weight)),
          LineSeries<Ojon, num>(
              name: 'বর্তমান ওজন',
              dataSource: widget.currentOjonList,
              xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
              yValueMapper: (Ojon ojon, _) => double.parse(ojon.weight)),
          LineSeries<Ojon, num>(
              name: "সর্বোচ্চ ওজন",
              dataSource: widget.maxOjonList,
              xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
              yValueMapper: (Ojon ojon, _) => double.parse(ojon.weight))
        ],
      ),
    );
  }
}
