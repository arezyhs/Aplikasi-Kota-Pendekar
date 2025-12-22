import 'package:flutter/material.dart';
import 'package:pendekar/screens/home/home_screen.dart';
import 'package:pendekar/screens/berita/berita_screen.dart';
import 'package:pendekar/screens/layanan/layanan_screen.dart';
import 'package:pendekar/homepage/views/components/switch_tab_notification.dart';
import 'package:pendekar/screens/settings/settings_screen.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // maintain navigation history of tapped indices to support back navigation
  final List<int> _navigationHistory = [0];

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    LayananPage(),
    BeritaPage(),
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
      // push to history
      _navigationHistory.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    switch (_selectedIndex) {
      case 1:
        appBarTitle = 'Layanan Kota Madiun';
        break;
      case 2:
        appBarTitle = 'Berita & Informasi';
        break;
      default:
        appBarTitle = 'Pendekar';
    }

    return PopScope(
      canPop: _navigationHistory.length <= 1,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        // If there is navigation history, go back through it instead of exiting
        if (_navigationHistory.length > 1) {
          // remove current
          _navigationHistory.removeLast();
          final prev = _navigationHistory.last;
          setState(() => _selectedIndex = prev);
        }
      },
      child: NotificationListener<SwitchTabNotification>(
        onNotification: (notification) {
          if (notification.index != _selectedIndex) {
            setState(() {
              _selectedIndex = notification.index;
              _navigationHistory.add(notification.index);
            });
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: Text(
              appBarTitle,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                label: 'Layanan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: 'Berita',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   static String routeName = "/home";

//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: BodyV2(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getBody(),
//     );
//   }

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//     return ListView(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Padding(
//                     padding:
//                         EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 8),
//                     child: Row(
//                       children: [Text("data")],
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
