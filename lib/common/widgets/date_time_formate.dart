import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/icons.dart';
import 'package:raksha/utils/strings.dart';

import 'field_and_label.dart';

String dateFormat({DateTime dateTime, String format}) =>
    DateFormat(format ?? 'dd/MM/yyyy').format(dateTime);

DateTime stringToDate(String date) => DateFormat('dd/MM/yyyy').parse(date);

Widget textFieldWithDatePicker(
  context, {
  @required TextEditingController controller,
  @required String label,
  String error,
  String text,
  bool click = true,
}) {
  return FieldAndLabel(
    readOnly: true,
    hint: txt_date_format,
    labelValue: label,
    controller: controller..text = text,
    fillColor: white,
    validationMessage: error ?? '',
    onTap: (click ?? true)
        ? () async {
            await showDatePicker(
              context: context,
              lastDate: DateTime(DateTime.now().year+1),
              firstDate: DateTime(1960),
              initialDate: DateTime.now(),
            ).then((value) => controller.text = dateFormat(dateTime: value));
          }
        : null,
    rightIcon: Images.instance.assetImage(
      name: ic_calender,
      color: hintColor,
    ),
  );
}
