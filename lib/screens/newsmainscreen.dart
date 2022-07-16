import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_news/data/getnews.dart';
import '../model/menu.dart';

class NewsMainScreen extends StatefulWidget {
  final dynamic parseNewsData;

  const NewsMainScreen({Key? key, this.parseNewsData}) : super(key: key);

  @override
  State<NewsMainScreen> createState() => _NewsMainScreenState();
}

class _NewsMainScreenState extends State<NewsMainScreen> {
  String? title2;
  String? img2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseNewsData);
  }

  void updateData(dynamic parseNewsData) {
    title2 = parseNewsData['articles'][0]['title'];
    img2 = parseNewsData['articles'][0]['urlToImage'];
  }

  final double objInterval = 10;

  static List<String> menu = ['뉴스홈', '기업', '연예', '건강', '과학', '스포츠', '기술'];

  final List<Menu> menuData =
      List.generate(menu.length, (index) => Menu(menu[index]));

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
                onTap: (int index) async{
                },
            ),
            elevation: 0,
          ),
          backgroundColor: const Color(0xFFD6D6D6),
          body: Column(children: [
            Expanded(
              child: TabBarView(
                children: List<Widget>.generate(menu.length, (int index) {
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
                                      child: Image.network('$img2')),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text('$title2',
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
