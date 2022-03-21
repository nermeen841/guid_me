import 'package:flutter/material.dart';
import 'package:guid_me/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewsScreen extends StatefulWidget {
  const LatestNewsScreen({Key? key}) : super(key: key);

  @override
  State<LatestNewsScreen> createState() => _LatestNewsScreenState();
}

class _LatestNewsScreenState extends State<LatestNewsScreen> {
  String lang = '';
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

  List<String> images = [
    "assets/images/ahmed.jpeg",
    "assets/images/Ali.jpg",
    "assets/images/hanan.jpg",
    "assets/images/ayman.jpg",
    "assets/images/274920349_387828282673748_3632245269465058172_n.jpg",
    "assets/images/274920349_387828282673748_3632245269465058172_n.jpg",
    "assets/images/274920349_387828282673748_3632245269465058172_n.jpg",
  ];

  List<String> titles = [
    "أعلن الكاتب والروائي أحمد مراد عن كتابه الجديد المرتقب إصداره في عام 2022 عن دار الشروق للنشر والتوزيع ويحمل عنوان: القتل للمبتدئين.",
    "لا تفوت فرصه لقاء الكتاب علي بن جابر الفيفي لتوقيعه كتاب لانك الله",
    "حنان لاشين هي كاتبة روائية مصرية حاصلة على بكالوريوس الطب البيطري من جامعة الإسكندرية، وهي عضو اتحاد كتاب مصر",
    "لا تفوت فرصه لقاء الكتاب ايمن العتوم لتوقيعه كتاب كلمة الله",
    "سوف يتم عمل ورشه تفاعليه برئاسة اسماء عواد الساعه 2: 45",
    "الفقرة الفنيه : فقرة النيل للالات الشعبيه سوف تقام في تمام الساعة الثالثة ",
    "فقرة حلمك سوف يحضر د . حسين بكر سوف يتحدث عن مبادئ التصوير السنيمائي"
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          (lang == 'en') ? "Latest News" : "أحدث الأخبار",
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
                size: 30,
              ))
        ],
      ),
      body: SizedBox(
        width: w,
        height: h,
        child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 5), () => true),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child:
                      Image.asset("assets/images/37369-loading-granulated.gif"),
                );
              }

              return ListView(
                primary: true,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: h * 0.02, horizontal: w * 0.02),
                children: [
                  Text(
                    LocaleKeys.FACEBOOK.tr(),
                    style: TextStyle(
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Cairo',
                      color: const Color(0xff3366cc),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  InkWell(
                    onTap: () async {
                      await launch(
                        "https://www.facebook.com/cairobookfair/",
                        forceSafariVC: false,
                        forceWebView: true,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.facebook_rounded,
                          color: Color(0xff3366cc),
                        ),
                        SizedBox(
                          width: w * 0.015,
                        ),
                        Text(
                          "https://www.facebook.com/cairobookfair/",
                          style: TextStyle(
                              fontSize: w * 0.04,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Cairo',
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.2, right: w * 0.2),
                    child: const Divider(
                      thickness: 3,
                      color: Color(0xff3366cc),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => notifyItem(
                          image: images[index],
                          w: w,
                          h: h,
                          text: titles[index],
                          date: "14 April 2022",
                          time: "4 : 00 pm"),
                      separatorBuilder: (context, index) => Column(
                            children: [
                              SizedBox(
                                height: h * 0.03,
                              ),
                              const Divider(
                                color: Color(0xff3366cc),
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                            ],
                          ),
                      itemCount: images.length),
                ],
              );
            }),
      ),
    );
  }

  notifyItem(
      {required String image,
      required double w,
      required double h,
      required String text,
      required String date,
      required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: w * 0.1,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(
          width: w * 0.02,
        ),
        Padding(
          padding: EdgeInsets.only(top: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: w * 0.7,
                child: Text(
                  text,
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: w * 0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Text(
                date + "   " + time,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: w * 0.03,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
