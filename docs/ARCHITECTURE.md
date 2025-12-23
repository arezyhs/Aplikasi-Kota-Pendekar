# Arsitektur Aplikasi Kota Pendekar

## Overview

Aplikasi ini menggunakan **Clean Architecture** dengan prinsip separation of concerns untuk kemudahan maintenance dan skalabilitas.

## Struktur Folder

```
lib/
├── main.dart              # Entry point & MaterialApp configuration
├── routes.dart            # Named routes definition
│
├── screens/               # UI layer - Full screen pages
├── widgets/               # Reusable UI components
├── models/                # Data structures & entities
├── constants/             # Static data & configurations
├── api/                   # External API services
├── utils/                 # Helper functions & utilities
└── daftarAplikasi/        # WebView application screens
```

## Layer Architecture

### 1. Screens Layer (`lib/screens/`)

**Purpose**: Halaman lengkap yang menjadi destination navigasi

**Struktur:**
```
screens/
├── splashscreen.dart
├── home/
│   ├── home_shell.dart       # Navigation container (BottomNavigationBar)
│   └── home_screen.dart      # Home tab content
├── layanan/                  # Service category screens
│   ├── layanan_screen.dart
│   ├── layanan_asn_screen.dart
│   ├── layanan_publik_screen.dart
│   ├── layanan_kesehatan_screen.dart
│   ├── layanan_pengaduan_screen.dart
│   └── layanan_informasi_screen.dart
├── berita/
│   └── berita_screen.dart
└── settings/
    ├── settings_screen.dart
    ├── kebijakan_privasi.dart
    └── syarat_ketentuan.dart
```

**Karakteristik:**
- Stateful/Stateless Widget yang menjadi full page
- Handle business logic minimal
- Compose dari multiple widgets
- Registered di `routes.dart`

**Contoh:**
```dart
class HomeScreen extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HomeBanner(),           // Widget
        LayananUtamaWidget(),   // Widget
        NewsPreviewWidget(),    // Widget
        RadioPlayer(),          // Widget
      ],
    );
  }
}
```

---

### 2. Widgets Layer (`lib/widgets/`)

**Purpose**: Komponen UI reusable yang bisa digunakan di multiple screens

**File utama:**
```
widgets/
├── home_banner.dart              # Banner carousel homepage
├── home_carousel.dart            # Generic carousel component
├── radio_player.dart             # Radio 93FM player widget
├── section_header.dart           # Section title with divider
├── news_preview_widget.dart      # RSS feed preview (top 3)
├── layanan_utama_widget.dart     # Layanan grid + featured
├── layanan_widgets.dart          # Layanan item card
├── category_menu_screen.dart     # Generic category menu template
└── dialog_warning.dart           # Warning dialog component
```

**Karakteristik:**
- Stateful/Stateless Widget reusable
- Self-contained dengan state management sendiri
- Bisa menerima parameters via constructor
- Tidak aware tentang navigation routing

**Contoh:**
```dart
class NewsPreviewWidget extends StatefulWidget {
  final int maxItems;
  
  const NewsPreviewWidget({this.maxItems = 3});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) => NewsCard(newsItems[index]),
    );
  }
}
```

---

### 3. Models Layer (`lib/models/`)

**Purpose**: Data structures dan type definitions

**File:**
```
models/
└── layanan_category.dart
```

**Karakteristik:**
- Plain Dart classes
- Immutable data structures
- Memiliki `fromJson`/`toJson` jika perlu serialization

**Contoh:**
```dart
class LayananApp {
  final String icon;
  final String text;
  final Widget? page;
  final String? appId;
  final String? uriScheme;
  
  const LayananApp({
    required this.icon,
    required this.text,
    this.page,
    this.appId,
    this.uriScheme,
  });
}
```

---

### 4. Constants Layer (`lib/constants/`)

**Purpose**: Static data, configurations, dan centralized constants

**File utama:**
```
constants/
├── constant.dart          # App-wide constants (colors, sizes, strings)
├── layanan_data.dart      # Static data for all services/apps
├── navigation.dart        # Navigation constants
└── permission.dart        # Permission constants
```

**Karakteristik:**
- Statik, immutable
- Single source of truth untuk data
- Easy to maintain dan update

**Contoh:**
```dart
class LayananData {
  static final List<LayananApp> asnApps = [
    LayananApp(
      icon: "assets/images/imgicon/eoffice.png",
      text: "E-Office",
      page: WebEOffice(),
    ),
    // ... more apps
  ];
}
```

---

### 5. Utils Layer (`lib/utils/`)

**Purpose**: Helper functions, services, dan utilities

**Struktur:**
```
utils/
├── size_config.dart                    # Responsive sizing helpers
├── web_container_page.dart             # WebView base page template
├── theme_provider.dart                 # Dark mode state management
├── accessibility_provider.dart         # Accessibility settings
├── feature_registry.dart               # Feature flags
├── helpers/
│   ├── text_helper.dart
│   └── color_helpers.dart
├── services/
│   ├── app_config.dart                 # URL configurations
│   ├── local_storage_service.dart
│   └── cache_manager_service.dart
└── notifications/
    └── switch_tab_notification.dart    # Custom notification classes
```

**Karakteristik:**
- Pure functions tanpa side effects
- Reusable across entire app
- Service classes untuk external dependencies

---

### 6. API Layer (`lib/api/`)

**Purpose**: External API integrations

**File:**
```
api/
├── apiedu.dart
├── apimarketplace.dart
└── apiproumkm.dart
```

**Karakteristik:**
- Handle HTTP requests
- Parse responses
- Error handling

---

### 7. DaftarAplikasi Layer (`lib/daftarAplikasi/`)

**Purpose**: 50+ WebView application screens

**Struktur:**
```
daftarAplikasi/
├── aplikasi ASN/          # Employee services (17 apps)
│   ├── eoffice.dart
│   ├── absenrapat.dart
│   └── ...
└── aplikasi warga/        # Citizen services (33+ apps)
    ├── jdih.dart
    ├── opendata.dart
    └── ...
```

**Karakteristik:**
- Simple WebView wrappers
- Menggunakan `BaseWebViewPage` dari utils
- URL configuration dari `app_config.dart`

---

## Data Flow

### Normal Flow
```
User Input → Screen → Widget → Model → Utils/API → Response → Widget → Screen → UI Update
```

### Navigation Flow
```
SplashScreen (/) 
    ↓
HomeShell (/home) - BottomNavigationBar
    ├── Tab 0: HomeScreen
    ├── Tab 1: LayananScreen → CategoryMenuScreen → WebView Apps
    └── Tab 2: BeritaScreen
```

### WebView Flow
```
User tap menu item
    ↓
Navigate to WebView widget (e.g., WebEOffice)
    ↓
Extend BaseWebViewPage dengan URL dari AppConfig
    ↓
WebView renders dengan cache management
```

---

## State Management

**Current approach**: **Provider Pattern** untuk global state

**State yang dimanage:**
- `ThemeProvider` - Dark mode toggle
- `AccessibilityProvider` - Font size, high contrast
- Widget internal state menggunakan `StatefulWidget`

**Contoh:**
```dart
// Di main.dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ChangeNotifierProvider(create: (_) => AccessibilityProvider()),
  ],
  child: MyApp(),
)

// Di widget
final themeProvider = Provider.of<ThemeProvider>(context);
bool isDark = themeProvider.isDarkMode;
```

---

## Navigation Strategy

**Menggunakan Named Routes**

Definisi di `routes.dart`:
```dart
final Map<String, WidgetBuilder> routes = {
  '/': (context) => SplashScreen(),
  '/home': (context) => HomeShell(),
};
```

**Navigation dengan history management:**
- `HomeShell` menggunakan `PopScope` dengan custom back button behavior
- History stack untuk tab navigation
- `SwitchTabNotification` untuk programmatic tab switching

---

## Key Design Patterns

### 1. Template Pattern
**BaseWebViewPage** sebagai template untuk semua WebView apps:
```dart
class WebEOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getAsnAppUrl('eoffice'),
      title: 'E-Office',
    );
  }
}
```

### 2. Factory Pattern
**AppConfig.getUrl()** methods untuk URL generation:
```dart
static String getAsnAppUrl(String appName) {
  return _asnApps[appName] ?? _defaultUrl;
}
```

### 3. Observer Pattern
**Provider** untuk state management:
```dart
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
```

### 4. Notification Pattern
**Custom Notification** untuk cross-widget communication:
```dart
class SwitchTabNotification extends Notification {
  final int index;
  const SwitchTabNotification(this.index);
}

// Dispatch
SwitchTabNotification(2).dispatch(context);

// Listen
NotificationListener<SwitchTabNotification>(
  onNotification: (notification) {
    setState(() => _currentIndex = notification.index);
    return true;
  },
)
```

---

## Refactoring History

### Version 1.2.6 (24 Desember 2025)
**Major Restructure - Clean Architecture Implementation**

**Before:**
```
lib/
├── homepage/                  # 1010 lines home_view.dart
│   ├── views/
│   │   ├── home_view.dart    # Bloated: navigation + content + widgets
│   │   └── components/
│   └── menu/
```

**After:**
```
lib/
├── screens/home/
│   ├── home_shell.dart       # Navigation only (170 lines)
│   └── home_screen.dart      # Content only (216 lines)
├── widgets/                   # Extracted components
│   ├── news_preview_widget.dart       # 200 lines
│   └── layanan_utama_widget.dart      # 380 lines
```

**Results:**
- 79% code reduction di home screen (1010 → 216 lines)
- Clear separation of concerns
- Easier maintenance dan testing
- Professional Flutter structure

---

## Best Practices

### Screen Development
✅ Keep screens focused on layout dan composition  
✅ Extract complex logic ke widgets atau utils  
✅ Use responsive sizing dari `SizeConfig`  
✅ Register new routes di `routes.dart`

### Widget Development
✅ Keep widgets small dan focused (< 300 lines ideal)  
✅ Make widgets reusable dengan parameters  
✅ Use `const` constructors when possible  
✅ Prefer `StatelessWidget` if no state needed

### Data Management
✅ Centralize static data di `constants/`  
✅ Use models untuk complex data structures  
✅ Validate data sebelum display  
✅ Handle null safety properly

### Performance
✅ Use `const` widgets untuk optimization  
✅ Implement pagination untuk long lists  
✅ Cache network images dengan `cached_network_image`  
✅ Lazy load WebViews (only when needed)

---

## Testing Strategy

### Unit Tests
- Test pure functions di utils/
- Test data models

### Widget Tests
- Test individual widgets di isolation
- Test widget interactions

### Integration Tests
- Test navigation flows
- Test WebView loading
- Test state management

---

**Last Updated:** 24 Desember 2025
