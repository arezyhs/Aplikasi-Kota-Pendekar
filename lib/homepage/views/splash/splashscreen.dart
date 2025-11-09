import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:pendekar/homepage/views/home/home_view.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pendekar Kota Madiun',
      home: AnimatedSplashScreen(
        splash: 'assets/images/splash.gif',
        nextScreen: const HomePage(),
        duration: 5000,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: double.infinity,
        // alignment: Alignment.topCenter,
        backgroundColor: const Color(0xffe5e5e5),
      ),
      // routes: {
      //   otp.routeName: (context) => otp(),
      // }
    );
  }
}
