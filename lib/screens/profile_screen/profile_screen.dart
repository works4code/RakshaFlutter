import 'package:flutter/material.dart';
import 'package:raksha/common/validation/validation_stream_controller.dart';
import 'package:raksha/common/widgets/buttons.dart';
import 'package:raksha/common/widgets/date_time_formate.dart';
import 'package:raksha/common/widgets/field_and_label.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/prograss_indicator.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/networks/local_notification.dart';
import 'package:raksha/screens/logout_tab/logo_out_dialog.dart';
import 'package:raksha/screens/logout_tab/logout_bloc.dart';
import 'package:raksha/screens/profile_screen/profile_screen_bloc.dart';
import 'package:raksha/screens/profile_screen/profile_screen_widget.dart';
import 'package:raksha/utils/strings.dart';
import '../../utils/colors.dart';
import '../../utils/screen_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController lastScreeningController = TextEditingController();
  TextEditingController lastBSEController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String nameErrorMsg = "";
  String ageErrorMsg = "";

  String lastScreening = '';
  String lastBSE = '';
  String name = '';
  String age = '';

  bool cancerHistory = false;
  bool edit = false;

  setData() {
    name = AppPreference.prefs.getString(db_name);
    age = AppPreference.prefs.getString(db_age);
    lastScreening = AppPreference.prefs.getString(db_lastScreen);
    cancerHistory = AppPreference.prefs.get(db_cancerHistory);
    lastBSE = AppPreference.prefs.get(db_lastBse);
    lastScreeningController.text = lastScreening.isEmpty
        ? dateFormat(dateTime: DateTime.now())
        : lastScreening;
    lastBSEController.text =
        lastBSE.isEmpty ? dateFormat(dateTime: DateTime.now()) : lastBSE;
    setState(() {
      nameController..text = name;
      ageController..text = age;
    });
  }

  @override
  void initState() {
    logoutBloc.getLoadData(false);
    setData();
    super.initState();
  }

  @override
  void dispose() {
    lastScreeningController.clear();
    lastBSEController.clear();
    nameController.clear();
    ageController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: Screen.screenHeight + Screen.screenHeight * 0.07,
                  child: Stack(
                    children: [
                      logoWidget(
                        nameController.text,
                        '',
                        () => setState(() => edit = true),
                        () => logout(context),
                      ),
                      Padding(
                        padding: paddingAll(20.0),
                        child: Column(
                          children: [
                            verticalSpace(Screen.screenHeight * 0.35),
                            FieldAndLabel(
                              labelValue: txt_name,
                              hint: txt_please_enter_name,
                              inputType: TextInputType.text,
                              controller: nameController,
                              readOnly: !edit,
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
                              labelValue: txt_age,
                              hint: txt_please_enter_age,
                              inputType: TextInputType.number,
                              controller: ageController,
                              validationMessage: ageErrorMsg,
                              readOnly: !edit,
                              fillColor: white,
                              onChanged: (value) {
                                setState(() {
                                  ageErrorMsg = nameValidationMsg(value);
                                });
                              },
                            ),
                            verticalSpace(23.0),
                            StreamBuilder(
                              initialData:
                                  profileEditBloc.getBreastCancerError(cancerHistory),
                              stream: profileEditBloc.breastCancerStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  cancerHistory = snapshot.data;
                                  return Column(
                                    children: [
                                      yesNoSelectionProfile(cancerHistory),
                                      verticalSpace(23.0),
                                      if (cancerHistory)
                                        textFieldWithDatePicker(
                                          context,
                                          controller: lastScreeningController,
                                          label: txt_last_screening,
                                          text: lastScreening,
                                          click: edit,
                                        ),
                                      if (cancerHistory) verticalSpace(23.0),
                                      if (cancerHistory)
                                        textFieldWithDatePicker(
                                          context,
                                          controller: lastBSEController,
                                          label: txt_last_bse,
                                          text: lastBSE,
                                          click: edit,
                                        ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                            verticalSpace(23.0),
                            if (edit)
                              filledButton(
                                label: txt_submit,
                                onTap: () async {

                                  if(cancerHistory){
                                    int nsd = stringToDate(lastScreeningController.text).day;
                                    int nsm = stringToDate(lastScreeningController.text).month;
                                    int nsy = stringToDate(lastScreeningController.text).year + 1;
                                    int nbd = stringToDate(lastBSEController.text).day;
                                    int nbm = stringToDate(lastBSEController.text).month + 1;
                                    int nby = stringToDate(lastBSEController.text).year;

                                    NotificationService().setNotification(
                                      5,
                                      msg: "You have your SCREENING Tomorrow",
                                      year: nsy,
                                      month: nsm,
                                      day: nsd,
                                    );
                                    NotificationService().setNotification(
                                      7,
                                      msg: "You have your BSE Tomorrow",
                                      year: nby,
                                      month: nbm,
                                      day: nbd,
                                    );
                                  }
                                  await AppPreference.put(
                                      db_name, nameController.text);
                                  await AppPreference.put(
                                      db_age, ageController.text);
                                  await AppPreference.put(db_lastScreen,
                                      lastScreeningController.text);
                                  await AppPreference.put(
                                      db_lastBse, lastBSEController.text);

                                  String key =
                                      await AppPreference.getString(db_key);
                                  db.child(db_profiles).child(key).update({
                                    'name': nameController.text,
                                    'age': ageController.text,
                                    'lastScreen': lastScreeningController.text,
                                    'lastBse': lastBSEController.text,
                                    'cancerHistory': cancerHistory,
                                  });
                                  setState(() {
                                    edit = false;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                      child: Padding(
                                        padding: paddingAll(20.0),
                                        child: labels(
                                          text: txt_edit_successfully,
                                          size: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                width: Screen.screenWidth * 0.8,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                stream: logoutBloc.loadDataStream,
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data
                      ? fullScreenCircularIndicator
                      : Container();
                },
              ),
            ],
          );
        });
  }
}
