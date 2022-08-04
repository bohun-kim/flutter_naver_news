import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_news/screens/search/search_articles.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.SearchData}) : super(key: key);

  final SearchData;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late dynamic keyword = widget.SearchData;

  Future<List<dynamic>> getAllArticles() async {
    var url =
        'https://openapi.naver.com/v1/search/news.json?query=$keyword&sort=sim';

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
          originallink: jsonArray[0]['originallink'],
          title: jsonArray[0]['title'],
          link: jsonArray[0]['link'],
          pubDate: jsonArray[0]['pubDate'],
          description: jsonArray[0]['description']);

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
        ),
        body: Container(
            child: FutureBuilder<List<dynamic>>(
                future: getAllArticles(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<dynamic> newsArticles = snapshot.data!;
                    return ListView(
                      children: [
                        GestureDetector(
                            onTap: () => print(newsArticles),
                            child: Card(
                              child: ListTile(title: Text('hi')),
                            ))
                      ],
                    );
                  }
                })));
  }
}
