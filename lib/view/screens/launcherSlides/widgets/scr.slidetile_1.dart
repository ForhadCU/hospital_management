import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.date_format.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/model/consts/const.keywords.dart';
import 'package:shared_preferences/shared_preferences.dart';






class SlideTile1 extends StatefulWidget {
  const SlideTile1({Key? key}) : super(key: key);

  @override
  State<SlideTile1> createState() => _SlideTile1State();
}

class _SlideTile1State extends State<SlideTile1> with TickerProviderStateMixin {
  DateTime startDate = DateTime.now();
  late String startDateStr;

  @override
  void initState() {
    super.initState();
    startDateStr = '';
    loadDate();
  }

  _mSelectDate(BuildContext context) async {
    DateTime? selected = startDate;
    DateTime? _firstDate = DateTime.now().add(Duration(days: - 280));
    showDatePicker(
            context: context,
            initialDate: startDate,
            firstDate: _firstDate,
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        selected = value;
        if (selected != null && selected != startDate) {
          startDate = selected!;
          setUpdatedDate(startDate.toString());
          startDateStr = CustomDateForamt.mFormateDate(startDate);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const CustomText(
            text: MaaData.dateChange,
            fontcolor: MyColors.textOnPrimary,
            fontsize: 20,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(
            height: 14,
          ),

          //vCalander icon
          InkWell(
            onTap: () {
              _mSelectDate(context);
            },
            child: Image.asset(
              "lib/assets/images/ic_action_calendar_month_intro.png",
              fit: BoxFit.fill,
              height: MyScreenSize.mGetHeight(context, 14),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: MyColors.textOnPrimary,
          ),
          const SizedBox(
            height: 12,
          ),
          const CustomText(
            text: MaaData.slide_2_title,
            fontcolor: MyColors.textOnPrimary,
            fontsize: 28,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 18,
          ),
          CustomText(
            text: startDateStr,
            fontcolor: MyColors.textOnPrimary,
            fontWeight: FontWeight.w400,
            fontsize: 24,
          )
        ],
      ),
    );
  }

  void loadDate() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      //get stored value
      String d =
          (_pref.getString(MyKeywords.startdate) ?? DateTime.now().toString());
      startDate = DateTime.parse(d);
      //set value
      setDate(d);
      startDateStr = CustomDateForamt.mFormateDate(DateTime.parse(d));
    });
  }

  void setDate(String d) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(MyKeywords.startdate, d);
    });
  }

  void setUpdatedDate(String d) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(MyKeywords.startdate, d);
      prefs.setString(MyKeywords.enddate,
          DateTime.parse(d).add(const Duration(days: 280)).toString());
    });
  }
}
