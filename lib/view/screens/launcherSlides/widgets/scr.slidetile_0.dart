import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';




class SlideTile0 extends StatelessWidget {
  const SlideTile0({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "lib/assets/images/firstscreenlogo.png",
            height: MyScreenSize.mGetHeight(context, 36),
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 28,
          ),
           Text(MaaData.welcome,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: MyColors.textOnPrimary))
        ],
      ),
    );
  }
}
