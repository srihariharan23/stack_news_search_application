/*
* Project      : stack_news_search_app
* File         : news_service.dart
* Description  :  NewsService handles API calls to fetch news articles from NewsAPI, building requests with query and pagination parameters. It parses the response into NewsArticle objects and provides detailed error handling based on HTTP status codes.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsService {
  static const String _apiKey = 'f69caa3c5951481091ae5e7ddcef25fb';
  static const String _host = 'newsapi.org';
  static const String _path = '/v2/everything';

  Future<List<NewsArticle>> fetchNews(String query, int page) async {
    final String fromDate = DateTime.now()
        .subtract(const Duration(days: 30))
        .toIso8601String()
        .split('T')
        .first;

    final uri = Uri.https(_host, _path, {
      'q': query,
      'from': fromDate,
      'sortBy': 'publishedAt',
      'pageSize': '20',
      'page': page.toString(),
      'apiKey': _apiKey,
    });

    try {
      debugPrint('Requesting: $uri');
      final response = await http.get(uri);

      debugPrint('Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final articles = json['articles'] as List;
        return articles.map((e) => NewsArticle.fromJson(e)).toList();
      } else {
        return _handleError(response);
      }
    } catch (e) {
      final cleaned = e.toString().replaceFirst('Exception: ', '');
      debugPrint('[NewsService] Exception: $cleaned');
      throw Exception(cleaned);
    }
  }

  List<NewsArticle> _handleError(http.Response response) {
    final errorBody = jsonDecode(response.body);
    final message = errorBody['message'] ?? 'Unexpected error occurred.';

    switch (response.statusCode) {
      case 400:
        throw Exception('Bad request: Please refine your search.');
      case 401:
        throw Exception('Unauthorized: Check your API key.');
      case 429:
        throw Exception('Rate limit exceeded: Try again later.');
      case 426:
        throw Exception(
          'Max results limit reached. Try changing the keyword or upgrade the plan.',
        );
      default:
        throw Exception('Error ${response.statusCode}: $message');
    }
  }
}


