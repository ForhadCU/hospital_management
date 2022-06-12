
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_hospital_app/controller/services/service.my_service.dart';
import 'package:my_hospital_app/controller/services/sqflite_services.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/model.note.dart';
import 'package:my_hospital_app/model/model.symp.dart';
import 'package:my_hospital_app/model/model.symp_intensity.dart';


import 'widget/calender_part.dart';
import 'widget/note_card.dart';
import 'widget/note_sym_dlg.dart';
import 'widget/symptoms_card.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late String currentDate;
  late String note;
  late String symptoms;
  late List<SymptomsModel> sympDataModelList;
  late List<String> actualSympIntensity;
  late List<String> actualSympNames;
  // late String symptomsIntensityStr;
  @override
  void initState() {
    super.initState();
    currentDate = DateFormat("yMMMMd").format(DateTime.now());
    // print(currentDate);
    note = "";
    symptoms = "";
    sympDataModelList = [];
    actualSympIntensity = [];
    actualSympNames = [];
    //read notes
    SqfliteServices.mFetchCurrentNote(currentDate).then((noteModelList) {
      setState(() {
        for (var i = 0; i < noteModelList.length; i++) {
          NoteModel noteModel = noteModelList[i];
          note = noteModel.note;
        }
      });
    });
    //read symptoms
    SqfliteServices.mFetchCurrentSympIntensity(currentDate)
        .then((symptomModelList) {
      setState(() {
        SympIntenSityModel model = symptomModelList[0];
        symptoms = model.symptoms;
        sympDataModelList =
            MyServices.mGetSympDataList(sympIntensityStr: symptoms);
        actualSympNames = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympNames'];
        actualSympIntensity = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympIntensity'];
      });
    });

    // currentDate = DateTime.now().toString().substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.pink2,
        title: const CustomText(
          text: "নোট",
          fontWeight: FontWeight.w500,
          fontsize: 24,
          fontcolor: MyColors.textOnPrimary,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => NoteSymptompsDialog(
                        sympDataList: sympDataModelList,
                        symptomsIntensityStr: symptoms,
                        note: note,
                        currentDate: currentDate,
                        callback: (NoteModel noteModel,
                            SympIntenSityModel sympIntenSityModel) {
                          mUpdateNoteSympScreen(sympIntenSityModel, noteModel);
                          /* 
                          //note part
                          if (noteModel.note != note) {
                            int n = await SqfliteServices.addNote(noteModel);
                            print("Num of Inserted note item: $n");
                            /*   List<NoteModel> noteModelList =
                              await SqfliteServices.mFetchNotes(); */
                            List<NoteModel> currentNote =
                                await SqfliteServices.mFetchCurrentNote(
                                    currentDate);
                            // print(noteModelList.length);
                            if (currentNote.isNotEmpty) {
                              note = currentNote[0].note;
                            } else {
                              note = "";
                            }
                          }
                          //symptom part
                          if (sympIntenSityModel.symptoms != symptoms) {
                            int n = await SqfliteServices.addSympIntensity(
                                sympIntenSityModel);

                            SqfliteServices.mFetchCurrentSympIntensity(
                                    currentDate)
                                .then((symptomModelList) {
                              SympIntenSityModel model = symptomModelList[0];
                              symptoms = model.symptoms;
                              sympDataModelList = MyServices.mGetSympDataList(
                                  sympIntensityStr: symptoms);
                              actualSympNames = MyServices.mGetSympIntensityStr(
                                  sympDataModelList)['actualSympNames'];
                              actualSympIntensity =
                                  MyServices.mGetSympIntensityStr(
                                      sympDataModelList)['actualSympIntensity'];
                            });
                            // print(sympIntenSityModel.symptoms);
                          }
                          setState(() {});
                         */
                        }));
              },
              icon: Image.asset(
                'lib/assets/images/add_note_weight_icon.png',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(6),
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Calender Part
                CalenderPart(callback: (String selectedDate) async {
                  currentDate = selectedDate;
                  // print(currentDate);
                  List<NoteModel> currentNote =
                      await SqfliteServices.mFetchCurrentNote(currentDate);
                  // print(noteModelList.length);
                  if (currentNote.isNotEmpty) {
                    note = currentNote[0].note;
                  } else {
                    note = "";
                  }
                  //symptoms part
                  List<SympIntenSityModel> symIntersityModelList =
                      await SqfliteServices.mFetchCurrentSympIntensity(
                          currentDate);
                  // print(symIntersityModelList);
                  if (symIntersityModelList.isNotEmpty) {
                    SympIntenSityModel model = symIntersityModelList[0];

                    symptoms = model.symptoms;
                    // print(symptoms);
                    sympDataModelList =
                        MyServices.mGetSympDataList(sympIntensityStr: symptoms);
                    actualSympNames = MyServices.mGetSympIntensityStr(
                        sympDataModelList)['actualSympNames'];
                    actualSympIntensity = MyServices.mGetSympIntensityStr(
                        sympDataModelList)['actualSympIntensity'];
                  } else {
                    sympDataModelList = MyServices.mGetSympDataList(
                        sympIntensityStr: MaaData.SymptomsIntensity);
                    actualSympIntensity = [];
                    actualSympNames = [];
                  }
                  //refresh state
                  setState(() {});
                  // print(selectedDate);
                }),
                const SizedBox(
                  height: 12,
                ),

                //Note and Symptoms Part
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => NoteSymptompsDialog(
                            sympDataList: sympDataModelList,
                            symptomsIntensityStr: symptoms,
                            note: note,
                            currentDate: currentDate,
                            callback: (NoteModel noteModel,
                                SympIntenSityModel sympIntenSityModel) {
                              mUpdateNoteSympScreen(
                                  sympIntenSityModel, noteModel);
                              //update all values
                              /*     Map<String, dynamic> value =
                              await MyServices.mUpdateNoteSympScreen(
                                  noteModel,
                                  note,
                                  currentDate,
                                  sympIntenSityModel,
                                  symptoms,
                                  sympDataModelList,
                                  actualSympIntensity,
                                  actualSympNames); 
                                 note = value['note'];
                         
                          //then refresh
                           setState(() {
                              symptoms = value['symptoms'];
                          sympDataModelList = value['sympDataModelList'];
                          actualSympIntensity = value['actualSympIntensity'];
                          actualSympNames = value['actualSympNames'];
                       });
                        */
                            }));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Note
                      Expanded(
                          child: NoteCard(
                        note: note,
                        currentDate: currentDate,
                      )),
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                          child: SymptomsCard(
                              currentDate: currentDate,
                              sympNameList: actualSympNames,
                              sympIntensityList: actualSympIntensity))
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  void mUpdateNoteSympScreen(
    SympIntenSityModel sympIntenSityModel,
    NoteModel noteModel,
  ) async {
    //note part
    if (noteModel.note != note) {
      int n = await SqfliteServices.addNote(noteModel);
      print("Num of Inserted note item: $n");
      /*   List<NoteModel> noteModelList =
                              await SqfliteServices.mFetchNotes(); */
      List<NoteModel> currentNote =
          await SqfliteServices.mFetchCurrentNote(currentDate);
      // print(noteModelList.length);
      if (currentNote.isNotEmpty) {
        note = currentNote[0].note;
      } else {
        note = "";
      }
    }
    //symptom part
    if (sympIntenSityModel.symptoms != symptoms) {
      int n = await SqfliteServices.addSympIntensity(sympIntenSityModel);

      SqfliteServices.mFetchCurrentSympIntensity(currentDate)
          .then((symptomModelList) {
        SympIntenSityModel model = symptomModelList[0];
        symptoms = model.symptoms;
        sympDataModelList =
            MyServices.mGetSympDataList(sympIntensityStr: symptoms);
        actualSympNames = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympNames'];
        actualSympIntensity = MyServices.mGetSympIntensityStr(
            sympDataModelList)['actualSympIntensity'];
      });
      // print(sympIntenSityModel.symptoms);
    }
    setState(() {});
  }
}
