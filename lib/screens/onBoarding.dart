import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
// import 'package:travel/constants/constants.dart';
// import 'package:travel/presentation/screens/authentication/login_or_signup/login_or_signUp_screen.dart';
// import 'package:travel/presentation/widgets/onBoarding_content/onBoarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  // bool isLast = false;

  List<Map<String, String>> splashData = [
    {"text": 'Reading Is Life', "image": "assets/images/13258.jpg"},
    {"text": 'Know New Information', "image": "assets/images/people-team.png"},
    {
      "text": 'Feed Your Brain',
      "image": "assets/images/knowledgeeducation.png"
    },
    // {"text": 'Improve Yourself', "image": "assets/images/page2 (2).jpg"},
    // {"text": 'Spend Time Developing', "image": "assets/images/page3.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
                physics: BouncingScrollPhysics(),
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('is_onboearding', true);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                fontSize: w * 0.05,
                height: h * 0.07,
                width: w * 0.5,
                color: Color(0xff3366cc),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 5,
                    offset: Offset(0, 5), // Shadow position
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
      children: <Widget>[
        Image.asset(
          image,
          height: h * 0.3,
          width: w * 1,
          fit: BoxFit.cover,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),
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
    duration: Duration(milliseconds: 250),
    margin: EdgeInsets.only(right: w * 0.03),
    height: 5,
    width: currentPage == index ? w * 0.06 : w * 0.03,
    decoration: BoxDecoration(
      color: currentPage == index ? Color(0xff3366cc) : Colors.grey.shade400,
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
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
