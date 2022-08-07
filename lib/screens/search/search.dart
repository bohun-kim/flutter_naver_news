import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_news/screens/search/search_articles.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.searchData}) : super(key: key);

  final searchData;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late dynamic keyword = widget.searchData;

  // 키워드로 검색 시 네이버 뉴스 get 요청
  Future<List<dynamic>> getAllArticles() async {
    var url =
        'https://openapi.naver.com/v1/search/news.json?query=$keyword&display=100';

    var response = await http.get(Uri.parse(url), headers: {
      "X-Naver-Client-id": "eiPQaGGNRu1gByikwLGx",
      "X-Naver-Client-Secret": "PHdWqouCAN"
    });
    var jsonData = response.body;
    var parsingData = json.decode(jsonData);
    var jsonArray = parsingData['items'];

    List<SearchArticles> newsArticle = [];

    for (var jsonArticle in jsonArray) {
      SearchArticles newsHomeArticles = SearchArticles(
          originallink: jsonArticle['originallink'],
          title: jsonArticle['title'],
          link: jsonArticle['link'],
          pubDate: jsonArticle['pubDate'],
          description: jsonArticle['description']);

      newsArticle.add(newsHomeArticles);
    }

    return newsArticle;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('검색'),
          centerTitle: true,
          backgroundColor: const Color(0xFFD6D6D6),
          elevation: 0,
        ),
        body: FutureBuilder<List<dynamic>>(
            future: getAllArticles(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<dynamic> newsArticles = snapshot.data!;
                return ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    SearchArticles article = newsArticles[index];
                    return GestureDetector(
                      onTap: () async {
                        launchUrlString(article.link);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            title: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Text(article.title
                                  .replaceAll('<b>$keyword</b>', '$keyword')
                                  .replaceAll('&quot;', '')
                                  .replaceAll('&apos;', '')),
                            ),
                            subtitle: Text(article.description
                                .replaceAll('<b>$keyword</b>', '$keyword')
                                .replaceAll('&quot;', '')
                                .replaceAll('&apos;', '')),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
