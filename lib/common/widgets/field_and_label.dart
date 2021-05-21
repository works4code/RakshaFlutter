import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import 'padding_margin.dart';
import 'text_and_styles.dart';

class FieldAndLabel extends StatefulWidget {
  final TextStyle labelTextStyle;
  final Color fillColor;
  final String labelValue;
  final int maxLine;
  final int maxLength;
  final bool isRequire;
  final Widget rightIcon;
  final Widget leftIcon;
  final bool isPassword;
  final bool readOnly;
  final EdgeInsetsGeometry padding;
  final String hint;
  final Function onEditingComplete;
  final Function onTap;
  final Function onChanged;
  final TextInputType inputType;
  final String validationMessage;
  final TextEditingController controller;

  FieldAndLabel({
    this.isRequire = false,
    this.readOnly = false,
    this.fillColor,
    this.maxLine,
    this.maxLength,
    this.labelTextStyle,
    this.padding,
    this.labelValue,
    this.onTap,
    this.onChanged,
    this.inputType,
    this.isPassword = false,
    this.onEditingComplete,
    this.hint,
    this.rightIcon,
    this.leftIcon,
    this.validationMessage,
    this.controller,
  });

  @override
  _FieldAndLabelState createState() => _FieldAndLabelState();
}

class _FieldAndLabelState extends State<FieldAndLabel> {
  var currentFieldValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.labelValue != null ? buildLabel(context) : Container(),
        buildTextField(context),
        buildValidationMessage(context),
      ],
    );
  }

  Widget buildLabel(BuildContext context) {
    return (widget.labelValue != null && widget.labelValue.isNotEmpty)
        ? Padding(
            padding: paddingOnly(bottom: 10.0),
            child: Row(children: <Widget>[
              labels(
                text: widget.labelValue,
                color: iconTextColor,
                size: 14,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
              ),
              if (widget.isRequire)
                Text(
                  "*",
                  style: defaultTextStyle(color: primaryColor, size: 14),
                  textAlign: TextAlign.start,
                ),
            ]),
          )
        : Container();
  }

  Widget buildTextField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            offset: Offset(0, 2),
            blurRadius: 12,
          )
        ],
      ),
      child: TextFormField(
        keyboardType: widget.inputType,
        autofocus: false,
        obscureText: widget.isPassword ? visible : widget.isPassword,
        style: TextStyle(
          color: iconTextColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        controller: widget.controller,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        maxLength: widget.maxLength,
        cursorColor: iconTextColor,
        maxLines: widget.maxLine ?? 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: transparent,
            ),
          ),
          alignLabelWithHint: true,
          suffixIcon: passVisibilityIcon(),
          prefixIcon: widget.leftIcon,
          counterText: "",
          hintText: widget.hint,
          hintStyle: TextStyle(color: hintColor),
          filled: true,
          isDense: true,
          fillColor: widget.fillColor ?? white,
        ),
      ),
    );
  }

  bool visible = true;

  Widget passVisibilityIcon() => widget.rightIcon;

  Widget buildValidationMessage(BuildContext context) {
    return buildValidationErrorMessage(context,
        validationMessage: widget.validationMessage);
  }

  bool isBlank(String value) {
    return value == null || value == '';
  }

  Widget buildValidationErrorMessage(BuildContext context,
      {String validationMessage}) {
    return (!isBlank(validationMessage))
        ? Padding(
            padding: paddingOnly(
              left: 20,
              top: 5.0,
            ),
            child: Row(
              children: [
                Text(
                  validationMessage,
                  style: TextStyle(
                    fontSize: 13,
                    color: widget.validationMessage == "Valid"
                        ? Colors.green
                        : red,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
