import 'dart:ui';
import 'package:flutter/material.dart';
import 'Theme.dart';

class BackColors extends StatelessWidget {
  const BackColors({super.key});
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          Positioned(
              top: 100,
              child: Container(
                height: size.height*0.5,
                width: size.width*0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.lightOrange.withOpacity(.0),
                          AppColors.lightOrange.withOpacity(.1),
                          AppColors.lightOrange.withOpacity(.2),
                          AppColors.lightOrange.withOpacity(.3),
                          AppColors.lightOrange.withOpacity(.4),
                          AppColors.lightOrange.withOpacity(.4),
                          AppColors.lightOrange.withOpacity(.3),
                          AppColors.lightOrange.withOpacity(.2),
                          AppColors.lightOrange.withOpacity(.1),
                          AppColors.lightOrange.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned(
              top: 100,
              right: -50,
              child: Container(
                height: size.height*0.5,
                width: size.width*0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.lightOrange.withOpacity(.0),
                          AppColors.lightOrange.withOpacity(.1),
                          AppColors.lightOrange.withOpacity(.2),
                          AppColors.lightOrange.withOpacity(.3),
                          AppColors.lightOrange.withOpacity(.2),
                          AppColors.lightOrange.withOpacity(.1),
                          AppColors.lightOrange.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned(
              bottom: 100,
              right: -50,
              child: Container(
                height: size.height*0.5,
                width: size.width*0.6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.lightAccentBlue.withOpacity(.0),
                          AppColors.lightAccentBlue.withOpacity(.1),
                          AppColors.lightAccentBlue.withOpacity(.2),
                          AppColors.lightAccentBlue.withOpacity(.3),
                          AppColors.lightAccentBlue.withOpacity(.4),
                          AppColors.lightAccentBlue.withOpacity(.4),
                          AppColors.lightAccentBlue.withOpacity(.3),
                          AppColors.lightAccentBlue.withOpacity(.2),
                          AppColors.lightAccentBlue.withOpacity(.1),
                          AppColors.lightAccentBlue.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned(
              bottom: -30,
              child: Container(
                height: size.height*0.3,
                width: size.width*0.6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.lightAccentBlue.withOpacity(.0),
                          AppColors.lightAccentBlue.withOpacity(.1),
                          AppColors.lightAccentBlue.withOpacity(.2),
                          AppColors.lightAccentBlue.withOpacity(.3),
                          AppColors.lightAccentBlue.withOpacity(.4),
                          AppColors.lightAccentBlue.withOpacity(.4),
                          AppColors.lightAccentBlue.withOpacity(.3),
                          AppColors.lightAccentBlue.withOpacity(.2),
                          AppColors.lightAccentBlue.withOpacity(.1),
                          AppColors.lightAccentBlue.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned(
              bottom: 1,
              left: 1,
             // top:!Responsive.isTablet(context)? 100 : 200,
              right: 1,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.pinkAccent.withOpacity(.0),
                          Colors.pinkAccent.withOpacity(.1),
                          Colors.pinkAccent.withOpacity(.2),
                          Colors.pinkAccent.withOpacity(.3),
                          Colors.pinkAccent.withOpacity(.4),
                          Colors.pinkAccent.withOpacity(.4),
                          Colors.pinkAccent.withOpacity(.3),
                          Colors.pinkAccent.withOpacity(.2),
                          Colors.pinkAccent.withOpacity(.1),
                          Colors.pinkAccent.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                height: size.height*0.3,
                width: size.width*0.6,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.greenAccent.withOpacity(.0),
                          Colors.greenAccent.withOpacity(.1),
                          Colors.greenAccent.withOpacity(.2),
                          Colors.greenAccent.withOpacity(.3),
                          Colors.greenAccent.withOpacity(.4),
                          Colors.greenAccent.withOpacity(.4),
                          Colors.greenAccent.withOpacity(.3),
                          Colors.greenAccent.withOpacity(.2),
                          Colors.greenAccent.withOpacity(.1),
                          Colors.greenAccent.withOpacity(0),
                        ]
                    )
                ),
              )),
          Positioned.fill(child: BackdropFilter(
            filter:ImageFilter.blur(sigmaY: 30,sigmaX: 30),child: const SizedBox(),
          )),
        ],
      ),
    );
  }
}