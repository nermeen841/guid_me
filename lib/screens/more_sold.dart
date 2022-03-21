// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:guid_me/model/books.dart';
import 'package:easy_localization/easy_localization.dart';
import 'book_detail.dart';
import '../constant/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreSoldScreen extends StatefulWidget {
  @override
  State<MoreSoldScreen> createState() => _MoreSoldScreenState();
}

class _MoreSoldScreenState extends State<MoreSoldScreen> {
  String? lang;
  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String language = prefs.getString('lang') ?? 'en';
    setState(() {
      lang = language;
    });
  }

  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffedeef4),
      appBar: AppBar(
        backgroundColor: const Color(0xffedeef4),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          LocaleKeys.BestSeller.tr(),
          style: TextStyle(
              fontSize: w * 0.05,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
              color: const Color(0xff3366cc)),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 35,
              ))
        ],
      ),
      body: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          SizedBox(
            width: w,
            height: h * 0.9,
            child: FutureBuilder(
                future: readJsonData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return moreSoldCard(
                              w: w,
                              h: h,
                              lang: lang!,
                              bookName:
                                  snapshot.data.data[index].nameEn.toString(),
                              bookNameAr:
                                  snapshot.data.data[index].nameAr.toString(),
                              writerName: snapshot.data.data[index].writerEn,
                              writerNameAr:
                                  snapshot.data.data[index].writerAr.toString(),
                              image: snapshot.data.data[index].img.toString(),
                              price: snapshot.data.data[index].price.toString(),
                              bookId: snapshot.data.data[index].id,
                              onPress: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookDetailScreen(
                                            details: snapshot.data.data[index],
                                          ))));
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: snapshot.data.data.length);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  BookModel? bookModel;
  readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/data/bookdata.json');
    var data = json.decode(jsondata);
    setState(() {
      bookModel = BookModel.fromJson(data);
    });
    return bookModel;
  }
}
