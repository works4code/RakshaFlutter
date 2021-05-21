import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/buttons.dart';
import 'package:raksha/common/widgets/date_time_formate.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/images.dart';
import 'package:raksha/screens/registration_screen/registration_screen_bloc.dart';
import 'package:raksha/utils/screen_utils.dart';
import 'package:raksha/utils/strings.dart';

Widget logoWidget = Container(
  height: Screen.screenHeight * 0.5,
  child: Stack(
    fit: StackFit.expand,
    children: [
      Images.instance.assetImage(
        name: loginBackGround,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: paddingOnly(bottom: Screen.screenHeight * 0.15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              child: Images.instance.assetImage(name: registration_clip_art),
              alignment: Alignment.centerRight,
            ),
            Row(
              children: [
                horizontalSpace(19.0),
                createAccount,
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);

Widget historyOfBreastCancerTitle = labels(
  text: txt_history_of_breast_cancer,
  color: iconTextColor,
  fontWeight: FontWeight.w400,
  size: 14.0,
);

Widget createAccount = labels(
  text: txt_create_an_account,
  color: darkTextColor,
  fontWeight: FontWeight.w600,
  textAlign: TextAlign.start,
  maxLine: 2,
  size: 26.0,
);

Widget yesNoSelection(bool yesNo) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      yesNo ? fillBtn(txt_yes, true) : borderBtn(txt_yes, true),
      !yesNo ? fillBtn(txt_no, false) : borderBtn(txt_no, false),
    ],
  );
}

Widget fillBtn(String label, bool ans) => filledButton(
      label: label,
      onTap: () {
        registrationBloc.getBreastCancerError(ans);
      },
      width: Screen.screenWidth * 0.35,
    );

Widget borderBtn(String label, bool ans) => borderButton(
      label: label,
      onTap: () {
        registrationBloc.getBreastCancerError(ans);
      },
      width: Screen.screenWidth * 0.35,
    );

Widget screeningBSEWidget(
  BuildContext context, {
  @required TextEditingController screeningController,
  @required TextEditingController bseController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: textFieldWithDatePicker(
          context,
          controller: screeningController,
          label: txt_last_screening,
          text: dateFormat(dateTime: DateTime.now()),
        ),
      ),
      horizontalSpace(10.0),
      Expanded(
        child: textFieldWithDatePicker(
          context,
          controller: bseController,
          label: txt_last_bse,
          text: dateFormat(dateTime: DateTime.now()),
        ),
      ),
    ],
  );
}

Widget createAccountButton({@required Function onTap}) {
  return filledButton(
    label: txt_create_account,
    onTap: onTap,
    width: Screen.screenWidth * 0.8,
  );
}
