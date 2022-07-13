import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Scaffold(
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
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFD6D6D6),
      body: Container(
        child: Column(
          children: [
            // 가로 리스트뷰 메뉴
            Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menu.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(primary: Colors.black),
                    child: Text(menu[index]),
                  );
                },
              ),
            ),
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
                    height: 7,
                  ),
                  Text('$title2',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          letterSpacing: 1.5)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
