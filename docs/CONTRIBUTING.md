# Panduan Kontribusi

Terima kasih atas minat Anda untuk berkontribusi pada Aplikasi Kota Pendekar!

## Code of Conduct

- Gunakan bahasa yang sopan dan profesional
- Hormati pendapat dan kontribusi orang lain
- Fokus pada improvement, bukan kritik personal
- Diskusi berbasis data dan best practices

## Cara Berkontribusi

### 1. Setup Development Environment

```bash
# Clone repository
git clone https://github.com/arezyhs/Aplikasi-Kota-Pendekar.git
cd Aplikasi-Kota-Pendekar

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

### 2. Buat Branch Baru

```bash
git checkout -b feature/nama-fitur
# atau
git checkout -b fix/nama-bug
```

**Naming convention:**
- `feature/` - Untuk fitur baru
- `fix/` - Untuk bug fixes
- `refactor/` - Untuk code refactoring
- `docs/` - Untuk dokumentasi
- `style/` - Untuk perubahan styling

### 3. Ikuti Code Standards

Lihat bagian **Code Standards** di bawah

### 4. Test Perubahan Anda

```bash
# Run flutter analyze
flutter analyze

# Build untuk verify
flutter build apk --debug
```

### 5. Commit Changes

```bash
git add .
git commit -m "feat: deskripsi singkat perubahan"
```

**Commit message convention:**
- `feat:` - Fitur baru
- `fix:` - Bug fix
- `refactor:` - Code refactoring
- `docs:` - Perubahan dokumentasi
- `style:` - Formatting, whitespace
- `perf:` - Performance improvement
- `test:` - Menambah tests

### 6. Push dan Create Pull Request

```bash
git push origin feature/nama-fitur
```

Kemudian buat Pull Request di GitHub dengan deskripsi yang jelas.

---

## Code Standards

### Dart/Flutter Conventions

#### 1. Naming Conventions

```dart
// Classes: PascalCase
class HomeScreen extends StatelessWidget {}

// Files: snake_case
home_screen.dart
layanan_data.dart

// Variables & functions: camelCase
int currentIndex = 0;
void navigateToHome() {}

// Constants: lowerCamelCase or UPPER_CASE untuk benar-benar const
const maxRetries = 3;
static const String API_BASE_URL = 'https://api.example.com';

// Private members: prefix dengan _
int _privateCounter = 0;
void _privateMethod() {}
```

#### 2. File Organization

```dart
// Import order:
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. Third-party packages (alphabetical)
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

// 4. Project imports (alphabetical)
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/widgets/home_banner.dart';
```

#### 3. Widget Structure

```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  // 2. Properties
  final String title;
  final String? subtitle;

  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildContent(),
    );
  }

  // 4. Private helper methods
  Widget _buildContent() {
    return Text(title);
  }
}
```

#### 4. Use const Constructors

```dart
// ✅ Good
const Text('Hello World')
const SizedBox(height: 16)
const Icon(Icons.home)

// ❌ Avoid
Text('Hello World')
SizedBox(height: 16)
Icon(Icons.home)
```

#### 5. Prefer final over var

```dart
// ✅ Good
final userName = 'John';
final List<String> items = [];

// ❌ Avoid
var userName = 'John';
var items = [];
```

#### 6. Extract Magic Numbers

```dart
// ❌ Bad
Container(
  height: 200,
  padding: EdgeInsets.all(16),
)

// ✅ Good
class AppDimens {
  static const double bannerHeight = 200;
  static const double defaultPadding = 16;
}

Container(
  height: AppDimens.bannerHeight,
  padding: EdgeInsets.all(AppDimens.defaultPadding),
)
```

#### 7. Responsive Sizing

```dart
// ✅ Use SizeConfig untuk responsive
Container(
  height: SizeConfig.getProportionateScreenHeight(200),
  width: SizeConfig.getProportionateScreenWidth(300),
)

// ❌ Avoid hardcoded sizes
Container(
  height: 200,
  width: 300,
)
```

---

### Widget Best Practices

#### 1. Keep Widgets Small

```dart
// ❌ Bad: 500+ lines in one widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 100 lines of banner code
          // 150 lines of menu code
          // 200 lines of news code
          // 50 lines of radio code
        ],
      ),
    );
  }
}

// ✅ Good: Extract to separate widgets
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeBanner(),          // Separate widget
          LayananUtamaWidget(),  // Separate widget
          NewsPreviewWidget(),   // Separate widget
          RadioPlayer(),         // Separate widget
        ],
      ),
    );
  }
}
```

**Rule of thumb**: Jika widget > 300 lines, extract ke subwidgets

#### 2. Use Builder Pattern untuk Complex Widgets

```dart
Widget build(BuildContext context) {
  return Column(
    children: [
      _buildHeader(),
      _buildContent(),
      _buildFooter(),
    ],
  );
}

Widget _buildHeader() => Container(...);
Widget _buildContent() => ListView(...);
Widget _buildFooter() => Row(...);
```

#### 3. Avoid Deep Nesting

```dart
// ❌ Bad: Deep nesting (Pyramid of Doom)
Container(
  child: Padding(
    child: Column(
      children: [
        Container(
          child: Row(
            children: [
              Container(
                child: Text('Hello'),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
)

// ✅ Good: Extract or flatten
Widget _buildGreeting() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: const Text('Hello'),
  );
}
```

---

### Performance Guidelines

#### 1. Use ListView.builder untuk Long Lists

```dart
// ✅ Good
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(
    title: Text(items[index]),
  ),
)

// ❌ Bad (jika items banyak)
ListView(
  children: items.map((item) => ListTile(
    title: Text(item),
  )).toList(),
)
```

#### 2. Implement Pagination

```dart
// ✅ Untuk long lists dari API
ScrollController _scrollController;

@override
void initState() {
  _scrollController = ScrollController()
    ..addListener(_onScroll);
}

void _onScroll() {
  if (_scrollController.offset >= 
      _scrollController.position.maxScrollExtent) {
    _loadMoreData();
  }
}
```

#### 3. Cache Network Images

```dart
// ✅ Use cached_network_image
CachedNetworkImage(
  imageUrl: imageUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)

// ❌ Avoid Image.network untuk repeated images
Image.network(imageUrl)
```

---

### WebView Guidelines

#### 1. Always Use BaseWebViewPage Template

```dart
// ✅ Good
class WebMyApp extends StatelessWidget {
  const WebMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWebViewPage(
      url: AppConfig.getPublikAppUrl('myapp'),
      title: 'My App',
    );
  }
}

// ❌ Bad: Re-implementing WebView logic
class WebMyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: InAppWebView(
        // Duplicate configuration...
      ),
    );
  }
}
```

#### 2. URL Management

```dart
// ✅ Centralized di app_config.dart
class AppConfig {
  static const Map<String, String> _publikApps = {
    'myapp': 'https://myapp.madiunkota.go.id/',
  };
  
  static String getPublikAppUrl(String appName) {
    return _publikApps[appName] ?? _defaultUrl;
  }
}

// ❌ Hardcoded URLs di widget
final url = 'https://myapp.madiunkota.go.id/';
```

---

### State Management

#### 1. Use Provider untuk Global State

```dart
// ✅ Define provider
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

// ✅ Use in widget
final themeProvider = Provider.of<ThemeProvider>(context);
```

#### 2. Use StatefulWidget untuk Local State

```dart
// ✅ Local state di widget
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;
  
  void _increment() {
    setState(() => _counter++);
  }
}
```

---

## Testing Requirements

### Sebelum Submit PR

- [ ] `flutter analyze` tidak ada error
- [ ] Manual testing di emulator/device
- [ ] Test navigasi (forward & back)
- [ ] Test di dark mode (jika applicable)
- [ ] Test di berbagai screen sizes
- [ ] Check performance (no lag/stutter)

### Writing Tests (Recommended)

```dart
// Unit test example
test('LayananApp should have required fields', () {
  final app = LayananApp(
    icon: 'icon.png',
    text: 'Test App',
    page: Container(),
  );
  
  expect(app.icon, 'icon.png');
  expect(app.text, 'Test App');
});

// Widget test example
testWidgets('HomeScreen should display banner', (tester) async {
  await tester.pumpWidget(MaterialApp(home: HomeScreen()));
  
  expect(find.byType(HomeBanner), findsOneWidget);
});
```

---

## Git Workflow

### Branch Strategy

```
main (production)
  │
  ├── develop (integration)
  │     ├── feature/new-feature-1
  │     ├── feature/new-feature-2
  │     └── fix/bug-fix-1
```

### Pull Request Checklist

- [ ] Code mengikuti standards di atas
- [ ] Tidak ada conflict dengan main/develop
- [ ] Deskripsi PR jelas dan lengkap
- [ ] Screenshot jika perubahan UI
- [ ] Updated dokumentasi jika perlu
- [ ] flutter analyze clean
- [ ] Manual testing completed

### PR Description Template

```markdown
## Deskripsi
[Jelaskan perubahan yang dibuat]

## Jenis Perubahan
- [ ] Bug fix
- [ ] New feature
- [ ] Refactoring
- [ ] Documentation

## Testing
- [ ] flutter analyze clean
- [ ] Manual testing di device
- [ ] Dark mode tested
- [ ] Different screen sizes tested

## Screenshots (jika ada perubahan UI)
[Tambahkan screenshots]

## Checklist
- [ ] Code mengikuti style guide
- [ ] Documentation updated
- [ ] No console errors/warnings
```

---

## Pertanyaan?

Jika ada pertanyaan tentang contributing:
1. Buka issue di GitHub
2. Tag dengan label `question`
3. Atau hubungi [@arezyhs](https://github.com/arezyhs)

---

**Happy Coding! 🚀**

**Last Updated:** 24 Desember 2025
