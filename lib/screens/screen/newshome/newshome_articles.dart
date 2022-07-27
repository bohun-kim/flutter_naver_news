class NewsHomeArticles {
  final String? urlToImage;
  final String title;
  final String? author;
  final String publishedAt;
  final String? description;
  final dynamic url;

  NewsHomeArticles(
      {required this.urlToImage,
      required this.title,
      required this.author,
      required this.publishedAt,
      required this.description,
      required this.url});
}
