// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/model.kahbar.dart';

import 'widget/item.dart';


class KhabarScreen extends StatelessWidget {
  const KhabarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<KhabarModel> khabarModelList = MyServices.mGetKhabarModelList();
    int i = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          MaaData.responsibility,
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
            
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      khabarModelList.isEmpty ? 0 : khabarModelList.length,
                  itemBuilder: (context, index) {
                    KhabarModel model = khabarModelList[index];
                    if (model.imgAssetUri != '') {
                      i++;
                    }
                    return ListItemKhabar(
                      index: index,
                      title: model.title!,
                      desc: model.desc!,
                      imgUrl: model.imgAssetUri,
                      isLeft: i % 2 == 0 ? false : true,
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
