import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                size: 35,
              ))
        ],
      ),
      body: SizedBox(
        width: w,
        height: h,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: h * 0.02, horizontal: w * 0.02),
          child: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 5), () => true),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Image.asset(
                          "assets/images/37369-loading-granulated.gif"));
                }

                return ListView.separated(
                    itemBuilder: (context, index) => notifyItem(
                        image:
                            "assets/images/274920349_387828282673748_3632245269465058172_n.jpg",
                        w: w,
                        h: h,
                        text: "important notification ",
                        date: "14 April 2022",
                        time: "4 : 00 pm"),
                    separatorBuilder: (context, index) => SizedBox(
                          height: h * 0.03,
                        ),
                    itemCount: 3);
              }),
        ),
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
              Text(
                text,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: w * 0.04,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              Text(
                date + time,
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
