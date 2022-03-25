import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white70,
  indicatorColor: Colors.white70,
  scaffoldBackgroundColor: const Color.fromRGBO(21, 21, 21, 1.0),
  backgroundColor: const Color.fromRGBO(44, 48, 54, 1.0),
  selectedRowColor: const Color.fromRGBO(98, 103, 103, 1.0),
  focusColor: const Color.fromRGBO(147, 210, 255, 1.0),
);

final lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color.fromRGBO(157, 157, 157, 1.0),
  indicatorColor: const Color.fromRGBO(245, 199, 56, 1.0),
  scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
  backgroundColor: const Color.fromRGBO(238, 242, 248, 1.0),
  selectedRowColor: const Color.fromRGBO(224, 224, 224, 1.0),
  focusColor: const Color.fromRGBO(21, 126, 196, 1.0),
);

final systemDarkTheme = SystemUiOverlayStyle.dark.copyWith(
  systemNavigationBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
  statusBarColor: darkTheme.scaffoldBackgroundColor.withOpacity(.8),
);

final systemLightTheme = SystemUiOverlayStyle.light.copyWith(
  systemNavigationBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: lightTheme.scaffoldBackgroundColor.withOpacity(.8),
);
