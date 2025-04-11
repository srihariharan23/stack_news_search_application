import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stack_news_search_app/views/home_views.dart';
import 'bindings/news_bindings.dart';
import 'controllers/news_controller.dart';

void main() {
  Get.put(NewsController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialBinding: NewsBinding(),
    home: HomeView(),
  ));
}

