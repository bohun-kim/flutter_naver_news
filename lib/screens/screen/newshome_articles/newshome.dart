import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_news/screens/screen/newshome_articles/newshome_articles.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class NewsHome extends StatefulWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  // 네트워크 불러오기
  Future<List<dynamic>> getAllArticles() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=kr&apiKey=74ad5f4d1a52466cbdbc4486848e5a36';

    var response = await http.get(Uri.parse(url));
    var jsonData = response.body;
    var parsingData = json.decode(jsonData);
    var jsonArray = parsingData['articles'];

    List<NewsHomeArticles> newsArticle = [];

    for (var jsonArticle in jsonArray) {
      NewsHomeArticles newsHomeArticles = NewsHomeArticles(
        title: jsonArticle['title'],
        author: jsonArticle['author'],
        urlToImage: jsonArticle['urlToImage'],
        url: jsonArticle['url'],
        description: jsonArticle['description'],
      );

      newsArticle.add(newsHomeArticles);
    }
    return newsArticle;
  }

  // 리스트 카드 클릭시 팝업 창
  showPopup(context, title, author, urlToImage, description, url) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white24),
              child: Column(
                children: [
                  Text(title),
                  Text(urlToImage),
                  Text(description),
                  Text(author ?? '작가 없음'),
                  ElevatedButton(
                      onPressed: () async {
                        launchUrlString('$url');
                      },
                      child: const Text('link'))
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllArticles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
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
                  NewsHomeArticles article = newsArticles[index];
                  return GestureDetector(
                    // 리스트 카드 클릭 시 데이터 api 데이터 전달
                    onTap: () => showPopup(
                        context,
                        article.title,
                        article.author,
                        article.urlToImage,
                        article.description,
                        article.url),
                    // 기사 하나의 컨테이너
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 기사 사진
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child:
                                            Image.network(article.urlToImage),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // 기사 제목
                                  Text(article.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        height: 1.5,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
        });
  }
}