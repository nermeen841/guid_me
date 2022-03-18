import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:guid_me/model/search.dart';
import 'package:guid_me/screens/search/search.dart';
import 'package:guid_me/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favoruite.dart';
import 'package:easy_localization/easy_localization.dart';
import 'more_sold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController search = TextEditingController();
  bool isSearching = false;
  List searchData = [];
  String? lang;
  int counter = 14;
  late Timer timer;
  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String language = prefs.getString('lang') ?? 'en';
    setState(() {
      lang = language;
    });
  }

  @override
  void initState() {
    readSearchData();
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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.language, color: Color(0xff3366cc)),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('lang', 'en');
                        setState(() {
                          context.locale = const Locale('en', '');
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      },
                      child: const Text(
                        "English",
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('lang', 'ar');
                        setState(() {
                          context.locale = const Locale('ar', '');
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()),
                            (route) => false);
                      },
                      child: const Text("اللغة العربية"),
                      value: 2,
                    )
                  ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: w * 0.65,
                height: h * 0.35,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.09),
              child: searchButton(h: 25, w: 80),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            (isSearching)
                ? SearchResultScreen(searchData: searchData)
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavouriteScreen())),
                            child: Container(
                              width: w * 0.35,
                              height: h * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.Favourites.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        color: Color(0xff3366cc)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.favorite,
                                    color: Color(0xff3366cc),
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.07,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoreSoldScreen())),
                            child: Container(
                              width: w * 0.35,
                              height: h * 0.06,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.BestSeller.tr(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Cairo',
                                        fontSize: 16,
                                        color: Color(0xff3366cc)),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.trending_up,
                                    color: Color(0xff3366cc),
                                    size: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.14,
                      ),
                      StatefulBuilder(
                        builder: (context2, setState3) {
                          if (counter == 14) {
                            timer =
                                Timer.periodic(const Duration(days: 1), (e) {
                              if (e.isActive) {
                                setState3(() {
                                  counter--;
                                });
                              }
                              if (counter == 0) {
                                e.cancel();
                              }
                            });
                          }
                          return (counter != 0)
                              ? SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "باقي  ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: w * 0.035)),
                                          ]),
                                        ),
                                      ),
                                      Text(counter.toString(),
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      const Text('  يوم من انتهاء المعرض',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                )
                              : const Text(
                                  'لقد فاتتك فرصة حضور معرض الكتاب , يمكنك الحضور السنة القادمة');
                        },
                      ),
                      SizedBox(
                        height: h * 0.07,
                      ),
                      DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xff5f616e),
                            fontSize: 25,
                            fontFamily: 'Cairo'),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: true,
                          // isRepeatingAnimation: true,
                          displayFullTextOnTap: false,
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText('GUIED ME'),
                          ],
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  searchButton({required double w, required double h}) {
    return TextFormField(
      cursorColor: Colors.grey,
      onChanged: (val) {
        if (lang == 'en') {
          searchData.clear();
          if (val.isNotEmpty) {
            setState(() {
              isSearching = true;
            });
          } else {
            setState(() {
              isSearching = false;
            });
          }
          for (var element in searchModel!.data!) {
            if (element.nameEn.toString().contains(val.trim())) {
              setState(() {
                searchData.add(element);
              });
            }
          }
        } else {
          searchData.clear();

          if (val.isNotEmpty) {
            setState(() {
              isSearching = true;
            });
          } else {
            setState(() {
              isSearching = false;
            });
          }
          for (var element in searchModel!.data!) {
            if (element.nameAr.toString().contains(val.trim())) {
              setState(() {
                searchData.add(element);
              });
            }
          }
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: LocaleKeys.Search.tr(),
        hintStyle: const TextStyle(
            color: Color(0xff5f616e),
            fontSize: 15,
            fontFamily: "Cairo",
            fontWeight: FontWeight.w400),
        prefixIcon: (isSearching)
            ? InkWell(
                onTap: () {
                  setState(() {
                    isSearching = false;
                    searchData.clear();
                  });
                },
                child: const Icon(
                  Icons.clear,
                  color: Color(0xff5f616e),
                ),
              )
            : const Icon(
                Icons.search_rounded,
                color: Color(0xff5f616e),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.5),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(w * 0.5),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////
  SearchModel? searchModel;

  readSearchData() async {
    final jsondata = await rootBundle.loadString('assets/data/search.json');
    var data = json.decode(jsondata);
    setState(() {
      searchModel = SearchModel.fromJson(data);
    });
    return searchModel;
  }
}
