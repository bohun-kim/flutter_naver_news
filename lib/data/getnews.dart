import 'dart:convert';
import 'package:http/http.dart' as http;

class GetNews{
  final String url;
  final String url2;

  GetNews(this.url, this.url2);

  // url을 통해서 넘어온 뉴스 데이터 타입은 다양하기 때문에 dynamic 타입이다.
  Future<dynamic> getNewsData() async {

    // http.Response response = await http.get(Uri.parse(url));

    var responses = await Future.wait([
      http.get(Uri.parse(url)),
      http.get(Uri.parse(url2)),
    ]);

    // String jsonData = response.body;
    // var parsingData = jsonDecode(jsonData);

    var response1 = responses.first;
    print(response1);
    // return parsingData;
  }
}

