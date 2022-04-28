import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/themes.dart';
import 'package:zweeck/view/home/home_view.dart';

void main() {
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
          ? systemDarkTheme
          : systemLightTheme,
    );

    return MaterialApp(
      title: 'ZweecK',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: true,
      home: const HomeView(),
    );
  }
}
