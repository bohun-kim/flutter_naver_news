import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

class NewsMainScreen extends StatefulWidget {
  final dynamic parseNewsData;

  const NewsMainScreen({Key? key, required this.parseNewsData})
      : super(key: key);

  @override
  State<NewsMainScreen> createState() => _NewsMainScreenState();
}

class _NewsMainScreenState extends State<NewsMainScreen> {
  String? title2;
  String? img2;

  final double objInterval = 10;

  static List<String> menu = [
    '뉴스홈', '기업'
    // , '연예', '건강', '과학', '스포츠', '기술'
  ];
  static List<Response<dynamic>> newsTitle = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsData(widget.parseNewsData);
  }

  void getNewsData(parseNewsData) {
    newsTitle = parseNewsData;
    print(parseNewsData[0]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menu.length,
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.white),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('오늘의 뉴스'),
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(menu.length, (int index) {
                return Tab(
                  child: Text(menu[index]),
                );
              }),
              onTap: (int index) async {},
            ),
            elevation: 0,
          ),
          backgroundColor: const Color(0xFFD6D6D6),
          body: Column(children: [
            Expanded(
              child: TabBarView(
                children: List<Widget>.generate(newsTitle.length, (int index) {
                  return Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: objInterval,
                        ),
                        // 메인 기사
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        newsTitle[index]
                                            .data['articles'][0]['urlToImage']
                                            .toString(),
                                      ))
                                  // Image.network('$img2')),
                                ],
                              ),
                              SizedBox(
                                height: objInterval,
                              ),
                              Text(
                                  newsTitle[index]
                                      .data['articles'][0]['title']
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                      fontSize: 15,
                                      letterSpacing: 1.5)),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          ])),
    );
  }
}
