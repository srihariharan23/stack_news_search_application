/*
* Project      : stack_news_search_app
* File         : home_views.dart
* Description  : HomeView is the main screen of the news app built with GetX, featuring a search bar, a search button, and a list of news articles with pull-to-refresh and infinite scroll support.  It uses reactive state management to display loading indicators, results, or messages based on the search status.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_theme.dart';
import '../common/ui_helpers.dart';
import '../controllers/news_controller.dart';
import '../widgets/news_tile.dart';

class HomeView extends GetView<NewsController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack News App'),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.padding),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: AppTheme.inputBoxDecoration,
                      child: TextField(
                        controller: controller.searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search for news...',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      final query = controller.searchController.text.trim();
                      if (query.isNotEmpty) {
                        controller.page = 1;
                        controller.hasReachedMax.value = false;
                        controller.searchNews(query);
                      } else {
                        controller.articles.clear();
                        UIHelpers.showSnackBar(context, 'Please type something to search');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 2,
                    ),
                    child: const Text('Search', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.padding),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value && controller.articles.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.articles.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        controller.page = 1;
                        controller.hasReachedMax.value = false;
                        await controller.searchNews(controller.searchController.text);
                      },
                      child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.articles.length + 1,
                        itemBuilder: (context, index) {
                          if (index < controller.articles.length) {
                            return NewsTile(article: controller.articles[index]);
                          } else {
                            return Obx(() => controller.hasReachedMax.value
                                ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: Text("You've reached the end.")),
                            )
                                : controller.isMoreLoading.value
                                ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                                : const SizedBox());
                          }
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






