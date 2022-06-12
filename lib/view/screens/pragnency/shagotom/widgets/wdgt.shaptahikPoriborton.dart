// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_text.dart';
import 'package:my_hospital_app/controller/utils/util.my_scr_size.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:my_hospital_app/view/screens/pragnency/shagotom/widgets/wdgt.lebeltext.dart';

class ShaptahikPoriborton extends StatefulWidget {
  final int runningDays;
  final int runningWeeks;
  final int totalRunningDays;
  const ShaptahikPoriborton(
      {Key? key,
      required this.runningDays,
      required this.runningWeeks,
      required this.totalRunningDays})
      : super(key: key);

  @override
  State<ShaptahikPoriborton> createState() => _ShaptahikPoribortonState();
}

class _ShaptahikPoribortonState extends State<ShaptahikPoriborton> {
  late String shortDesc;
  String initImgUrl = 'lib/assets/images/summary.png';
  late String postImgUrl;
  late bool isConnected;
  // late AudioCache player;
  late bool isPlaying;
  // AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    mCheckNetworkConnection();

    postImgUrl = '';
    isConnected = false;
    isPlaying = false;
    //load audio
/*     player = AudioCache();
    player.load('lib/assets/images/tone_1.mp3'); */
  }

  @override
  Widget build(BuildContext context) {
    // shortDesc = getShortDesc();

    getShortDesc();

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(1, 1),
          blurRadius: 1,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      //title
                      CustomText(
                        text: MaaData.weekly_change,
                        fontcolor: MyColors.c2,
                        fontWeight: FontWeight.w600,
                        fontsize: 20,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      //subTitle
                      CustomText(
                        text:
                            '${widget.runningWeeks.toString()} ${MaaData.week} ${widget.runningDays.toString()} ${MaaData.day}',
                        fontsize: 15,
                        fontWeight: FontWeight.bold,
                        fontcolor: Colors.black54,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: IconButton(
                    onPressed: (() async {
                      // final player = AudioCache();
                      if (!isPlaying) {
                        // player.play('lib/assets/images/tone_1.mp3');
                        /*         await audioPlayer.play('lib/assets/images/tone_1.mp3',
                            isLocal: true); */

                        isPlaying = true;
                      } else {
                        // player.clear(Uri.parse('lib/assets/images/tone_1.mp3'));
                        isPlaying = false;
                      }
                    }),
                    icon: Icon(Icons.mic),
                    iconSize: 28,
                    color: Colors.red,
                    splashRadius: 4,
                  ))
            ],
          ),

          const SizedBox(
            height: 8,
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black12,
          ),
          const SizedBox(
            height: 8,
          ),

          //image
          Container(
            color: MyColors.c4,
            height: MyScreenSize.mGetHeight(context, 36),
            child: Stack(children: [
              Positioned(
                left: 2,
                right: 2,
                bottom: 0,
                top: 0,
                child: postImgUrl == '' || !isConnected
                    ? Image(image: AssetImage('lib/assets/images/summary.png'))
                    : Image(image: NetworkImage(postImgUrl)),

                /* Image(
                      // image: AssetImage(initImgUrl)
                      image:NetworkImage(postImgUrl)) */
              ),
              //lebel
              Positioned(
                bottom: 0,
                child: LebelText(),
              )
            ]),
          ),

          const SizedBox(
            height: 8,
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black12,
          ),
          const SizedBox(
            height: 8,
          ),
          //Weekly Suggestion

          Container(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: shortDesc,
              fontsize: 15,
              fontcolor: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  void getShortDesc() {
    if (widget.runningWeeks >= 2 &&
        widget.totalRunningDays > 14 &&
        widget.totalRunningDays % 7 != 0 &&
        widget.runningWeeks <= 40) {
      widget.runningWeeks == 40
          ? postImgUrl = ''
          : _mGenerateImgUrl(widget.runningWeeks + 1);

      shortDesc = MaaData.shortDescriptionData.elementAt(widget.runningWeeks);
    } else if (widget.runningWeeks <= 41 &&
        widget.runningWeeks > 0 &&
        widget.totalRunningDays % 7 == 0) {
      if (widget.runningWeeks == 3) {
        _mGenerateImgUrl(3);
      } else if (widget.runningWeeks > 3) {
        _mGenerateImgUrl(widget.runningWeeks);
      } else {
        postImgUrl = '';
      }
      shortDesc =
          MaaData.shortDescriptionData.elementAt(widget.runningWeeks - 1);
    } else if (widget.runningWeeks <= 40) {
      shortDesc = MaaData.shortDescriptionData.elementAt(widget.runningWeeks);
    } else {
      shortDesc = MaaData.shortDescriptionData
          .elementAt(MaaData.shortDescriptionData.length - 1);
    }
  }

  void mCheckNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');

        setState(() {
          isConnected = true;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        isConnected = false;
      });
    }
  }

  _mGenerateImgUrl(int i) {
    postImgUrl = 'https://agamilabs.com/maa/images/512/w$i.jpg';
  }

/*   void _mTest(int index) async {
    final String url = "https://agamilabs.com/maa/images/512/w$index.jpg";
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      setState(() {
        // postImgUrl = json.decode(res.body);
        print('Body: '+ json.decode(res.body));
      });
    } else {
      throw Exception('Failed to load photo');
    }
  } */
}
