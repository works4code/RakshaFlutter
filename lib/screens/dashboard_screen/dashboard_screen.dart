import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/screens/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:raksha/screens/docs_screen/docs_screen.dart';
import 'package:raksha/screens/home_screen/home_screen.dart';
import 'package:raksha/utils/icons.dart';
import 'package:raksha/screens/profile_screen/profile_screen.dart';
import 'package:raksha/utils/screen_utils.dart';

import '../../utils/colors.dart';
import 'dashboard_screen_widget.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPreference.inti();
    Screen.setScreenSize(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: StreamBuilder(
          initialData: dashboardScreenBloc.getPageNoError(0),
          stream: dashboardScreenBloc.pageNoStream,
          builder: (context, snapshot) {
            return Stack(
              children: [
                selectedPage(snapshot.data),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: Screen.screenHeight * 0.07,
                    margin: paddingSymmetric(horizontal: 20.0, vertical: 25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: tabBackGroundColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        tabs(
                          tab: ic_home,
                          index: 0,
                          isSelected: snapshot.data == 0 ? true : false,
                        ),
                        tabs(
                          tab: ic_profile,
                          index: 1,
                          isSelected: snapshot.data == 1 ? true : false,
                        ),
                        tabs(
                          tab: ic_docs,
                          index: 2,
                          isSelected: snapshot.data == 2 ? true : false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget selectedPage(index) {
    switch (index) {
      case 0:
        return HomeScreen();
        break;
      case 1:
        return ProfileScreen();
        break;
      case 2:
        return DocsScreen();
        break;
      default:
        return Container();
        break;
    }
  }
}
