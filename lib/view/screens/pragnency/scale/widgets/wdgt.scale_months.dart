import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/view/screens/pragnency/shagotom/widgets/wdgt.timestar_block.dart';

class ScaleMonthsView extends StatelessWidget {
  const ScaleMonthsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ListView.builder(
            itemCount: 11,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TimestarBlock(
                width: index == 10
                    ? MyScreenSize.mGetWidth(context, 3.376)
                    : MyScreenSize.mGetWidth(context, 9),
                color: MyColors.colorAccent,
                text: index == 10 ? '' : (index + 1).toString(),
                fontColor: MyColors.textOnPrimary,
                textRotate: false,
                contentAlignment: Alignment.center,
              );
            }),
      ],
                                  );
  }
}