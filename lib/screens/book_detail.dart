// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guid_me/DBhelper/AppCubit/appState.dart';
import 'package:guid_me/DBhelper/AppCubit/cubit.dart';

import 'component.dart';

class BookDetailScreen extends StatefulWidget {
  dynamic details;
  BookDetailScreen({Key? key, required this.details}) : super(key: key);
  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
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
          'Book Detail',
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
                  bookname: widget.details.nameEn.toString(),
                  bookId: widget.details.id,
                  price: widget.details.price.toString(),
                  image: widget.details.img.toString()),
              Align(
                alignment: Alignment.topLeft,
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
                                    msg: "Book deleted from your favourite",
                                    gravity: ToastGravity.TOP,
                                    textColor: Colors.black,
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
                                    msg: "Book added to your favourite",
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
              sellerName: widget.details.sellerEn.toString(),
              writerName: widget.details.writerEn.toString()),
          SizedBox(
            height: h * 0.02,
          ),
          Center(
            child: Text(
              'Nearby Publishing House',
              style: TextStyle(
                  color: const Color(0xff3366cc),
                  fontSize: w * 0.06,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo'),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) => buildPublishingHouseCard(
                  w: w,
                  h: h,
                  address: widget.details.darElnasher[index].addressEn,
                  area: widget.details.darElnasher[index].area,
                  status: widget.details.darElnasher[index].statusEn,
                  name: widget.details.darElnasher[index].nameEn),
              separatorBuilder: (context, index) => SizedBox(
                    height: h * 0.025,
                  ),
              itemCount: widget.details.darElnasher.length),
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
                        text: 'Similar Books',
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
