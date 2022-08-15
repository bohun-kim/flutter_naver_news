# Snack News

<br>

매일 새로운 뉴스와 직접 검색하여 원하는 뉴스를 검색할 수 있는 앱 입니다.

<br>

![](https://velog.velcdn.com/images/ant0410/post/63d07547-1b52-4279-8eb9-4a51f1da8c8f/image.gif)

[앱 구경하기](![](https://velog.velcdn.com/images/ant0410/post/1cbf59bc-f9b8-4ba7-84b9-295f0fd1fe9c/image.apk)
)

<br>

## ⭐ ️목표

### API를 활용한 국내 뉴스 자료 제공

- API 를 활용한 정보제공
- Flutter 위젯을 이용한 화면구성

<br>

## 🧰 사용기술

- Flutter, dart
- News API (분야별 뉴스 결과)
- 네이버 뉴스 API (네이버 검색결과)
- http
- url_launcher

<br>

## 📅 소요기간

- 1일

<br>

## 👀 주요기능 & 부분 코드

```
💡 주요기능

- 기업,연예,건강,과학,스포츠,기술 분야별로 뉴스 데이터 정보 제공
- 네이버 뉴스 api 를 활요한 검색창 구현
```

<br>

파일 구조는 아래와 같습니다.

<br>

![](https://velog.velcdn.com/images/ant0410/post/7f46fccb-f6d3-4b6e-b9b7-af0799b5f462/image.png)

<br>

## 1. 기업,연예,건강,과학,스포츠,기술 분야별로 뉴스 데이터 정보 제공

<br>

### 💻 코드살펴보기 (분야별 뉴스)

<br>

> News API를 통하여 국내 뉴스를 제공하고 있습니다.

<br>

![](https://velog.velcdn.com/images/ant0410/post/53700607-b965-4843-9c90-da7036cb84c4/image.gif)

<br>

### 📂 lib>screens>newshome.dart

#### 1. 뉴스 api 불러오기

먼저 http 라이브러리를 이용하여 api 데이터를 불러온 후 dart의 convert에 내장되어있는 json.decode() 를 이용하여 json 데이터를 파싱합니다.

그 후 for 반복문을 이용하여 api 데이터중 원하는 데이터를 미리 만들어둔 NewsHomeArticles 클래스 멤버변수에 저장하고, 저장된 변수들을 다시 newsArticle
배열에 저장합니다.

그리고 newsArticle 배열을 return 시킵니다.

<br>

```
// 네트워크 불러오기
Future<List<dynamic>> getAllArticles() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=kr&apiKey=Bo-hoon apikey';

    final response = await http.get(Uri.parse(url));
    final jsonData = response.body;
    final parsingData = json.decode(jsonData);
    final jsonArray = parsingData['articles'];

    List<NewsHomeArticles> newsArticle = [];

    for (var jsonArticle in jsonArray) {
      NewsHomeArticles newsHomeArticles = NewsHomeArticles(
        title: jsonArticle['title'],
        author: jsonArticle['author'],
        publishedAt: jsonArticle['publishedAt'],
        urlToImage: jsonArticle['urlToImage'],
        url: jsonArticle['url'],
        description: jsonArticle['description'],
      );

      newsArticle.add(newsHomeArticles);
    }
    return newsArticle;
  }
```

<br>

## 2. 네이버 뉴스 api 를 활요한 검색창 구현

### 💻 코드살펴보기 (검색기능 구현)

<br>

> Naver Open API를 통하여 검색 결과를 가져옵니다.

<br>

![](https://velog.velcdn.com/images/ant0410/post/9071acc3-3d56-491c-8f6f-ac6bbdab6dfb/image.gif)

### 📂 lib>search>search.dart

2-1) 검색버튼 구현

먼저 mainscreen.dart 의 appBar 에서 action 위젯을 이용하여 버튼을 만들어준 후 버튼을 누르면
_isToggled 변수의 값이 true,false 로 변경되는 토글 스위치를 만들어줍니다.

```
var _isToggled = false;

AppBar(
  actions: [
   IconButton(
     onPressed: () {
       setState(() => {_isToggled = !_isToggled});
     },
     icon: const Icon(Icons.search),
   )
 ],  
)         
```
<br/>

2-2) 검색버튼 클릭 시 검색창 구현

삼항연산자를 통해 버튼 클릭시 _isToggled 가 false 일 때와 true 일 때 별로 화면을 만들어주고, searchValue 함수 인자값으로 텍스트 필드값을 넣어줍니다.

이 때 텍스트필드 확인버튼 클릭시 searchValue 함수는 Search 위젯 페이지로 텍스트필드 값과 함께 넘어갑니다.

<br/>

```
// 편집가능한 TextField 생성
TextEditingController searchController = TextEditingController();

// Search 페이지로 넘어가는 함수
void searchValue(value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Search(
                  searchData: value,
                )));
  }

Scaffold(
Positioned(
  child: _isToggled
    ? Container(
       decoration: 
       BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0, color: Colors.grey)),
          child: TextField(
             controller: searchController,
             autofocus: true,
             textInputAction: TextInputAction.go,
             // 텍스트필드 값을 searchValue 함수 인자값으로 넣어준다.
             onSubmitted: (value) {
                 return searchValue(value);
               },
             decoration: const InputDecoration(
                 border: InputBorder.none,
                 hintText: '검색어를 입력하세요',
                 contentPadding: EdgeInsets.all(15)),
               ),
             )
    : Container())  
)
```

<br/>

2-3) Search 페이지 화면 구성하기

넘어온 텍스트필드 값은 searchData 멤버변수 값에 저장되고, 네이버 api 를 통해 데이터를 불러옵니다. 이 때 keyword 변수에 텍스트필드 값을 저장해준 뒤 네이버 api query 부분에 keyword 변수를 넣어주면 검색 keyword 와 연관된 검색결과가 나옵니다.

```

class Search extends StatefulWidget {
  const Search({Key? key, required this.searchData}) : super(key: key);

  final searchData;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchPageState extends State<SearchPage> {
 late dynamic keyword = widget.searchData;

 // 키워드로 검색 시 네이버 뉴스 get 요청
  Future<List<dynamic>> getAllArticles() async {
    var url =
        'https://openapi.naver.com/v1/search/news.json?query=$keyword&display=100';

    var response = await http.get(Uri.parse(url), headers: {
      "X-Naver-Client-id": "Naver-id",
      "X-Naver-Client-Secret": "Naver-secret"
    });
    var jsonData = response.body;
    var parsingData = json.decode(jsonData);
    var jsonArray = parsingData['items'];

    List<SearchArticles> newsArticle = [];

    for (var jsonArticle in jsonArray) {
      SearchArticles newsHomeArticles = SearchArticles(
          originallink: jsonArticle['originallink'],
          title: jsonArticle['title'],
          link: jsonArticle['link'],
          pubDate: jsonArticle['pubDate'],
          description: jsonArticle['description']);

      newsArticle.add(newsHomeArticles);
   }

     return newsArticle;
   }
   
   '
   '
   '
  
   Widget build(BuildContext context) {
     return Scaffold()
   }
 }
```

<br/>

# 👋 마무리 소감

> 플러터 학습 이후 스스로 처음 만들어본 앱이였다.
>
> 직접 프로젝트를 진행해보면서 API 데이터 가공법, 라이브러리 사용을 해보며 막연한 두려움을 없앨 수 있었고 Flutter 화면 구성을 위한 검색을 통한 여러가지 위젯 사용, 공공데이터 API 사용법까지 해보며 전체적인 흐름을 이해하는데 많은 도움이 됐다.
> 
> 추후 프로젝트를 진행한다면 현재 코드들이 복잡하다고 느껴 GetX 를 사용해보고싶고, 눈에 뚜렷이 보이는 데이터 시각화를 도입해보고 싶다.

