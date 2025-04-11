/*
* Project      : stack_news_search_app
* File         : ui_helpers.dart
* Description  : UIHelpers provides utility methods for screen dimensions and displaying SnackBars using context-based MediaQuery and ScaffoldMessenger.
* Author       : SrihariharanT
* Date         : 2025-04-11
* Version      : 1.0
* Ticket       : 
*/

import 'package:flutter/material.dart';

class UIHelpers {
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}