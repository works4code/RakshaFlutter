import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:raksha/networks/app_preference.dart';
import 'package:raksha/networks/local_notification.dart';
import 'package:raksha/screens/dashboard_screen/dashboard_screen.dart';
import 'package:raksha/screens/log_in_screen/log_in_screen.dart';
import 'package:raksha/utils/navigator_route.dart';
import 'package:raksha/utils/screen_utils.dart';
import 'networks/db_constants.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await NotificationService().flutterLocalNotificationsPlugin.cancelAll();

  await NotificationService().init();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      routes: routes,
      initialRoute: rootScreen,
      // home: DashBoardScreen(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool login = false;

  Future getUser() async {
    await AppPreference.inti();
    login = (AppPreference.prefs != null)
        ? AppPreference.prefs.getBool(db_login) ?? false
        : false;
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Screen.setScreenSize(context);
    return login ? DashBoardScreen() : LogInScreen();
  }
}
