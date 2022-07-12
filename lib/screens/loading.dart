import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_news/data/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import '../model/menu.dart';

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
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=kr&category=sports&apiKey=3e3d6c4106c84f27be6d9578970fc4e8'));

    String jsonData = response.body;
    var parsingData = jsonDecode(jsonData);
    print(parsingData);
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
    print(parsingData);
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
            // 상태창
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
            Container(
              padding: EdgeInsets.all(10),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('image/newspicture.jpg')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
