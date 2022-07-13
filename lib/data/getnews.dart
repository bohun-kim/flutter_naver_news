import 'dart:convert';
import 'package:http/http.dart' as http;

class GetNews{
  final String url;

  GetNews(this.url);

  // url을 통해서 넘어온 뉴스 데이터 타입은 다양하기 때문에 dynamic 타입이다.
  Future<dynamic> getNewsData() async {
    http.Response response = await http.get(Uri.parse(
        url));
    String jsonData = response.body;
    var parsingData = jsonDecode(jsonData);
    return parsingData;
  }
}

