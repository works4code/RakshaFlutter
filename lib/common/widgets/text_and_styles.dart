import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raksha/utils/colors.dart';

import '../../utils/colors.dart';

Widget labels({
  @required String text,
  Color color,
  double size,
  TextAlign textAlign,
  FontWeight fontWeight,
  TextOverflow overflow,
  int maxLine,
  TextDecoration decoration,
}) =>
    Text(
      text,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLine ?? 1,
      style: defaultTextStyle(
        color: color ?? iconTextColor,
        size: size ?? 14,
        fontWeight: fontWeight,
        decoration: decoration,
        fontFamily: 'Poppins',
      ),
      textAlign: textAlign ?? TextAlign.center,
    );

TextStyle defaultTextStyle({
  Color color,
  double size,
  FontWeight fontWeight,
  String fontFamily,
  TextDecoration decoration,
}) =>
    TextStyle(
      color: color ?? black,
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: fontFamily ?? 'Poppins',
      decoration: decoration ?? TextDecoration.none,
    );
