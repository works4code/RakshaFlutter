import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/date_time_formate.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/networks/local_notification.dart';
import 'package:raksha/screens/home_screen/home_screen_widget.dart';
import 'package:raksha/utils/strings.dart';

import '../../utils/screen_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController lastScreeningController = TextEditingController();
  TextEditingController lastBSEController = TextEditingController();
  TextEditingController nextScreeningController = TextEditingController();
  TextEditingController nextBSEController = TextEditingController();

  String lastScreening = '';
  String lastBSE = '';
  String name = '';

  setData() {
    lastScreening = AppPreference.prefs.getString(db_lastScreen);
    name = AppPreference.prefs.getString(db_name);
    lastBSE = AppPreference.prefs.get(db_lastBse);
    lastScreeningController.text = lastScreening.isEmpty
        ? dateFormat(dateTime: DateTime.now())
        : lastScreening;
    lastBSEController.text =
        lastBSE.isEmpty ? dateFormat(dateTime: DateTime.now()) : lastBSE;

    int nsd = stringToDate(lastScreeningController.text).day;
    int nsm = stringToDate(lastScreeningController.text).month;
    int nsy = stringToDate(lastScreeningController.text).year + 1;
    int nbd = stringToDate(lastBSEController.text).day;
    int nbm = stringToDate(lastBSEController.text).month + 1;
    int nby = stringToDate(lastBSEController.text).year;

    nextScreeningController.text =
        dateFormat(dateTime: DateTime(nsy, nsm, nsd));
    nextBSEController.text = dateFormat(dateTime: DateTime(nby, nbm, nbd));
    setState(() {});
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  void dispose() {
    lastScreeningController.clear();
    lastBSEController.clear();
    nextScreeningController.clear();
    nextBSEController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          logoWidget(name ?? ''),
          Padding(
            padding: paddingAll(20.0),
            child: Column(
              children: [
                verticalSpace(Screen.screenHeight * 0.35),
                screeningBSEWidget(
                  context,
                  screening: txt_last_screening,
                  bse: txt_last_bse,
                  screeningController: lastScreeningController,
                  bseController: lastBSEController,
                  click: false,
                  screeningDate: lastScreeningController.text,
                  bseDate: lastBSEController.text,
                ),
                verticalSpace(23.0),
                screeningBSEWidget(
                  context,
                  screening: txt_next_screening,
                  bse: txt_next_bse,
                  screeningController: nextScreeningController,
                  bseController: nextBSEController,
                  click: false,
                  screeningDate: nextScreeningController.text,
                  bseDate: nextBSEController.text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
