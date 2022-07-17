import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class GetNews {
  final String newsHome;
  final String business;
  final String entertainment;
  final String health;
  final String science;
  final String sports;
  final String technology;

  GetNews(this.newsHome, this.business, this.entertainment, this.health,
      this.science, this.sports, this.technology);

  Future<dynamic> requestUrl() async {
    List<Response> response;
    var dio = Dio();

    response = await Future.wait([
      dio.get(newsHome),
      dio.get(business),
      // dio.get(entertainment),
      // dio.get(health),
      // dio.get(science),
      // dio.get(sports),
      // dio.get(technology),
    ]);

    // print(response[0].data['articles'][0]['title']);

    return response;
  }

// Future<List> getNewsData() async {
//   List<Response> response;
//   var dio = Dio();
//   response = await Future.wait([
//     dio.get(newsHome),
//     // dio.get(business),
//     // dio.get(entertainment),
//     // dio.get(health),
//     // dio.get(science),
//     // dio.get(sports),
//     // dio.get(technology),
//   ]);
//   // print(response[6]);
//   print(response[0]);
//   return response;
// }

// // url을 통해서 넘어온 뉴스 데이터 타입은 다양하기 때문에 dynamic 타입이다.
//
//   Future<dynamic> getNewsHome() async {
//     http.Response response = await http.get(Uri.parse(newsHome));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getBusiness() async {
//     http.Response response = await http.get(Uri.parse(business));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getEntertainment() async {
//     http.Response response = await http.get(Uri.parse(entertainment));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getHealth() async {
//     http.Response response = await http.get(Uri.parse(health));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getScience() async {
//     http.Response response = await http.get(Uri.parse(science));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getSports() async {
//     http.Response response = await http.get(Uri.parse(sports));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
//
//   Future<dynamic> getTechnology() async {
//     http.Response response = await http.get(Uri.parse(technology));
//
//     String jsonData = response.body;
//     var parsingData = jsonDecode(jsonData);
//
//     // print(parsingData);
//     return parsingData;
//   }
}
