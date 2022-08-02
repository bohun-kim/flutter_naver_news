class SearchArticles {
  final String title;
  final dynamic originallink;
  final String link;
  final String? description;
  final String? pubDate;

  SearchArticles(
      {required this.title,
      required this.originallink,
      required this.link,
      required this.description,
      required this.pubDate});
}
