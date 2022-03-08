import 'package:flutter/material.dart';

import '../book_detail.dart';
import '../component.dart';

class SearchResultScreen extends StatefulWidget {
  final List searchData;
  const SearchResultScreen({Key? key, required this.searchData})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
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
                    context: context,
                    bookName: widget.searchData[index].nameEn.toString(),
                    bookId: widget.searchData[index].id,
                    writerName: widget.searchData[index].writerEn.toString(),
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
                  "no result found for your search",
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
