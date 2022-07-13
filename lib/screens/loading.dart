import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_news/data/getnews.dart';
import 'package:flutter_naver_news/screens/newsmainscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
    getNaver();
  }

  Future<void> getNews() async {
    GetNews getNews = GetNews(
        'https://newsapi.org/v2/top-headlines?country=kr&apiKey=3e3d6c4106c84f27be6d9578970fc4e8');

    var newsData = await getNews.getNewsData();
    // print(newsData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsMainScreen(parseNewsData: newsData);
    }));
  }

  Future<void> getNaver() async {
    http.Response response = await http.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/news.json?query=사회&sort=sim'),
        headers: {
          "X-Naver-Client-Id": "eiPQaGGNRu1gByikwLGx",
          "X-Naver-Client-Secret": "PHdWqouCAN"
        });

    String jsonData = response.body;
    var parsingData = jsonDecode(jsonData);
    // print(parsingData);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('로딩중...')),
    );
  }
}
