// ignore_for_file: prefer_const_constructors, unused_field, camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:pendekar/constants/constant.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20ASN/analisaberita.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/madiuntoday.dart';
import 'package:pendekar/daftarAplikasi/aplikasi%20warga/smartcity.dart';
import 'package:pendekar/homepage/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LayananBerita extends StatefulWidget {
  const LayananBerita({super.key});

  @override
  State<LayananBerita> createState() => _LayananBeritaState();
}

class _LayananBeritaState extends State<LayananBerita> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _searchText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: const [
              Colors.white,
              Colors.white,
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _tittleLayananBerita(),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Cari Aplikasi',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 20.0),
            _appLayananBerita(context),
          ],
        ),
      ),
    );
  }

  Widget _tittleLayananBerita() {
    final screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth * 0.05;
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.api),
          onPressed: () {
            // Aksi ketika tombol "arrow_back" diklik
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 12.0, left: 4.0),
        ),
        Text(
          "Layanan Informasi",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(255, 11, 11, 11),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _appLayananBerita(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      // +++++++++++++++++++++++APP layanan Publik +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      // {
      //   "icon": "assets/images/imgicon/sicaker.png",
      //   "text": "SICAKER",
      //   "page": websicaker(),
      // },
      {
        "icon": "assets/images/imgicon/ewaris.png",
        "text": "Madiuntoday",
        "page": webmadiuntoday(),
      },
      {
        "icon": "assets/images/imgicon/peceltumpang.png",
        "text": "Analisa Berita",
        "page": webanalisaberita(),
      },

      {
        "icon": "assets/images/imgicon/sipdok.png",
        "text": "SMARTCITY",
        "page": websmartcity(),
      },
      // {
      //   "icon": "assets/images/imgicon/beasiswa.png",
      //   "text": "BEASISWA MAHASISWA",
      //   "page": webbeasiswa(),
      // },
    ];

    Future<void> launchPlayStore(String appId) async {
      String playStoreUrl =
          'https://play.google.com/store/apps/details?id=$appId';
      await launch(playStoreUrl);
    }

    void openApp(String appId, String uriScheme) async {
      if (await canLaunch(uriScheme)) {
        await launch(uriScheme);
      } else {
        await launchPlayStore(appId);
      }
    }

    // Filter categories berdasarkan _searchText
    List<Map<String, dynamic>> filteredCategories = categories
        .where((category) =>
            category['text'].toString().toLowerCase().contains(_searchText))
        .toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: filteredCategories.length,
      itemBuilder: (context, index) => _berandaCard(
        icon: filteredCategories[index]["icon"],
        text: filteredCategories[index]["text"],
        press: () {
          if (filteredCategories[index].containsKey("appId") &&
              filteredCategories[index].containsKey("uriScheme")) {
            openApp(
              filteredCategories[index]["appId"],
              filteredCategories[index]["uriScheme"],
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => filteredCategories[index]["page"],
              ),
            );
          }
        },
      ),
    );
  }
}

class _berandaCard extends StatelessWidget {
  const _berandaCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.032;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: getProportionateScreenWidth(10),
        height: getProportionateScreenWidth(10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Sudut melengkung
              ),
              elevation: 5, // Bayangan untuk efek 3D
              shadowColor: Colors.black.withOpacity(1), // Warna bayangan
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                height: screenHeight * 0.08,
                width: screenWidth * 0.22,
                decoration: BoxDecoration(
                  color: hThirdColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    icon,
                    width: getProportionateScreenWidth(70),
                    height: getProportionateScreenWidth(70),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  List<Map<String, dynamic>> newsList = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    List<String> urls = [
      'https://rss.app/feeds/v1.1/rHyalNohjMNACgTx.json',
      'https://rss.app/feeds/v1.1/YEWvQYsh1VcyU0a6.json',
      'https://rss.app/feeds/v1.1/oBYCZ1GV2crnFf21.json',
    ];

    List<Map<String, dynamic>> fetchedNews = [];

    for (var url in urls) {
      try {
        var newsItems = await fetchNewsFromRss(url);
        if (newsItems != null) {
          fetchedNews.addAll(newsItems);
        }
      } catch (e) {
        print('Error fetching news from $url: $e');
      }
    }

    fetchedNews.sort((a, b) =>
        DateTime.parse(b['pubDate']).compareTo(DateTime.parse(a['pubDate'])));

    setState(() {
      newsList = fetchedNews.take(10).toList();
    });
  }

  Future<List<Map<String, dynamic>>?> fetchNewsFromRss(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> items = data['items'];

      return items.map((item) {
        return {
          'imageUrl':
              item['attachments'] != null && item['attachments'].isNotEmpty
                  ? item['attachments'][0]['url']
                  : null,
          'contentText': item['content_text'] ?? '',
          'title': item['title'] ?? 'News Post',
          'newsUrl': item['url'],
          'pubDate': item['date_published'] ?? '',
        };
      }).toList();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berita Terkini'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (news['imageUrl'] != null)
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 16.0),
                    child: Image.network(
                      news['imageUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        news['contentText'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () async {
                          final url = news['newsUrl'];
                          if (url != null &&
                              Uri.tryParse(url)?.hasAbsolutePath == true) {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Could not launch the URL.')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid URL.')),
                            );
                          }
                        },
                        child: const Text(
                          'Read more',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
