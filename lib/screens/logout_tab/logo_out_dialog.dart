import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/buttons.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/networks/local_notification.dart';
import 'package:raksha/utils/navigator_route.dart';
import '../../utils/strings.dart';
import 'logout_bloc.dart';

logout(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: paddingAll(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            labels(
              text: txt_logout_label,
              size: 16.0,
              fontWeight: FontWeight.w600,
            ),
            verticalSpace(20.0),
            yesNoSelection(context),
          ],
        ),
      ),
    ),
  );
}

Widget yesNoSelection(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      filledButton(
        label: txt_yes,
        onTap: () async {
          logoutBloc.getLoadData(true);
          Navigator.pop(context);
          await auth.signOut();
          await NotificationService().flutterLocalNotificationsPlugin.cancelAll();
          AppPreference.clear();
          Navigator.pushReplacementNamed(context, loginScreen);
        },
      ),
      borderButton(
        label: txt_no,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}
