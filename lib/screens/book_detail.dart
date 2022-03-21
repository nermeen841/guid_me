// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guid_me/DBhelper/AppCubit/appState.dart';
import 'package:guid_me/DBhelper/AppCubit/cubit.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:guid_me/screens/map/map_track.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/component.dart';
import 'package:easy_localization/easy_localization.dart';

class BookDetailScreen extends StatefulWidget {
  dynamic details;
  BookDetailScreen({Key? key, required this.details}) : super(key: key);
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
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
          LocaleKeys.BookDetail.tr(),
          style: TextStyle(
            fontSize: w * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
            color: const Color(0xff3366cc),
          ),
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
          Stack(
            children: [
              buildBookDetailCard(
                  h: h,
                  w: w,
                  context: context,
                  bookname: (lang == 'en')
                      ? widget.details.nameEn.toString()
                      : widget.details.nameAr.toString(),
                  bookId: widget.details.id,
                  price: widget.details.price.toString(),
                  image: widget.details.img.toString()),
              Align(
                alignment:
                    (lang == 'en') ? Alignment.topLeft : Alignment.topRight,
                child: BlocConsumer<DataBaseCubit, AppCubitStates>(
                    builder: (context, state) => Padding(
                          padding:
                              EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                          child: InkWell(
                            onTap: () async {
                              if (DataBaseCubit.get(context)
                                      .isfavourite[widget.details.id] ==
                                  true) {
                                DataBaseCubit.get(context)
                                    .deletaFromDB(id: widget.details.id);
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.BookRemoved.tr(),
                                    gravity: ToastGravity.TOP,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    toastLength: Toast.LENGTH_LONG);
                              } else {
                                DataBaseCubit.get(context).inserttoDatabase(
                                    booknameEn: widget.details.nameEn,
                                    bookImage: widget.details.img,
                                    booknameAr: widget.details.nameAr,
                                    writernameEn: widget.details.writerEn,
                                    price: widget.details.price,
                                    writernameAr: widget.details.writerAr,
                                    bookId: widget.details.id);
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.BookAdded.tr(),
                                    gravity: ToastGravity.TOP,
                                    textColor: Colors.white,
                                    backgroundColor: const Color(0xff3366cc),
                                    toastLength: Toast.LENGTH_LONG);
                              }
                            },
                            child: Container(
                              width: w * 0.1,
                              height: h * 0.1,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: (DataBaseCubit.get(context)
                                            .isfavourite[widget.details.id] ==
                                        true)
                                    ? Icon(
                                        Icons.favorite,
                                        size: w * 0.07,
                                        color: const Color(0xff3366cc),
                                      )
                                    : Icon(
                                        Icons.favorite_outline,
                                        size: w * 0.07,
                                        color: const Color(0xff3366cc),
                                      ),
                              ),
                            ),
                          ),
                        ),
                    listener: (context, state) {}),
              ),
            ],
          ),
          SizedBox(
            height: h * 0.01,
          ),
          buildBookDetailWriterCard(
            w: w,
            h: h,
            hallNum: widget.details.hullNum.toString(),
            pages: widget.details.pages.toString(),
            sectionNum: widget.details.sectionNum.toString(),
            sellerName: (lang == 'en')
                ? widget.details.sellerEn.toString()
                : widget.details.sellerAr.toString(),
            writerName: (lang == 'en')
                ? widget.details.writerEn.toString()
                : widget.details.writerAr.toString(),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            height: h * 0.02,
          ),
          (widget.details.darElnasher.isNotEmpty)
              ? Center(
                  child: Text(
                    LocaleKeys.NearBy.tr(),
                    style: TextStyle(
                        color: const Color(0xff3366cc),
                        fontSize: w * 0.06,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo'),
                  ),
                )
              : Container(),
          SizedBox(
            height: h * 0.02,
          ),
          (widget.details.darElnasher.isNotEmpty)
              ? ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapTrackScreen(
                              latitude: widget.details.darElnasher[index].lat,
                              logtitude: widget.details.darElnasher[index].long,
                              name: (lang == 'en')
                                  ? widget.details.darElnasher[index].nameEn
                                  : widget.details.darElnasher[index].nameAr,
                              city: (lang == 'en')
                                  ? widget.details.darElnasher[index].addressEn
                                  : widget.details.darElnasher[index].addressAr,
                            ),
                          ),
                        ),
                        child: buildPublishingHouseCard(
                          w: w,
                          h: h,
                          address: (lang == 'en')
                              ? widget.details.darElnasher[index].addressEn
                              : widget.details.darElnasher[index].addressAr,
                          // area: widget.details.darElnasher[index].area,
                          status: (lang == 'en')
                              ? widget.details.darElnasher[index].statusEn
                              : widget.details.darElnasher[index].statusAr,
                          name: (lang == 'en')
                              ? widget.details.darElnasher[index].nameEn
                              : widget.details.darElnasher[index].nameAr,
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: h * 0.025,
                      ),
                  itemCount: widget.details.darElnasher.length)
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mood_bad,
                      color: const Color.fromARGB(255, 151, 16, 6),
                      size: w * 0.1,
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      LocaleKeys.SOLDOUT.tr(),
                      style: TextStyle(
                          fontSize: w * 0.06,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 151, 16, 6)),
                    ),
                  ],
                ),
          SizedBox(
            height: h * 0.05,
          ),
          (widget.details.semellerBooks.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.only(right: w * 0.02, left: w * 0.02),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        style: TextStyle(
                            color: const Color(0xff3366cc),
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo'),
                        text: LocaleKeys.SimilarBook.tr(),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Cairo'),
                        text: '( ${widget.details.semellerBooks.length} )',
                      ),
                    ]),
                  ))
              : Container(),
          (widget.details.semellerBooks.isNotEmpty)
              ? SizedBox(
                  height: h * 0.02,
                )
              : Container(),
          (widget.details.semellerBooks.isNotEmpty)
              ? SizedBox(
                  height: h * 0.2,
                  child: ListView.builder(
                      primary: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetailScreen(
                                      details: widget
                                          .details.semellerBooks[index]))),
                          child: moreSoldCard(
                              h: h,
                              w: w,
                              lang: lang!,
                              bookNameAr: widget
                                  .details.semellerBooks[index].nameAr
                                  .toString(),
                              writerNameAr:
                                  widget.details.semellerBooks[index].writerAr,
                              image: widget.details.semellerBooks[index].img
                                  .toString(),
                              bookId: widget.details.semellerBooks[index].id,
                              price: widget.details.semellerBooks[index].price
                                  .toString(),
                              bookName: widget
                                  .details.semellerBooks[index].nameEn
                                  .toString(),
                              writerName: widget
                                  .details.semellerBooks[index].writerEn
                                  .toString()),
                        );
                      },
                      itemCount: widget.details.semellerBooks.length),
                )
              : Container(),
          SizedBox(
            height: h * 0.05,
          ),
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                  color: Color(0xff5f616e), fontSize: 25, fontFamily: 'Cairo'),
              child: AnimatedTextKit(
                isRepeatingAnimation: true,
                displayFullTextOnTap: false,
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('GUIED ME'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
        ],
      ),
    );
  }
}
