import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guid_me/DBhelper/AppCubit/appState.dart';
import 'package:guid_me/DBhelper/AppCubit/cubit.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../screens/full_image.dart';

Widget buildBookDetailCard(
        {required double h,
        required double w,
        required String bookname,
        required String price,
        required int bookId,
        required context,
        required String image}) =>
    InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullImageScreen(image: image))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: h * 0.05),
        height: h * 0.33,
        width: w,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: h * 0.009, horizontal: w * 0.02),
                  decoration: BoxDecoration(
                    color: const Color(0xff3366cc),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      price,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Cairo',
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: h * 0.009, horizontal: w * 0.02),
                  decoration: BoxDecoration(
                    color: const Color(0xff3366cc),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: w * 0.3,
                      child: Text(
                        bookname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget buildBookDetailWriterCard(
        {required double h,
        required double w,
        required String writerName,
        required String pages,
        required String sellerName,
        required String hallNum,
        required String sectionNum}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: h * 0.05),
      padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.03),
      width: w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBookDetailWriterRow(
              h: h,
              w: w,
              icon: Icons.person_outline,
              title: '${LocaleKeys.WroteBy.tr()}: ',
              text: writerName),
          buildBookDetailWriterRow(
              h: h,
              w: w,
              icon: Icons.my_library_books,
              title: '${LocaleKeys.Pages.tr()}: ',
              text: pages),
          buildBookDetailWriterRow(
              h: h,
              w: w,
              icon: Icons.local_library_outlined,
              title: '${LocaleKeys.HullNumber.tr()}: ',
              text: hallNum),
          buildBookDetailWriterRow(
              h: h,
              w: w,
              icon: Icons.person_outline,
              title: '${LocaleKeys.Suite.tr()}: ',
              text: sectionNum),
          buildBookDetailWriterRow(
              h: h,
              w: w,
              icon: Icons.public_outlined,
              title: '${LocaleKeys.Publishing.tr()}: ',
              text: sellerName),
        ],
      ),
    );

Widget buildPublishingHouseCard(
        {required double h,
        required double w,
        required String name,
        // required String area,
        required String status,
        required String address}) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: h * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: h * 0.06,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff3366cc),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  status,
                  style:
                      const TextStyle(fontFamily: 'Cairo', color: Colors.white),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.menu_book_outlined,
                    color: Colors.white,
                    size: w * 0.06,
                  ),
                  radius: w * 0.055,
                  backgroundColor: const Color(0xff3366cc),
                ),
                SizedBox(
                  width: w * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: w * 0.6,
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color(0xff3366cc),
                            fontFamily: 'Cairo',
                            fontSize: w * 0.045,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: w * 0.05,
                          color: Colors.teal.shade300,
                        ),
                        Text(
                          address,
                          style: TextStyle(
                              color: Colors.teal.shade300,
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Cairo'),
                        ),
                        SizedBox(
                          width: w * 0.2,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Text('')
        ],
      ),
    );

Widget buildBookDetailWriterRow({
  required double h,
  required double w,
  required IconData icon,
  required String title,
  required String text,
}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xff3366cc),
          size: 25,
        ),
        SizedBox(
          width: w * 0.01,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black38,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: w * 0.01,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black54,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
/////////////////////////////////////////////////////////////////////////////////

favouriteCard(
    {required double h,
    required double w,
    GestureTapCallback? onPress,
    required String bookName,
    required String writerName,
    required String image,
    required context,
    required String lang,
    required String price,
    required int bookId}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: h * 0.2,
      margin: EdgeInsets.symmetric(horizontal: w * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.05),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 3)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: w * 0.27,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: (lang == 'en')
                  ? BorderRadius.only(
                      topLeft: Radius.circular(w * 0.05),
                      bottomLeft: Radius.circular(w * 0.05))
                  : BorderRadius.only(
                      topRight: Radius.circular(w * 0.05),
                      bottomRight: Radius.circular(w * 0.05)),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w * 0.02,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: w * 0.5,
                        child: Text(
                          bookName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: w * 0.07,
                  ),
                  InkWell(
                    onTap: () async {
                      if (DataBaseCubit.get(context).isfavourite[bookId] ==
                          true) {
                        DataBaseCubit.get(context).deletaFromDB(id: bookId);
                        Fluttertoast.showToast(
                            msg: LocaleKeys.BookRemoved.tr(),
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: Colors.red,
                            toastLength: Toast.LENGTH_LONG);
                      } else {
                        DataBaseCubit.get(context).inserttoDatabase(
                            booknameEn: bookName,
                            bookImage: image,
                            booknameAr: "",
                            writernameEn: writerName,
                            price: price,
                            writernameAr: "",
                            bookId: bookId);
                        Fluttertoast.showToast(
                            msg: LocaleKeys.BookAdded.tr(),
                            gravity: ToastGravity.TOP,
                            textColor: Colors.white,
                            backgroundColor: const Color(0xff3366cc),
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                    child: Container(
                      width: w * 0.09,
                      height: h * 0.09,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              color: Color(0xffedeef4),
                              spreadRadius: 3,
                              blurRadius: 3)
                        ],
                      ),
                      child: Center(
                        child:
                            (DataBaseCubit.get(context).isfavourite[bookId] ==
                                    true)
                                ? Icon(
                                    Icons.favorite,
                                    size: w * 0.05,
                                    color: const Color(0xff3366cc),
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    size: w * 0.05,
                                    color: const Color(0xff3366cc),
                                  ),
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(
              //   height: h * 0.035,
              // ),
              Text(
                writerName,
                style: const TextStyle(
                    color: Colors.red,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 15),
              ),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
      ),
    ),
  );
}
/////////////////////////////////////////////////////////////////////////

moreSoldCard(
    {required double h,
    required double w,
    GestureTapCallback? onPress,
    required String bookName,
    required String bookNameAr,
    required String writerNameAr,
    required String writerName,
    required String price,
    required int bookId,
    required String lang,
    required String image}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: h * 0.2,
      margin: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.05),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 3)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: w * 0.27,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: (lang == 'en')
                  ? BorderRadius.only(
                      topLeft: Radius.circular(w * 0.05),
                      bottomLeft: Radius.circular(w * 0.05))
                  : BorderRadius.only(
                      topRight: Radius.circular(w * 0.05),
                      bottomRight: Radius.circular(w * 0.05)),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w * 0.02,
              ),
              SizedBox(
                height: h * 0.015,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: w * 0.5,
                        child: (lang == 'en')
                            ? Text(
                                bookName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                bookNameAr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      BlocConsumer<DataBaseCubit, AppCubitStates>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                if (DataBaseCubit.get(context)
                                        .isfavourite[bookId] ==
                                    true) {
                                  DataBaseCubit.get(context)
                                      .deletaFromDB(id: bookId);
                                  Fluttertoast.showToast(
                                      msg: LocaleKeys.BookRemoved.tr(),
                                      gravity: ToastGravity.TOP,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red,
                                      toastLength: Toast.LENGTH_LONG);
                                } else {
                                  DataBaseCubit.get(context).inserttoDatabase(
                                      booknameEn: bookName,
                                      bookImage: image,
                                      booknameAr: bookNameAr,
                                      writernameEn: writerName,
                                      writernameAr: writerNameAr,
                                      price: price,
                                      bookId: bookId);
                                  Fluttertoast.showToast(
                                      msg: LocaleKeys.BookAdded.tr(),
                                      gravity: ToastGravity.TOP,
                                      textColor: Colors.white,
                                      backgroundColor: const Color(0xff3366cc),
                                      toastLength: Toast.LENGTH_LONG);
                                }
                              },
                              child: Container(
                                width: w * 0.09,
                                height: h * 0.09,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        color: Color(0xffedeef4),
                                        spreadRadius: 3,
                                        blurRadius: 3)
                                  ],
                                ),
                                child: Center(
                                  child: (DataBaseCubit.get(context)
                                              .isfavourite[bookId] ==
                                          true)
                                      ? Icon(
                                          Icons.favorite,
                                          size: w * 0.05,
                                          color: const Color(0xff3366cc),
                                        )
                                      : Icon(
                                          Icons.favorite_outline,
                                          size: w * 0.05,
                                          color: const Color(0xff3366cc),
                                        ),
                                ),
                              ),
                            );
                          },
                          listener: (context, state) {}),
                    ],
                  ),
                ],
              ),
              (lang == 'en')
                  ? Text(
                      writerName,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    )
                  : Text(
                      writerNameAr,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
      ),
    ),
  );
}

//////////////////////////////////////////////////////////////////

searchCard(
    {required double h,
    required double w,
    GestureTapCallback? onPress,
    required String bookName,
    required String bookNameAr,
    required String lang,
    required String writerName,
    required String writerNameAr,
    required String price,
    required int bookId,
    required context,
    required String image}) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: h * 0.2,
      margin: EdgeInsets.symmetric(horizontal: w * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.05),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.grey.shade300,
              spreadRadius: 3,
              blurRadius: 3)
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: w * 0.27,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: (lang == 'en')
                  ? BorderRadius.only(
                      topLeft: Radius.circular(w * 0.05),
                      bottomLeft: Radius.circular(w * 0.05))
                  : BorderRadius.only(
                      topRight: Radius.circular(w * 0.05),
                      bottomRight: Radius.circular(w * 0.05)),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w * 0.02,
              ),
              SizedBox(
                height: h * 0.015,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: w * 0.5,
                        child: (lang == 'en')
                            ? Text(
                                bookName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                bookNameAr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: w * 0.04,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: w * 0.03,
                      ),
                      BlocConsumer<DataBaseCubit, AppCubitStates>(
                          builder: (context, state) => InkWell(
                                onTap: () async {
                                  if (DataBaseCubit.get(context)
                                          .isfavourite[bookId] ==
                                      true) {
                                    DataBaseCubit.get(context)
                                        .deletaFromDB(id: bookId);
                                    Fluttertoast.showToast(
                                        msg: LocaleKeys.BookRemoved.tr(),
                                        gravity: ToastGravity.TOP,
                                        textColor: Colors.black,
                                        backgroundColor: Colors.red,
                                        toastLength: Toast.LENGTH_LONG);
                                  } else {
                                    DataBaseCubit.get(context).inserttoDatabase(
                                        booknameEn: bookName,
                                        bookImage: image,
                                        booknameAr: bookNameAr,
                                        writernameEn: writerName,
                                        price: price,
                                        writernameAr: writerNameAr,
                                        bookId: bookId);
                                    Fluttertoast.showToast(
                                        msg: LocaleKeys.BookAdded.tr(),
                                        gravity: ToastGravity.TOP,
                                        textColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff3366cc),
                                        toastLength: Toast.LENGTH_LONG);
                                  }
                                },
                                child: Container(
                                  width: w * 0.09,
                                  height: h * 0.09,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 3),
                                          color: Color(0xffedeef4),
                                          spreadRadius: 3,
                                          blurRadius: 3)
                                    ],
                                  ),
                                  child: Center(
                                    child: (DataBaseCubit.get(context)
                                                .isfavourite[bookId] ==
                                            true)
                                        ? Icon(
                                            Icons.favorite,
                                            size: w * 0.05,
                                            color: const Color(0xff3366cc),
                                          )
                                        : Icon(
                                            Icons.favorite_outline,
                                            size: w * 0.05,
                                            color: const Color(0xff3366cc),
                                          ),
                                  ),
                                ),
                              ),
                          listener: (context, state) {}),
                    ],
                  ),
                ],
              ),
              (lang == 'en')
                  ? Text(
                      writerName,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    )
                  : Text(
                      writerNameAr,
                      style: const TextStyle(
                          color: Colors.red,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 15),
                    ),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: w * 0.03,
          ),
        ],
      ),
    ),
  );
}
