// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/model.emergency.dart';
import 'package:my_hospital_app/view/screens/emergency/widgets/item.dart';


class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<EmergencyModel> emergModelList = MyServices.mGetEmergencyModelList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          MaaData.emergency,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
        ),
        backgroundColor: MyColors.pink2,
      ),
      body: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: MaaData.emergencyTip,
              fontWeight: FontWeight.bold,
              fontsize: 15,
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 4,)
            ,
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: emergModelList.isEmpty ? 0 : emergModelList.length,
                  itemBuilder: (context, index) {
                    EmergencyModel model = emergModelList[index];
                    return ListItemEmergency(
                      title: model.title!,
                      desc: model.desc!,
                      imgUrl: model.imgAssetUri,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
