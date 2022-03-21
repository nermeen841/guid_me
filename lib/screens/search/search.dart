import 'package:flutter/material.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../book_detail.dart';
import '../../constant/component.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchResultScreen extends StatefulWidget {
  final List searchData;
  const SearchResultScreen({Key? key, required this.searchData})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
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
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: double.infinity,
      height: h * 0.6,
      child: (widget.searchData.isNotEmpty)
          ? ListView.separated(
              primary: true,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return searchCard(
                    w: w,
                    h: h,
                    lang: lang.toString(),
                    context: context,
                    bookName: widget.searchData[index].nameEn.toString(),
                    bookNameAr: widget.searchData[index].nameAr.toString(),
                    bookId: widget.searchData[index].id,
                    writerName: widget.searchData[index].writerEn.toString(),
                    writerNameAr: widget.searchData[index].writerAr.toString(),
                    image: widget.searchData[index].img.toString(),
                    price: widget.searchData[index].price.toString(),
                    onPress: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookDetailScreen(
                                  details: widget.searchData[index],
                                ))));
              },
              separatorBuilder: (context, index) => SizedBox(
                    height: h * 0.03,
                  ),
              itemCount: widget.searchData.length)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/nosearch.webp",
                  width: w * 0.4,
                  height: h * 0.4,
                  fit: BoxFit.contain,
                ),
                Text(
                  LocaleKeys.NoResult.tr(),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: w * 0.05,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff3366cc),
                  ),
                ),
              ],
            ),
    );
  }
}
