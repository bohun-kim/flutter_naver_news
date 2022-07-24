import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_news/screens/screen/newshome_articles/newshome.dart';
import 'package:flutter_naver_news/screens/screen/business.dart';

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

  static List<String> menu = [
    '뉴스홈', '기업'
    // , '연예', '건강', '과학', '스포츠', '기술'
  ];

  static List screen = [const NewsHome(), const Business()];

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
            ),
            elevation: 0,
          ),
          backgroundColor: const Color(0xFFD6D6D6),
          body: TabBarView(
            children: List.generate(screen.length, (index) {
              return Container(
                child: screen[index],
              );
            }),
          )),
    );
  }
}
