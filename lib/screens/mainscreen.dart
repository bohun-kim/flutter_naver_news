import 'package:flutter_naver_news/screens/screen/business/business.dart';
import 'package:flutter_naver_news/screens/screen/entertainment/entertainment.dart';
import 'package:flutter_naver_news/screens/screen/health/health.dart';
import 'package:flutter_naver_news/screens/screen/newshome/newshome.dart';
import 'package:flutter_naver_news/screens/screen/science/science.dart';
import 'package:flutter_naver_news/screens/screen/sports/sports.dart';
import 'package:flutter_naver_news/screens/screen/technology/technology.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_news/search/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  static List<String> menu = ['뉴스홈', '기업', '연예', '건강', '과학', '스포츠', '기술'];

  static List screen = [
    const NewsHome(),
    const Business(),
    const Entertainment(),
    const Health(),
    const Science(),
    const Sports(),
    const Technology()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menu.length,
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.white),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('오늘의 뉴스'),
            leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            actions: const [Search()],
            bottom: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(menu.length, (int index) {
                return Tab(
                  child: Text(menu[index]),
                );
              }),
            ),
            elevation: 0,
          ),
          backgroundColor: const Color(0xFFD6D6D6),
          body: TabBarView(
            children: List.generate(screen.length, (index) {
              return Stack(
                children: [
                  Container(
                    child: screen[index],
                  ),
                  Positioned(
                      child: Container(
                        height: 70,
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.orange)),
                  )),
                ],
              );
            }),
          )),
    );
  }
}
