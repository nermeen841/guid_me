// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guid_me/DBhelper/AppCubit/appState.dart';
import 'package:guid_me/DBhelper/AppCubit/cubit.dart';
import 'book_detail.dart';
import 'component.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
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
          ' Favourite',
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
            child: BlocConsumer<DataBaseCubit, AppCubitStates>(
                builder: (context, state) {
                  return (DataBaseCubit.get(context).favourites.isNotEmpty)
                      ? ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return favouriteCard(
                              w: w,
                              h: h,
                              context: context,
                              bookId: DataBaseCubit.get(context)
                                  .favourites[index]['bookID'],
                              bookName: DataBaseCubit.get(context)
                                  .favourites[index]['bookNameEn'],
                              image: DataBaseCubit.get(context)
                                  .favourites[index]['bookImage'],
                              writerName: DataBaseCubit.get(context)
                                  .favourites[index]['writerNameEn'],
                              onPress: () {},
                              price: DataBaseCubit.get(context)
                                  .favourites[index]['bookPrice'],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount:
                              DataBaseCubit.get(context).favourites.length)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/66.png",
                                width: w * 0.4,
                                height: h * 0.4,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Text(
                              "Add books to your favourite",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: const Color(0xff3366cc),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.07),
                            ),
                          ],
                        );
                },
                listener: (context, state) {}),
          )
        ],
      ),
    );
  }
}
