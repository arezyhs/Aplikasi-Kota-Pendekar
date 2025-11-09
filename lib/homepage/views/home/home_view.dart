import 'package:flutter/material.dart';
import 'package:pendekar/homepage/views/components/body_v2.dart';
import 'package:pendekar/homepage/menu/berita.dart';
import 'package:pendekar/homepage/views/components/Screen_aplikasi _lainya.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    BodyV2(),
    LayananPage(),
    BeritaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
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
