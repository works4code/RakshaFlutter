import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/prograss_indicator.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/screens/log_in_screen/log_in_screen_bloc.dart';
import 'package:raksha/utils/navigator_route.dart';
import '../../common/validation/validation_stream_controller.dart';
import '../../common/widgets/buttons.dart';
import '../../common/widgets/field_and_label.dart';
import '../../common/widgets/icon_and_images.dart';
import '../../common/widgets/padding_margin.dart';
import '../../common/widgets/space_and_dividers.dart';
import '../../common/widgets/text_and_styles.dart';
import '../../networks/app_preference.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../utils/strings.dart';
import 'log_in_screen_widget.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool passVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailErrorMsg = "";
  String passwordErrorMsg = "";

  _signInWithEmailAndPassword(context) async {
    User user;
    try {
      await auth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        user = value.user;
        if (user != null) {
          db
              .child(db_profiles)
              .orderByChild(db_email)
              .equalTo(user.email)
              .once()
              .then((value) {
            value.value.forEach((k, v) {
              AppPreference.put(db_key, k);
              AppPreference.put(db_email, v[db_email]);
              AppPreference.put(db_dob, v[db_dob]);
              AppPreference.put(db_mobile, v[db_mobile]);
              AppPreference.put(db_name, v[db_name]);
              AppPreference.put(db_age, v[db_age]);
              AppPreference.put(db_lastScreen, v[db_lastScreen]);
              AppPreference.put(db_lastBse, v[db_lastBse]);
              AppPreference.put(db_cancerHistory, v[db_cancerHistory]);
            });
            AppPreference.put(db_login, true);
            Navigator.pushReplacementNamed(context, dashboardScreen);
          });
        }
      });
    } catch (e) {
      FirebaseAuthException error = e;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: labels(text: error.message, color: white),
        ),
      );
      logInBloc.getLogInLoading(false);
    }
  }

  @override
  void initState() {
    logInBloc.getLogInLoading(false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppPreference.inti();
    Screen.setScreenSize(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: Screen.screenWidth,
          child: StreamBuilder(
              stream: logInBloc.logInLoadingStream,
              builder: (context, snapshot) {
                return Stack(
                  children: [
                    logoWidget,
                    Padding(
                      padding: paddingAll(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(Screen.screenHeight * 0.35),
                          welcome,
                          loginContinue,
                          verticalSpace(28.0),
                          FieldAndLabel(
                            labelValue: txt_email_address,
                            hint: txt_enter_email,
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                            validationMessage: emailErrorMsg,
                            fillColor: white,
                            leftIcon: icons(
                                icon: Icons.email_outlined,
                                color: iconTextColor),
                            onChanged: (value) {
                              setState(() {
                                emailErrorMsg = emailValidationMsg(value);
                              });
                            },
                          ),
                          verticalSpace(23.0),
                          FieldAndLabel(
                            labelValue: txt_password,
                            hint: txt_enter_password,
                            isPassword: passVisible,
                            controller: passwordController,
                            validationMessage: passwordErrorMsg,
                            fillColor: white,
                            leftIcon: icons(
                                icon: Icons.lock_outline, color: iconTextColor),
                            onChanged: (value) {
                              setState(() {
                                passwordErrorMsg = passwordValidationMsg(value);
                              });
                            },
                            rightIcon: iconButton(
                              onTap: () {
                                setState(() {
                                  passVisible = !passVisible;
                                });
                              },
                              iconColor: iconTextColor,
                              icon: passVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          verticalSpace(16.0),
                          forgotPass(context, onTap: () {}),
                          verticalSpace(46.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              labels(
                                text: txt_login,
                                color: loginColor,
                                size: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                              horizontalSpace(14.0),
                              filledButton(
                                  label: '',
                                  width: 93.0,
                                  child: icons(
                                    icon: Icons.arrow_forward,
                                    size: 24.0,
                                    color: white,
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      emailErrorMsg = emailValidationMsg(
                                          emailController.text);
                                      passwordErrorMsg = passwordValidationMsg(
                                          passwordController.text);
                                    });
                                    if (emailErrorMsg == '' &&
                                        passwordErrorMsg == '') {
                                      logInBloc.getLogInLoading(true);
                                      _signInWithEmailAndPassword(context);
                                    }
                                  }),
                            ],
                          ),
                          verticalSpace(Screen.screenHeight * 0.05),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don’t have an account? ",
                                style: defaultTextStyle(
                                  color: hintColor,
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'New User',
                                    style: defaultTextStyle(
                                      color: loginColor,
                                      size: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushNamed(
                                          context, registrationScreen),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalSpace(Screen.bottomHeight),
                        ],
                      ),
                    ),
                    snapshot.hasData && snapshot.data
                        ? fullScreenCircularIndicator
                        : Container(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
