import 'package:flutter/material.dart';
import 'package:my_hospital_app/controller/utils/util.custom_statusbar.dart';
import 'package:my_hospital_app/model/consts/const.colors.dart';
import 'package:my_hospital_app/model/consts/const.data.bn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/consts/keywords.dart';
import '../../../model/model.splash_slides.dart';
import 'widgets/scr.slidetile_0.dart';
import 'widgets/scr.slidetile_1.dart';
import 'widgets/scr.slidetile_2.dart';
import 'widgets/scr.slidetile_3.dart';
import '../shagotom/scr.shagotom.dart';

class LauncherSlidesScreen extends StatefulWidget {
  const LauncherSlidesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LauncherSlidesScreen> createState() => _LauncherSlidesScreenState();
}

class _LauncherSlidesScreenState extends State<LauncherSlidesScreen> {
  late List<SliderModel> mySLides;
  int slideIndex = 0;
  late PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    // var MyColors;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color:
            isCurrentPage ? MyColors.dotLightScreen1 : MyColors.dotDarkScreen1,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    mySLides = [];
    mySLides = getSlides();
    controller = PageController();
    CustomStatusBar.mGetPrimaryStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle()),
      body: Container(
        decoration: const BoxDecoration(
          color: MyColors.pink2,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              color: MyColors.pink2,
              // height: MediaQuery.of(context).size.height - 100,
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    slideIndex = index;
                  });
                },
                children: const <Widget>[
                  // SlideTile1(scrNo: mySLides[0].scrNo),
                  SlideTile0(),
                  SlideTile1(),
                  SlideTile2(),
                  SlideTile3(),
                ],
              ),
            ),
            bottomSheet: /* slideIndex != 3 ? */
                Container(
              color: MyColors.pink2,

              // margin: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(height: 1, thickness: 1, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      slideIndex == 0
                          ? ElevatedButton(
                              onPressed: () {
                                null;
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: MyColors.pink2,
                              ),
                              child: const Text(
                                "",
                                style: TextStyle(
                                    color: MyColors.textOnPrimary,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                controller.animateToPage(slideIndex - 1,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.linear);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: MyColors.pink2,
                              ),
                              child: Text(
                                MaaData.previous,
                                style: TextStyle(
                                    color: MyColors.textOnPrimary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                      Row(
                        children: [
                          for (int i = 0; i < 4; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),

                      //vShongrokkhon Button
                      ElevatedButton(
                        onPressed: () {
                          slideIndex == 3
                              ? {
                                  _mRouteToMain(),
                                }
                              : controller.animateToPage(slideIndex + 1,
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.linear);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0, primary: MyColors.pink2),
                        child: Text(
                          slideIndex == 3 ? MaaData.save : MaaData.next,
                          style: const TextStyle(
                              color: MyColors.textOnPrimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _mRouteToMain() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(MyKeywords.loggedin, 'y');
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: const ShagotomScreen(),
            type: PageTransitionType.rightToLeft));
  }
}
