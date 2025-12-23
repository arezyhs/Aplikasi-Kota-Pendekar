import 'package:flutter/material.dart';
import 'package:pendekar/screens/home/home_shell.dart';
import 'package:pendekar/screens/splashscreen.dart';

final Map<String, WidgetBuilder> route = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeShell.routeName: (context) => const HomeShell(),
};
