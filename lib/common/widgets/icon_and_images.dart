import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:raksha/utils/colors.dart';

Widget icons({
  @required IconData icon,
  Color color,
  double size,
}) =>
    Icon(
      icon,
      color: color ?? black,
      size: size ?? 24,
    );

class Images {
  Images._privateConstructor();

  static final Images _instance = Images._privateConstructor();

  static Images get instance => _instance;

  Image networkImage(
          {String url, double height, double width, Color color, BoxFit fit}) =>
      Image.network(url, height: height, width: width, color: color, fit: fit);

  Image assetImage(
          {@required String name,
          double height,
          double width,
          Color color,
          BoxFit fit}) =>
      Image.asset(name, height: height, width: width, color: color, fit: fit);

  ImageProvider networkImageProvider({String url}) => NetworkImage(url);

  ImageProvider assetImageProvider({String name}) => AssetImage(name);

  ImageProvider fileImageProvider({File name}) => FileImage(name);
}
