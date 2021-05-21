import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/screens/dashboard_screen/dashboard_screen_bloc.dart';

import '../../utils/screen_utils.dart';

Widget tabs({String tab, bool isSelected, int index}) {
  return GestureDetector(
    onTap: () => dashboardScreenBloc.getPageNoError(index),
    child: Container(
      height: Screen.screenHeight * 0.045,
      width: Screen.screenHeight * 0.045,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              spreadRadius: -7,
              offset: Offset(0, 2),
              blurRadius: 10,
            )
        ],
        color: isSelected ? null : transparent,
      ),
      child: Images.instance.assetImage(
        name: tab,
        color: isSelected ? white : null,
      ),
    ),
  );
}

Widget tabWidget(String tab) => Images.instance.assetImage(name: tab);
