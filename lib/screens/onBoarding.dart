// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'home_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;

  List<Map<String, String>> splashData = [
    {
      "text":
          "GUIED ME is your fastest way ever to \n find your favorite books in the book fair",
      "image": "assets/images/onboearding.png"
    },
    {"text": 'Reading Is Life', "image": "assets/images/13258.jpg"},
    {"text": 'Know New Information', "image": "assets/images/Library.jpg"},
    {
      "text": 'Feed Your Brain',
      "image": "assets/images/knowledgeeducation.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: h * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: h * 0.2),
            Expanded(
              flex: 3,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"].toString(),
                  text: splashData[index]['text'].toString(),
                ),
              ),
            ),
            SizedBox(height: h * 0.035),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => buildOnBoardingDot(
                    index: index, currentPage: currentPage, context: context),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            defaultButton(
                title: 'GUIED ME',
                textColor: Colors.white,
                onPressed: () async {
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  // prefs.setBool('is_onboearding', true);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                fontSize: w * 0.05,
                height: h * 0.07,
                width: w * 0.5,
                color: const Color(0xff3366cc),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 5,
                    offset: const Offset(0, 5), // Shadow position
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String text, image;

  const SplashContent({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          height: h * 0.3,
          width: w * 1,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: h * 0.02,
        ),
        SizedBox(
          width: w * 0.85,
          child: Text(
            text,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

AnimatedContainer buildOnBoardingDot(
    {required int index, required int currentPage, required context}) {
  // double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: EdgeInsets.only(right: w * 0.03),
    height: 5,
    width: currentPage == index ? w * 0.06 : w * 0.03,
    decoration: BoxDecoration(
      color:
          currentPage == index ? const Color(0xff3366cc) : Colors.grey.shade400,
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

Widget defaultButton({
  required String title,
  required VoidCallback? onPressed,
  required double? fontSize,
  required double? height,
  required double? width,
  required Color color,
  required Color textColor,
  List<BoxShadow>? boxShadow,
  EdgeInsetsGeometry? margin,
}) =>
    Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: boxShadow,

        //#3A0CA3
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
