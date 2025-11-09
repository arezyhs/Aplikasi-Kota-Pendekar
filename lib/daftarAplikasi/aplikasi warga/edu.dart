// // ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_brace_in_string_interps

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WebEdu extends StatefulWidget {
//   const WebEdu({Key? key}) : super(key: key);

//   @override
//   _WebEduState createState() => _WebEduState();
// }

// class _WebEduState extends State<WebEdu> {
//   bool isLoading = true;
//   InAppWebViewController? _webViewController;
//   final String url = 'https://edu.madiunkota.go.id/';

//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//   }

//   Future<void> requestPermissions() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.manageExternalStorage,
//       Permission.photos,
//       Permission.mediaLibrary,
//       Permission.accessMediaLocation,
//     ].request();

//     if (statuses[Permission.camera]?.isGranted == false) {
//       print('Permission to access camera is denied');
//     }
//     if (statuses[Permission.manageExternalStorage]?.isGranted == false) {
//       print('Permission to access storage is denied');
//     }
//     if (statuses[Permission.photos]?.isGranted == false) {
//       print('Permission to access photos is denied');
//     }
//     if (statuses[Permission.mediaLibrary]?.isGranted == false) {
//       print('Permission to access media library is denied');
//     }
//     if (statuses[Permission.accessMediaLocation]?.isGranted == false) {
//       print('Permission to access media location is denied');
//     }
//   }

//   Future<String> getDownloadPath() async {
//     Directory? appDocDir = await getExternalStorageDirectory();
//     if (appDocDir == null) {
//       throw Exception("External storage directory not found");
//     }
//     return appDocDir.path;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     double fontSize = screenWidth * 0.034;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: screenHeight * 0.01),
//             Expanded(
//               child: Stack(
//                 children: [
//                   InAppWebView(
//                     initialUrlRequest: URLRequest(url: Uri.parse(url)),
//                     initialOptions: InAppWebViewGroupOptions(
//                       crossPlatform: InAppWebViewOptions(
//                         clearCache: false,
//                         cacheEnabled: true,
//                         transparentBackground: true,
//                         supportZoom: true,
//                         useOnDownloadStart: true,
//                         mediaPlaybackRequiresUserGesture: false,
//                         allowFileAccessFromFileURLs: true,
//                         allowUniversalAccessFromFileURLs: true,
//                         javaScriptCanOpenWindowsAutomatically: true,
//                         javaScriptEnabled: true,
//                       ),
//                       android: AndroidInAppWebViewOptions(
//                         useHybridComposition: true,
//                         allowContentAccess: true,
//                         allowFileAccess: true,
//                       ),
//                     ),
//                     onWebViewCreated: (controller) {
//                       _webViewController = controller;
//                     },
//                     androidOnPermissionRequest:
//                         (InAppWebViewController controller, String origin,
//                             List<String> resources) async {
//                       var response = await showDialog(
//                         context: context,
//                         builder: (BuildContext context) => AlertDialog(
//                           title: Text("Permintaan Izin"),
//                           content: Text(
//                               "Ijinkan aplikasi mengakses foto dan media?"),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .pop(PermissionRequestResponseAction.GRANT);
//                               },
//                               child: Text("Izinkan Akses"),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context)
//                                     .pop(PermissionRequestResponseAction.DENY);
//                               },
//                               child: Text("Tolak Akses"),
//                             ),
//                           ],
//                         ),
//                       );

//                       return PermissionRequestResponse(
//                           resources: resources,
//                           action: PermissionRequestResponseAction.GRANT);
//                     },
//                     // Event lainnya di sini
//                     onDownloadStart: (controller, url) async {
//                       try {
//                         String savedDir = await getDownloadPath();
//                         final myDir = Directory(savedDir);
//                         print("onDownload ${url}\n ${myDir.path}");

//                         if (!await myDir.exists()) {
//                           await myDir.create(recursive: true);
//                         }

//                         await FlutterDownloader.enqueue(
//                           url: url.toString(),
//                           savedDir: savedDir,
//                           showNotification: true,
//                           openFileFromNotification: true,
//                         );
//                       } catch (e) {
//                         print('Error downloading file: $e');
//                       }
//                     },
//                     onLoadStop: (controller, url) async {
//                       setState(() {
//                         isLoading = false;
//                       });
//                     },
//                     onLoadStart: (controller, url) {
//                       setState(() {
//                         isLoading = true;
//                       });
//                     },
//                   ),
//                   if (isLoading)
//                     Center(
//                       child: CircularProgressIndicator(
//                         color: const Color.fromARGB(255, 6, 97, 94),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Tooltip(
//                   message: 'Kembali Ke Menu',
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 6, 97, 94),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: Column(
//                       children: [
//                         Icon(Icons.home, color: Colors.white),
//                         Text(
//                           'Kembali Ke Menu',
//                           style: TextStyle(
//                             fontSize: fontSize,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.01),
//                 Tooltip(
//                   message: 'Muat Ulang',
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_webViewController != null) {
//                         _webViewController?.reload();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 6, 97, 94),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: Column(
//                       children: [
//                         Icon(Icons.refresh, color: Colors.white),
//                         Text(
//                           'Muat Ulang',
//                           style: TextStyle(
//                             fontSize: fontSize,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.01),
//                 Tooltip(
//                   message: 'Sebelumnya',
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_webViewController != null) {
//                         _webViewController?.goBack();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 6, 97, 94),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       elevation: 2,
//                     ),
//                     child: Column(
//                       children: [
//                         Icon(Icons.arrow_back, color: Colors.white),
//                         Text(
//                           'Sebelumnya',
//                           style: TextStyle(
//                             fontSize: fontSize,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
