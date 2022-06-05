import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';

class ScheduleView extends StatefulWidget {
  final String scheFrom;
  final String scheTo;
  final Function callback;
  final String scheId;
  final bool status;

  const ScheduleView(
      {super.key,
      required this.status,
      required this.scheId,
      required this.scheFrom,
      required this.scheTo,
      required this.callback});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late bool isSelected = false;
  Color textColor = Colors.black87;
  FontWeight fontWeight = FontWeight.w400;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (widget.status) {
              setState(() {
                !isSelected
                    ? {
                        widget.callback(),
                        isSelected = true,
                        textColor = Colors.white,
                        fontWeight = FontWeight.bold
                      }
                    : {
                        isSelected = false,
                        textColor = Colors.black87,
                        fontWeight = FontWeight.w400
                      };
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: CustomText(
                text: 'Sorry! already Booked.',
                fontWeight: FontWeight.bold,
                fontcolor: MyColors.textOnPrimary,
              )));
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: !isSelected ? Colors.white : MyColors.c3,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  widget.status
                      ? const BoxShadow(
                          color: MyColors.c3,
                          offset: Offset(1, 1),
                          blurRadius: 1)
                      : const BoxShadow(color: Colors.white)
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                      color: widget.status ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  width: 2,
                ),
                CustomText(
                  text: "${widget.scheFrom} - ${widget.scheTo}",
                  fontcolor: widget.status ? textColor : Colors.grey,
                  fontWeight: fontWeight,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
