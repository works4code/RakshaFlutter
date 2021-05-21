import 'package:flutter/material.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/screen_utils.dart';

Widget circularIndicator = Center(child: CircularProgressIndicator());
Widget fullScreenCircularIndicator = Container(
  height: Screen.screenHeight,
  width: Screen.screenWidth,
  color: black12,
  child: Center(
    child: CircularProgressIndicator(
      color: white,
    ),
  ),
);
