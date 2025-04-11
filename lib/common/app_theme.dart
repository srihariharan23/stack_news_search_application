/*
* Project      : stack_news_search_app
* File         : app_theme.dart
* Description  :  AppTheme defines a set of reusable styles and constants for consistent UI design across the app.  It includes padding, colors, text styles, and box decoration to maintain a unified visual theme.
* Author       : SrihariharanT
* Date         : 2025-04-11
* Version      : 1.0
* Ticket       : 
*/

import 'package:flutter/material.dart';

class AppTheme {
  static const double padding = 12.0;
  static const double radius = 12.0;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color shadowColor = Colors.black12;

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle subtitleStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey[600],
  );

  static BoxDecoration inputBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );
}

