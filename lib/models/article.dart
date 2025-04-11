/*
* Project      : stack_news_search_app
* File         : article.dart
* Description  : NewsArticle is a data model representing a news item, with fields for title, description, URL, image, publish date, and source.  It includes a factory constructor to create instances from JSON data.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

class NewsArticle {
  final String title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? sourceName;

  NewsArticle({
    required this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.sourceName,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      sourceName: json['source']?['name'],
    );
  }
}

