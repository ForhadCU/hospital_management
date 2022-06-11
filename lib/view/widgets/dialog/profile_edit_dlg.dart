// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';

class ProfileEditDialog extends StatefulWidget {
  final String name;
  final String gmail;
  final String mobile;
  final String age;
  final String address;
  final Function callback;
  const ProfileEditDialog(
      {super.key,
      required this.callback,
      required this.name,
      required this.gmail,
      required this.mobile,
      required this.age,
      required this.address});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  late TextEditingController nameCtrler;
  late TextEditingController gmailCtrler;
  late TextEditingController mobileCtrler;
  late TextEditingController ageCtrler;
  late TextEditingController addressCtrler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtrler = TextEditingController(text: widget.name);
    gmailCtrler = TextEditingController(text: widget.gmail);
    mobileCtrler = TextEditingController(text: widget.mobile);
    ageCtrler = TextEditingController(text: widget.age);
    addressCtrler = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MyScreenSize.mGetWidth(context, 90),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              CustomText(
                text: 'My Profile Details',
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: nameCtrler,
                decoration: InputDecoration(
                  label: Text('Name'),
                  contentPadding: EdgeInsets.zero,
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 0.5)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 0.5)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: gmailCtrler,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  label: CustomText(
                    text: 'Gmail',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: mobileCtrler,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  label: CustomText(
                    text: 'Phone',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: ageCtrler,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  label: CustomText(
                    text: 'Age',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: addressCtrler,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  label: CustomText(
                    text: 'Address',
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.callback(nameCtrler.text, gmailCtrler.text,
                      mobileCtrler.text, ageCtrler.text, addressCtrler.text);
                  Navigator.pop(context);
                },
                child: CustomText(
                  text: "Update",
                  fontWeight: FontWeight.w400,
                  fontcolor: Colors.white,
                ),
                style: ElevatedButton.styleFrom(primary: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
