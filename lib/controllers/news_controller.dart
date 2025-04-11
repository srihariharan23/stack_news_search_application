/*
* Project      : stack_news_search_app
* File         : news_controller.dart
* Description  : NewsController manages the news search logic using GetX, handling data fetching, infinite scroll, loading states, and user input.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helpers.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  final searchController = TextEditingController();
  final isLoading = false.obs;
  final isMoreLoading = false.obs;
  final articles = <NewsArticle>[].obs;
  final scrollController = ScrollController();
  final _newsService = NewsService();
  RxBool hasReachedMax = false.obs;
  int page = 1;

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) return;
    try {
      isLoading.value = true;
      articles.clear();
      final results = await _newsService.fetchNews(query, page);
      articles.assignAll(results);
      hasReachedMax.value = results.length < 20;
    } catch (e) {
      UIHelpers.showSnackBar(Get.context!, 'Error $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore(String query) async {
    if (query.trim().isEmpty || isMoreLoading.value) return;

    try {
      isMoreLoading.value = true;
      page++;
      final results = await _newsService.fetchNews(query, page);
      articles.addAll(results);
      if (results.length < 20) {
        hasReachedMax.value = true;
      }
    } catch (e) {
      UIHelpers.showSnackBar(Get.context!, 'Failed to load more: $e');
    } finally {
      isMoreLoading.value = false;
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMore(searchController.text);
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}


