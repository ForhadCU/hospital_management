import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/model/data_model/model.ojon.dart';
import 'package:my_hospital_app/model/model.history.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryGraphChart extends StatefulWidget {
  final List<HistoryModel> historyModelList;
  final List<HistoryModel> historyModelList2;

  const HistoryGraphChart({Key? key, required this.historyModelList, required this.historyModelList2})
      : super(key: key);

  @override
  State<HistoryGraphChart> createState() => HistoryGraphChartState();
}

class HistoryGraphChartState extends State<HistoryGraphChart> {
  final List<Ojon> ojonData = MyServices.mGetOjonDataForGraph();
  final List<Ojon> ojonData1 = MyServices.mGetOjonDataForGraph1();
  final List<Ojon> ojonData2 = [];
  late Ojon ojon;
  late List<HistoryModel> historyModelList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomStatusBar.mGetPrimaryStatusBar();
    historyModelList = widget.historyModelList;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (() {
          print("Clicked");
          /*  Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => GraphLandScape(
                      primaryWeight: widget.primaryWeight,
                      maxOjonList: widget.maxOjonList,
                      minOjonList: widget.minOjonList,
                      currentOjonList: widget.currentOjonList)))); */
        }),
        child: Stack(
          children: [
            SfCartesianChart(
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: const TextStyle(fontSize: 12)),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 30,
                interval: 5,
                // desiredIntervals: 4,
              ),
              primaryXAxis: 
              CategoryAxis(),
              // ignore: prefer_const_literals_to_create_immutables
                 series: <ChartSeries<HistoryModel, String>>[
                            // Renders column chart
                            ColumnSeries<HistoryModel, String>(
                              name: 'This Month',
                                dataSource: widget.historyModelList,
                                xValueMapper: (HistoryModel data, _) => data.xValue,
                                yValueMapper: (HistoryModel data, _) => double.parse(data.yValue),
                            ),
                             ColumnSeries<HistoryModel, String>(
                              name: 'Last Month',
                                dataSource: widget.historyModelList2,
                                xValueMapper: (HistoryModel data, _) => data.xValue,
                                yValueMapper: (HistoryModel data, _) => double.parse(data.yValue),
                            ),
                        ]
             /*  series: <ChartSeries>[
                //Render Line Chart

                     
                
                LineSeries<HistoryModel, String>(
                    name: 'This Month',
                    dataSource: widget.historyModelList,
                    xValueMapper: (HistoryModel historyModel, _) =>
                        historyModel.xValue,
                    yValueMapper: (HistoryModel historyModel, _) =>
                        double.parse(historyModel.yValue)),
                /*    LineSeries<Ojon, num>(
                    name: 'বর্তমান ওজন',
                    dataSource: widget.currentOjonList,
                    xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
                    yValueMapper: (Ojon ojon, _) => double.parse(ojon.weight)),
                LineSeries<Ojon, num>(
                    name: 'সর্বোচ্চ ওজন',
                    dataSource: widget.maxOjonList,
                    xValueMapper: (Ojon ojon, _) => int.parse(ojon.week),
                    yValueMapper: (Ojon ojon, _) => double.parse(ojon.weight)), */
              ], */
            ),
            Container(color: Colors.transparent)
          ],
        ));
  }
}
