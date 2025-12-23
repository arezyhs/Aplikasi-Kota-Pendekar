import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/home/home_view.dart';
import 'package:pendekar/screens/splashscreen.dart';

final Map<String, WidgetBuilder> route = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomePage.routeName: (context) => const HomePage(),
};
