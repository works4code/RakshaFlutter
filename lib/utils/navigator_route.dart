import 'package:raksha/screens/registration_screen/registration_screen.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/log_in_screen/log_in_screen.dart';

const String rootScreen = "/";
const String loginScreen = "LogInScreen";
const String introScreen = "LogInScreen";
const String dashboardScreen = "DashboardScreen";
const String registrationScreen = "RegistrationScreen";

Map<String, WidgetBuilder> routes = {
  rootScreen: (context) => MyApp(),
  loginScreen: (context) => LogInScreen(),
  dashboardScreen: (context) => DashBoardScreen(),
  registrationScreen: (context) => RegistrationScreen(),
};
