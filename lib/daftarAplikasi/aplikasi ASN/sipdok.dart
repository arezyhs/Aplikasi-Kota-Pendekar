// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// class websipdok extends StatefulWidget {
//   const websipdok({Key? key}) : super(key: key);

//   @override
//   _websipdokState createState() => _websipdokState();
// }

// class _websipdokState extends State<websipdok> {
//   bool isLoading = true;
//   InAppWebViewController? _webViewController;
//   final String url = 'https://sipdok.madiunkota.go.id/';

//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//   }

//   @override
									// InAppWebView(
									// 	initialUrlRequest: URLRequest(url: WebUri(url)),
									// 	initialSettings: InAppWebViewSettings(
									// 		clearCache: false,
									// 		cacheEnabled: true,
									// 		transparentBackground: true,
									// 		supportZoom: true,
									// 		useOnDownloadStart: true,
									// 		mediaPlaybackRequiresUserGesture: false,
									// 		allowFileAccessFromFileURLs: true,
									// 		allowUniversalAccessFromFileURLs: true,
									// 		javaScriptCanOpenWindowsAutomatically: true,
									// 		javaScriptEnabled: true,
									// 	),
									// 	onWebViewCreated: (controller) {
									// 		_webViewController = controller;
									// 	},
									// 	onPermissionRequest: (InAppWebViewController controller,
									// 			PermissionRequest request) async {
									// 		final granted = await showDialog<bool>(
									// 			context: context,
									// 			builder: (BuildContext context) => AlertDialog(
									// 				title: Text("Permintaan Izin"),
									// 				content: Text(
									// 					"Ijinkan aplikasi mengakses foto dan media?"),
									// 				actions: <Widget>[
									// 					TextButton(
									// 						onPressed: () {
									// 						Navigator.of(context).pop(true);
									// 					},
									// 						child: Text("Izinkan Akses"),
									// 					),
									// 					TextButton(
									// 						onPressed: () {
									// 						Navigator.of(context).pop(false);
									// 					},
									// 						child: Text("Tolak Akses"),
									// 					),
									// 				],
									// 			),
									// 		);
									// 
									// 		final allow = granted ?? false;
									// 		return PermissionResponse(
									// 			resources: request.resources,
									// 			action: allow
									// 				? PermissionResponseAction.GRANT
									// 				: PermissionResponseAction.DENY,
									// 		);
									// 	},
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
//                     onLoadStop: (controller, url) async {
//                       setState(() {
//                         isLoading = false;
//                       });
//                       // Menggunakan JavaScript untuk menyembunyikan elemen yang tidak diinginkan
//                       //           controller.evaluateJavascript(source: '''
//                       //             var element = document.getElementsByClassName('navbar')[0];
//                       //   if (element != null) {
//                       //     element.style.display = 'none';
//                       //   }
//                       //    var sideMenu = document.getElementsByClassName('toolbar')[0];
//                       //   if (sideMenu != null) {
//                       //     sideMenu.style.display = 'none';
//                       //   }
//                       //   var header = document.getElementsByClassName('account-masthead')[0];
//                       //   if (header != null) {
//                       //     header.style.display = 'none';
//                       //   }
//                       //   var footer = document.getElementsByClassName('footer pt-5')[0];
//                       //   if (footer != null) {
//                       //     footer.style.display = 'none';
//                       //   }
//                       //   var second = document.getElementsByClassName('secondary col-md-3')[0];
//                       //   if (second != null) {
//                       //     second.style.display = 'none';
//                       //   }

//                       // ''');
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
