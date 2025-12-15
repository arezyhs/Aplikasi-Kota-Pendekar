// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pendekar/homepage/views/splash/splashscreen.dart';
import 'package:pendekar/constants/navigation.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';
import 'package:pendekar/utils/accessibility_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await LocalStorageService.init();

  // Load accessibility settings
  await accessibilityNotifier.loadSettings();

  // Inisialisasi FlutterDownloader
  await FlutterDownloader.initialize(
    debug: true, // debug: false untuk versi produksi
  );

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    var swAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
    if (swAvailable && swInterceptAvailable) {
      ServiceWorkerController serviceWorkerController =
          ServiceWorkerController.instance();
      serviceWorkerController.setServiceWorkerClient(ServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          debugPrint(request.toString());
          return null;
        },
      ));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: accessibilityNotifier,
      builder: (context, child) {
        final darkMode = LocalStorageService.getBool('dark_mode') ?? false;
        final settings = accessibilityNotifier.settings;

        ThemeData baseTheme = ThemeData(
          primarySwatch: Colors.blue,
          brightness: darkMode ? Brightness.dark : Brightness.light,
          scaffoldBackgroundColor: darkMode ? Colors.grey[900] : Colors.white,
        );

        ThemeData theme = settings.applyToTheme(baseTheme);

        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Aplikasi Kota Pendekar',
          theme: theme,
          builder: (context, child) {
            // Apply text scale factor globally
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(settings.getFontScale()),
              ),
              child: child!,
            );
          },
          home: SplashScreen(),
        );
      },
    );
  }
}
