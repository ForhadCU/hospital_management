import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center      ,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset("lib/assets/top1.png", width: size.width,  height: size.height * 0.2,
                fit: BoxFit.fill,
                ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset("lib/assets/top2.png", width: size.width,  height: size.height * 0.25,
                fit: BoxFit.fill,),
            ) ,
          ),
          /* Positioned(
            top: 45,
            right: 25,
            child: Image.asset(
              "lib/assets/images/main.png",
              width: size.width * 0.35
            ),
          ), */
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                "lib/assets/bottom1.png",
                width: size.width,
                height: size.height * 0.25,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                "lib/assets/bottom2.png",
                width: size.width,
                height: size.height * 0.15,
                fit: BoxFit.fill,
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
