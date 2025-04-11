/*
* Project      : stack_news_search_app
* File         : news_bindings.dart
* Description  :  NewsBinding lazily injects the NewsController using GetX's dependency management. It ensures the controller is created only when required, optimizing resource usage.
* Author       : SrihariharanT
* Date         : 2025-04-10
* Version      : 1.0
* Ticket       : 
*/

import 'package:get/get.dart';
import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsController());
  }
}