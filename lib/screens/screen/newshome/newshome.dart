import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_naver_news/screens/screen/newshome/failure.dart';
import 'package:flutter_naver_news/screens/screen/newshome/newshome_articles.dart';
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

    final response = await http.get(Uri.parse(url));
    final jsonData = response.body;
    final parsingData = json.decode(jsonData);
    final jsonArray = parsingData['articles'];

    List<NewsHomeArticles> newsArticle = [];

    for (var jsonArticle in jsonArray) {
      NewsHomeArticles newsHomeArticles = NewsHomeArticles(
        title: jsonArticle['title'],
        author: jsonArticle['author'],
        publishedAt: jsonArticle['publishedAt'],
        urlToImage: jsonArticle['urlToImage'],
        url: jsonArticle['url'],
        description: jsonArticle['description'],
      );

      newsArticle.add(newsHomeArticles);
    }
    return newsArticle;
  }

  // 리스트 카드 클릭시 팝업 창
  showPopup(context, title, author, publishedAt, urlToImage, description, url) {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Dialog(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    //뉴스 제목,작가,날짜,사진
                    Column(
                      children: [
                        // 뉴스 제목
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // 작가,날짜
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(author ?? '',
                                  style: const TextStyle(color: Colors.grey)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(publishedAt,
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // 뉴스 사진
                        Image.network(urlToImage ??
                            'https://ygx.co.kr/wp/wp-content/themes/ygx-190327/resources/imgs/p-ygxa@2x.png'),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    // 뉴스 본문
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          description ?? '',
                          style: const TextStyle(wordSpacing: 1.5, height: 2),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                launchUrlString('$url');
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              child: const Text(
                                '내용 더 보기',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )
                  ],
                ),
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
                        article.publishedAt,
                        article.urlToImage,
                        article.description?.replaceAll('&quot;', ''),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(article
                                                  .urlToImage ??
                                              'https://ygx.co.kr/wp/wp-content/themes/ygx-190327/resources/imgs/p-ygxa@2x.png'))
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
