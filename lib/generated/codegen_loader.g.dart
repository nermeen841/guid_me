// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "Search": "بحث",
    "BestSeller": "الاكثر مبيعا",
    "Favourites": "المفضلة",
    "SETTINGS": "الاعدادات",
    "BookDetail": "تفاصيل الكتاب",
    "WroteBy": "بقلم",
    "BookAdded": "تم اضافة الكتاب للمفضلة",
    "BookRemoved": "تم ازالة الكتاب من المفضلة",
    "Pages": "الصفحات",
    "NoResult": "لايوجد نتائج لبحثك",
    "HullNumber": "القاعة",
    "Suite": "الجناح",
    "Publishing": "النشر",
    "NearBy": "دار النشر الاقرب",
    "SimilarBook": "كتب مشابهة",
    "add_favourite": "اضف كتب للمفضلة",
    "sold_out": "لقد نفذت الكمية"
  };
  static const Map<String, dynamic> en = {
    "Search": "Search",
    "BestSeller": "Best Seller",
    "BookDetail": "Book Detail",
    "Favourites": "Favourites",
    "SETTINGS": "SETTINGS",
    "WroteBy": "Wrote By",
    "Pages": "Pages",
    "HullNumber": "Hull Number",
    "BookAdded": "Book added to your favourite",
    "BookRemoved": "Book deleted from your favourite",
    "Suite": "Suite",
    "NoResult": "No result found for your search",
    "Publishing": "Publishing",
    "NearBy": "Nearby Publishing House",
    "SimilarBook": "Similar Book",
    "add_favourite": "Add books to your favourite",
    "sold_out": "Sold out "
  };

  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
