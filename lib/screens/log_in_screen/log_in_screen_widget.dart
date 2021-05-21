import 'package:flutter/material.dart';
import 'package:raksha/common/validation/validation_stream_controller.dart';
import 'package:raksha/common/widgets/field_and_label.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/screens/home_screen/home_screen_widget.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/images.dart';
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
        child: Images.instance.assetImage(name: app_logo),
      ),
    ],
  ),
);

Widget welcome = labels(
  text: txt_welcome_back,
  color: darkTextColor,
  fontWeight: FontWeight.w600,
  size: 26.0,
);
Widget loginContinue = labels(
  text: txt_login_to_continue,
  color: darkTextColor,
  fontWeight: FontWeight.w400,
  size: 14.0,
);

Widget forgotPass(context, {@required Function onTap}) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ForgotPassword(),
            );
          },
          child: labels(
            text: txt_forgot_password,
            color: hintColor,
            size: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  String emailErrorMsg = "";

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: paddingAll(20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: [
        FieldAndLabel(
          labelValue: txt_email_address,
          hint: txt_enter_email,
          inputType: TextInputType.emailAddress,
          controller: emailController,
          validationMessage: emailErrorMsg,
          fillColor: white,
          leftIcon: icons(icon: Icons.email_outlined, color: iconTextColor),
          onChanged: (value) {
            setState(() {
              emailErrorMsg = emailValidationMsg(value);
            });
          },
        ),
        verticalSpace(20.0),
        submitButton(
          onTap: () async {
            try {
              await auth
                  .sendPasswordResetEmail(email: emailController.text)
                  .then((value) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: labels(text: 'Please check your mail for reset password', color: white),
                  ),
                );
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: labels(text: 'User Not Define...', color: white),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
