import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pendekar/screens/splashscreen.dart';
import 'package:pendekar/routes.dart';
import 'package:pendekar/constants/navigation.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';
import 'package:pendekar/utils/services/logger_service.dart';
import 'package:pendekar/providers/accessibility_provider.dart';
import 'package:pendekar/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await LocalStorageService.init();

  // Load accessibility settings
  await accessibilityNotifier.loadSettings();

  // Inisialisasi FlutterDownloader
  await FlutterDownloader.initialize(
    debug: kDebugMode, // Automatically false in production builds
  );

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
    var swAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await WebViewFeature.isFeatureSupported(
        WebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
    if (swAvailable && swInterceptAvailable) {
      ServiceWorkerController serviceWorkerController =
          ServiceWorkerController.instance();
      serviceWorkerController.setServiceWorkerClient(ServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          Logger.debug(request.toString());
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
      animation: themeNotifier,
      builder: (context, _) {
        return AnimatedBuilder(
          animation: accessibilityNotifier,
          builder: (context, child) {
            final settings = accessibilityNotifier.settings;
            final isDark = themeNotifier.isDarkMode;

            debugPrint('🎨 Building app with dark mode: $isDark');

            ThemeData baseTheme =
                isDark ? themeNotifier.darkTheme : themeNotifier.lightTheme;
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
              routes: route,
              initialRoute: SplashScreen.routeName,
            );
          },
        );
      },
    );
  }
}
