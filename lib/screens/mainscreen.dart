import 'package:flutter_naver_news/screens/screen/business/business.dart';
import 'package:flutter_naver_news/screens/screen/entertainment/entertainment.dart';
import 'package:flutter_naver_news/screens/screen/health/health.dart';
import 'package:flutter_naver_news/screens/screen/newshome/newshome.dart';
import 'package:flutter_naver_news/screens/screen/science/science.dart';
import 'package:flutter_naver_news/screens/screen/sports/sports.dart';
import 'package:flutter_naver_news/screens/screen/technology/technology.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_news/screens/search/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  var _isToggled = false;
  TextEditingController searchController = TextEditingController();

  void searchValue(value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchPage(
                  searchData: value,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: menu.length,
      child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.white),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('스낵뉴스'),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() => {_isToggled = !_isToggled});
                },
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
              return Stack(
                children: [
                  Container(
                    child: screen[index],
                  ),
                  Positioned(
                      child: _isToggled
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 0, color: Colors.grey)),
                              child: TextField(
                                controller: searchController,
                                autofocus: true,
                                textInputAction: TextInputAction.go,
                                onSubmitted: (value) {
                                  return searchValue(value);
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '검색어를 입력하세요',
                                    contentPadding: EdgeInsets.all(15)),
                              ),
                            )
                          : Container()),
                ],
              );
            }),
          )),
    );
  }
}
