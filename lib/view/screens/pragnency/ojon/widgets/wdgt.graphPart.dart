// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/dlg_input_ojon.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/wdgt.graphChart.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/wdgt.landscapeGraph.dart';
import 'package:my_hospital_app/view/screens/pragnency/ojon/widgets/wdgt.viewGraphBtn.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  double titleTextSize = 18;
  bool isShowGraph = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyScreenSize.mGetHeight(context, 50),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //heading
          Container(
            color: MyColors.c1,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: CustomText(
              text: 'ওজনের ছক',
              fontsize: titleTextSize,
              fontcolor: MyColors.textOnPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Graph
          Expanded(
            child: Container(
              // color: MyColors.col,
              child: !isShowGraph
                  ? InkWell(
                      onTap: () {
                        print("Clicked grpah");
                        showDialog(
                            context: context,
                            builder: (context) => InputOjonDialog());
                      },
                      child:
                          //alert text
                          Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'No chart data available.',
                            fontcolor: MyColors.abc[0],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            text: "এখানে তথ্য দেখতে আপনার ওজন প্রদান করুন",
                            fontcolor: MyColors.abc[0],
                            fontWeight: FontWeight.w400,
                          )
                        ],
                      ),
                    )
                  : OjonGraphChart(),
            ),
          ),
          //button for Extended view of Graph
          InkWell(
            onTap: () {
              print('Clicked Graph View Button');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GraphLandScape()));
            },
            child: ViewGraphButton.viewGraphButton,
          ),
        ],
      ),
    );
  }
}


/* Fluttertoast.showToast(  
        msg: 'This is toast notification',  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIos: 1,  
        backgroundColor: Colors.red,  
        textColor: Colors.yellow  
    );   */