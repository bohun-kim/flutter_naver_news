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

## 🧰 사용기술

- Flutter, dart
- News API (분야별 뉴스 결과)
- 네이버 뉴스 API (네이버 검색결과)
- http
- url_launcher
 
## 📅 소요기간

- 2일

## 👀 주요기능 & 부분 코드

```
💡 주요기능

- 기업,연예,건강,과학,스포츠,기술 분야별로 뉴스 데이터 정보 제공
- 네이버 뉴스 api 를 활요한 검색창 구현
- Flutter 위젯 (ListView,TabBarView 등) 을 활용한 화면구성
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

### 📂 server>Router>KoreaAllRoute.js