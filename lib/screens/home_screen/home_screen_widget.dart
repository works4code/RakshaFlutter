import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/buttons.dart';
import 'package:raksha/common/widgets/date_time_formate.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/images.dart';
import 'package:raksha/utils/screen_utils.dart';
import 'package:raksha/utils/strings.dart';

Widget logoWidget(String name) => Container(
      height: Screen.screenHeight * 0.5,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Images.instance.assetImage(
            name: loginBackGround,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: paddingOnly(bottom: Screen.screenHeight * 0.25),
            child: Row(
              children: [
                horizontalSpace(19.0),
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: Images.instance.assetImageProvider(
                    name: round_logo,
                  ),
                ),
                horizontalSpace(14.0),
                hiLabel(name),
              ],
            ),
          ),
        ],
      ),
    );

Widget hiLabel(String name) => labels(
      text: 'Hi,\n$name',
      color: darkTextColor,
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.start,
      maxLine: 2,
      size: 26.0,
    );

Widget screeningBSEWidget(
  BuildContext context, {
  @required String screening,
  String screeningDate,
  @required String bse,
  String bseDate,
  @required TextEditingController screeningController,
  @required TextEditingController bseController,
  bool click,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: textFieldWithDatePicker(
          context,
          controller: screeningController,
          label: screening,
          text: screeningDate,
          click: click,
        ),
      ),
      horizontalSpace(10.0),
      Expanded(
        child: textFieldWithDatePicker(
          context,
          controller: bseController,
          label: bse,
          text: bseDate,
          click: click,
        ),
      ),
    ],
  );
}

Widget submitButton({@required Function onTap}) {
  return filledButton(
    label: txt_submit,
    onTap: onTap,
    width: Screen.screenWidth * 0.8,
  );
}
