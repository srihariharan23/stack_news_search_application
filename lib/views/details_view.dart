/*
* Project      : stack_news_search_app
* File         : details_view.dart
* Description  : NewsDetailPage is a stateless widget that displays detailed information about a selected news article, including image, title, date, and description.  It also provides a button to open the full article in a browser, handling URL validation and errors gracefully.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/app_theme.dart';
import '../common/ui_helpers.dart';
import '../models/article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final width = UIHelpers.screenWidth(context);
    final height = UIHelpers.screenHeight(context);
    final publishedDate = article.publishedAt?.split('T').first ?? 'Unknown date';

    return Scaffold(
      appBar: AppBar(title: Text(article.sourceName ?? 'Article'

      ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radius),
              child: Image.network(
                article.urlToImage ?? '',
                width: width,
                height: height * 0.25,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: width,
                  height: height * 0.25,
                  color: AppTheme.lightGrey,
                  child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(publishedDate, style: AppTheme.subtitleStyle.copyWith(fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            Text(article.description ?? 'No description available.', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            if (article.url != null)
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_browser, color: Colors.white),
                  label: const Text("Read Full Article", style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    final url = article.url!;
                    try {
                      final uri = Uri.tryParse(url);
                      if (uri != null && await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.platformDefault);
                      } else if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https')) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Invalid or unsupported URL';
                      }
                    } catch (e) {
                      UIHelpers.showSnackBar(Get.context!, "Could not open the article.\n${e.toString()}");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radius)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

