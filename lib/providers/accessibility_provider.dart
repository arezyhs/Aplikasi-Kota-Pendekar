import 'package:flutter/material.dart';
import 'package:pendekar/utils/services/local_storage_service.dart';

// Global instance untuk update real-time
final accessibilityNotifier = AccessibilityNotifier();

class AccessibilityNotifier extends ChangeNotifier {
  AccessibilitySettings _settings = const AccessibilitySettings();

  AccessibilitySettings get settings => _settings;

  Future<void> loadSettings() async {
    _settings = await AccessibilitySettings.load();
    notifyListeners();
  }

  Future<void> updateLargeText(bool enabled) async {
    await LocalStorageService.setBool('large_text', enabled);
    _settings = _settings.copyWith(largeText: enabled);
    notifyListeners();
  }

  Future<void> updateHighContrast(bool enabled) async {
    await LocalStorageService.setBool('high_contrast', enabled);
    _settings = _settings.copyWith(highContrast: enabled);
    notifyListeners();
  }

  Future<void> updateReducedAnimations(bool enabled) async {
    await LocalStorageService.setBool('reduced_animations', enabled);
    _settings = _settings.copyWith(reducedAnimations: enabled);
    notifyListeners();
  }
}

class AccessibilityProvider extends InheritedWidget {
  final AccessibilitySettings settings;

  const AccessibilityProvider({
    Key? key,
    required this.settings,
    required Widget child,
  }) : super(key: key, child: child);

  static AccessibilityProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AccessibilityProvider>();
  }

  @override
  bool updateShouldNotify(AccessibilityProvider oldWidget) {
    return settings != oldWidget.settings;
  }
}

class AccessibilitySettings {
  final bool largeText;
  final bool highContrast;
  final bool reducedAnimations;

  const AccessibilitySettings({
    this.largeText = false,
    this.highContrast = false,
    this.reducedAnimations = false,
  });

  static Future<AccessibilitySettings> load() async {
    final largeText = LocalStorageService.getBool('large_text') ?? false;
    final highContrast = LocalStorageService.getBool('high_contrast') ?? false;
    final reducedAnimations =
        LocalStorageService.getBool('reduced_animations') ?? false;

    return AccessibilitySettings(
      largeText: largeText,
      highContrast: highContrast,
      reducedAnimations: reducedAnimations,
    );
  }

  AccessibilitySettings copyWith({
    bool? largeText,
    bool? highContrast,
    bool? reducedAnimations,
  }) {
    return AccessibilitySettings(
      largeText: largeText ?? this.largeText,
      highContrast: highContrast ?? this.highContrast,
      reducedAnimations: reducedAnimations ?? this.reducedAnimations,
    );
  }

  // Theme helpers
  double getFontScale() => largeText ? 1.3 : 1.0;

  Duration getAnimationDuration(Duration defaultDuration) {
    if (reducedAnimations) {
      return Duration(
          milliseconds: (defaultDuration.inMilliseconds * 0.3).round());
    }
    return defaultDuration;
  }

  ThemeData applyToTheme(ThemeData base) {
    if (!highContrast) return base;

    // High contrast theme modifications - respect dark mode
    final isDark = base.brightness == Brightness.dark;

    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: isDark ? Colors.blue.shade400 : Colors.blue.shade900,
        secondary: isDark ? Colors.orange.shade400 : Colors.orange.shade800,
      ),
      dividerColor: isDark ? Colors.white70 : Colors.black87,
      textTheme: base.textTheme.apply(
        bodyColor: isDark ? Colors.white : Colors.black,
        displayColor: isDark ? Colors.white : Colors.black,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AccessibilitySettings &&
        other.largeText == largeText &&
        other.highContrast == highContrast &&
        other.reducedAnimations == reducedAnimations;
  }

  @override
  int get hashCode =>
      largeText.hashCode ^ highContrast.hashCode ^ reducedAnimations.hashCode;
}
