import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/date_time_formate.dart';
import 'package:raksha/common/widgets/prograss_indicator.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/models/profile_model.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/networks/local_notification.dart';
import 'package:raksha/screens/registration_screen/registration_screen_bloc.dart';
import 'package:raksha/utils/navigator_route.dart';
import '../../common/validation/validation_stream_controller.dart';
import '../../common/widgets/field_and_label.dart';
import '../../common/widgets/icon_and_images.dart';
import '../../common/widgets/padding_margin.dart';
import '../../common/widgets/space_and_dividers.dart';
import '../../networks/app_preference.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';
import '../../utils/strings.dart';
import 'registration_screen_widget.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastScreeningController = TextEditingController();
  TextEditingController lastBSEController = TextEditingController();

  String emailErrorMsg = "";
  String nameErrorMsg = "";
  String phoneNumberErrorMsg = "";
  String dobErrorMsg = "";
  String passwordErrorMsg = "";
  bool cancerHistory = false;

  _register(context) async {

    if(cancerHistory){
      int nsd = stringToDate(lastScreeningController.text).day;
      int nsm = stringToDate(lastScreeningController.text).month;
      int nsy = stringToDate(lastScreeningController.text).year + 1;
      int nbd = stringToDate(lastBSEController.text).day;
      int nbm = stringToDate(lastBSEController.text).month + 1;
      int nby = stringToDate(lastBSEController.text).year;

      NotificationService().setNotification(
        1,
        msg: "You have your SCREENING Tomorrow",
        year: nsy,
        month: nsm,
        day: nsd,
      );
      NotificationService().setNotification(
        3,
        msg: "You have your BSE Tomorrow",
        year: nby,
        month: nbm,
        day: nbd,
      );
    }
    User user;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        user = value.user;
      });
    } catch (e) {
      var error = e;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: labels(text: error.message, color: white),
        ),
      );
      registrationBloc.getLoadData(false);
    }
    if (user != null) {
      String key = db.push().key;
      ProfileModel profile = ProfileModel(
        name: nameController.text,
        email: emailController.text,
        mobile: phoneNumberController.text,
        dob: dobController.text,
        lastScreen: lastScreeningController.text,
        lastBse: lastBSEController.text,
        cancerHistory: cancerHistory,
        key: key,
      );
      db.child(db_profiles).child(key).set(profile.toMap());
      Navigator.pushReplacementNamed(context, loginScreen);
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: paddingAll(20.0),
            child: labels(
              text: txt_registration_successfully,
              size: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.clear();
    nameController.clear();
    phoneNumberController.clear();
    dobController.clear();
    passwordController.clear();
    lastScreeningController.clear();
    lastBSEController.clear();
    super.dispose();
  }

  @override
  void initState() {
    registrationBloc.getLoadData(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPreference.inti();
    Screen.setScreenSize(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: Screen.screenWidth,
              child: Stack(
                children: [
                  logoWidget,
                  Padding(
                    padding: paddingAll(20.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(Screen.screenHeight * 0.35),
                        FieldAndLabel(
                          labelValue: txt_name,
                          hint: txt_please_enter_name,
                          inputType: TextInputType.text,
                          controller: nameController,
                          validationMessage: nameErrorMsg,
                          fillColor: white,
                          rightIcon: icons(
                              icon: Icons.person, color: iconTextColor),
                          onChanged: (value) {
                            setState(() {
                              nameErrorMsg = nameValidationMsg(value);
                            });
                          },
                        ),
                        verticalSpace(23.0),
                        FieldAndLabel(
                          labelValue: txt_email_address,
                          hint: txt_enter_email,
                          inputType: TextInputType.emailAddress,
                          controller: emailController,
                          validationMessage: emailErrorMsg,
                          fillColor: white,
                          rightIcon: icons(
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
                          labelValue: txt_phone_number,
                          hint: txt_please_enter_phone_number,
                          inputType: TextInputType.phone,
                          controller: phoneNumberController,
                          validationMessage: phoneNumberErrorMsg,
                          maxLength: 10,
                          fillColor: white,
                          rightIcon:
                          icons(icon: Icons.call, color: iconTextColor),
                          onChanged: (value) {
                            setState(() {
                              phoneNumberErrorMsg =
                                  mobileValidationMsg(value);
                            });
                          },
                        ),
                        verticalSpace(23.0),
                        textFieldWithDatePicker(
                          context,
                          controller: dobController,
                          label: txt_DOB,
                          error: dobErrorMsg,
                        ),
                        verticalSpace(23.0),
                        FieldAndLabel(
                          labelValue: txt_password,
                          hint: txt_enter_password,
                          controller: passwordController,
                          validationMessage: passwordErrorMsg,
                          fillColor: white,
                          rightIcon: icons(
                              icon: Icons.lock_outline,
                              color: iconTextColor),
                          onChanged: (value) {
                            setState(() {
                              passwordErrorMsg =
                                  passwordValidationMsg(value);
                            });
                          },
                        ),
                        verticalSpace(23.0),
                        historyOfBreastCancerTitle,
                        verticalSpace(16.0),
                        StreamBuilder(
                          initialData:
                          registrationBloc.getBreastCancerError(cancerHistory),
                          stream: registrationBloc.breastCancerStream,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              cancerHistory = snapshot.data;
                              return Column(
                                children: [
                                  yesNoSelection(cancerHistory),
                                  verticalSpace(16.0),
                                  if (cancerHistory)
                                    screeningBSEWidget(
                                      context,
                                      screeningController:
                                      lastScreeningController,
                                      bseController: lastBSEController,
                                    )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        verticalSpace(30.0),
                        createAccountButton(onTap: () {
                          setState(() {
                            emailErrorMsg =
                                emailValidationMsg(emailController.text);
                            nameErrorMsg =
                                nameValidationMsg(nameController.text);
                            phoneNumberErrorMsg = mobileValidationMsg(
                                phoneNumberController.text);
                            passwordErrorMsg = passwordValidationMsg(
                                passwordController.text);
                            dobErrorMsg =
                                dobValidationMsg(dobController.text);
                          });
                          if (emailErrorMsg == "" &&
                              nameErrorMsg == "" &&
                              phoneNumberErrorMsg == "" &&
                              dobErrorMsg == "" &&
                              passwordErrorMsg == "") {
                            registrationBloc.getLoadData(true);
                            _register(context);
                          }
                        }),
                        verticalSpace(Screen.bottomHeight),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: registrationBloc.loadDataStream,
            builder: (context, snapshot) {
              return  snapshot.hasData && snapshot.data
                  ? fullScreenCircularIndicator
                  : Container();
            },
          ),
        ],
      ),
    );
  }
}
