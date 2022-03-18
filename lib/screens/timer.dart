import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:guid_me/generated/locale_keys.g.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int days = 14;
  int hours = 24;
  int minutes = 60;
  int seonds = 60;

  startDays() {
    if (days == 14) {
      Timer.periodic(const Duration(days: 1), (e) {
        if (e.isActive) {
          setState(() {
            days--;
          });
          if (days == 0) {
            setState(() {
              e.cancel();
            });
          }
        }
      });
    }
  }

  startHours() {
    if (hours == 24) {
      Timer.periodic(const Duration(hours: 1), (e) {
        if (e.isActive) {
          setState(() {
            hours--;
          });
          if (hours == 0) {
            setState(() {
              e.cancel();
            });
          }
        }
      });
    }
  }

  startMinutes() {
    if (minutes == 60) {
      Timer.periodic(const Duration(minutes: 1), (e) {
        if (e.isActive) {
          setState(() {
            minutes--;
          });
          if (minutes == 0) {
            setState(() {
              e.cancel();
            });
          }
        }
      });
    }
  }

  startSeconds() {
    if (seonds == 60) {
      Timer.periodic(const Duration(seconds: 1), (e) {
        if (e.isActive) {
          setState(() {
            seonds--;
          });
          if (seonds == 0) {
            setState(() {
              e.cancel();
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    startDays();
    startHours();
    startMinutes();
    startSeconds();
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
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Color(0xff3366cc),
        ),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.02),
          child: Column(
            children: [
              Center(
                child: Text(
                  LocaleKeys.TIME.tr(),
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: w * 0.05,
                      color: const Color(0xff3366cc),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  timeComponnent(
                      h: h, w: w, time: days, title: LocaleKeys.DAYS.tr()),
                  timeComponnent(
                      h: h, w: w, time: hours, title: LocaleKeys.HOURS.tr()),
                  timeComponnent(
                      h: h,
                      w: w,
                      time: minutes,
                      title: LocaleKeys.MINUTES.tr()),
                  timeComponnent(
                      h: h, w: w, time: seonds, title: LocaleKeys.SECONDS.tr()),
                ],
              ),
              SizedBox(
                height: h * 0.1,
              ),
              Image.asset(
                "assets/images/32614-sand-time-loading.gif",
                height: h * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: h * 0.03,
              ),
              Text(
                LocaleKeys.TIME_LEFT.tr(),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  timeComponnent({int? time, String? title, double? w, double? h}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: w! * 0.2,
          height: h! * 0.1,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(w * 0.03),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffedeef4),
                  spreadRadius: 4,
                  blurRadius: 4,
                  offset: Offset(0, 5),
                ),
              ]),
          child: Center(
            child: Text(
              time.toString(),
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: w * 0.04,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.03,
        ),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: w * 0.04,
              color: Colors.grey,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
