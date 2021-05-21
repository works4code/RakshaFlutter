import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/screen_utils.dart';

import 'icon_and_images.dart';

Widget submitButton({
  @required String text,
  @required Function onPressed,
  Color textColor,
  double height,
  Color backgroundColor,
  bool isBorder = false,
  Color bColor,
  bool buttonLogo = false,
  double radius = 25.0,
  double width,
  Widget child,
}) {
  return Container(
    height: height ?? 40,
    width: width,
    decoration: BoxDecoration(
      gradient: backgroundColor == null
          ? LinearGradient(
              colors: gradientColor,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
          : null,
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: isBorder
          ? Border.all(
              color: bColor ?? disableIconColor,
              style: BorderStyle.solid,
            )
          : Border.all(color: transparent),
    ),
    child: InkWell(
      onTap: onPressed,
      child: Center(
        child: child ??
            labels(
              text: text,
              color: textColor ?? iconTextColor,
              size: 14,
              fontWeight: FontWeight.w600,
            ),
      ),
    ),
  );
}

Widget iconButton({
  IconData icon,
  Function onTap,
  Color iconColor,
  double size,
}) {
  return IconButton(
    icon: icons(
      icon: icon,
      color: iconColor ?? white,
      size: size,
    ),
    onPressed: onTap,
  );
}

Widget filledButton({
  @required String label,
  @required Function onTap,
  double width,
  Widget child,
}) {
  return submitButton(
    text: label,
    height: Screen.screenHeight * 0.045,
    width: width ?? Screen.screenWidth * 0.27,
    onPressed: onTap,
    textColor: white,
    child: child,
  );
}

Widget borderButton({
  @required String label,
  @required Function onTap,
  double width,
}) {
  return submitButton(
    text: label,
    height: Screen.screenHeight * 0.045,
    width: width ?? Screen.screenWidth * 0.27,
    onPressed: onTap,
    textColor: loginColor,
    backgroundColor: white,
    bColor: loginColor,
    isBorder: true,
  );
}

Widget textButton({
  @required String text,
  @required Function onTap,
}) {
  return TextButton(
    onPressed: onTap,
    child: labels(
      text: text,
      color: loginColor,
      size: 14.0,
      fontWeight: FontWeight.w600,
    ),
  );
}
