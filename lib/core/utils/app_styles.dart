import 'package:flutter/material.dart';

abstract class Styles {
  static TextStyle styleBold14(BuildContext context) => TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w700,
    );
}
//scale factor
// responsive font size
// min max

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return width / 412;
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  double responsiveFontSize = fontSize * getScaleFactor(context);
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}
