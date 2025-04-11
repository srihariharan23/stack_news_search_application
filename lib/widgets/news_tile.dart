/*
* Project      : stack_news_search_app
* File         : news_tile.dart
* Description  : ewsTile is a reusable widget that displays a brief overview of a news article, including its image, title, source, and publish date. Tapping the tile navigates to the detailed article view using GetX routing.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../common/app_theme.dart';
import '../common/ui_helpers.dart';
import '../models/article.dart';
import '../views/details_view.dart';

class NewsTile extends StatelessWidget {
  final NewsArticle article;
  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().format(DateTime.parse(article.publishedAt ?? DateTime.now().toIso8601String()));
    final source = article.sourceName ?? 'Unknown Source';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: () => Get.to(() => NewsDetailPage(article: article)),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.padding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radius),
                child: SizedBox(
                  width: UIHelpers.screenWidth(context) * 0.25,
                  height: 80,
                  child: article.urlToImage != null
                      ? Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppTheme.lightGrey,
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
                  )
                      : Container(
                    color: AppTheme.lightGrey,
                    child: const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTheme.titleTextStyle),
                    const SizedBox(height: 6),
                    Text('$source • $date', style: AppTheme.subtitleStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




