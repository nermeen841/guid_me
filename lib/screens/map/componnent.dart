import 'package:flutter/material.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

import '../splash.dart';

class LocationCard extends StatefulWidget {
  final String name;
  final String city;
  final String latitude;
  final String logtitude;
  const LocationCard(
      {Key? key,
      required this.city,
      required this.name,
      required this.latitude,
      required this.logtitude})
      : super(key: key);

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  LatLng startLocation = (SplashScreen.startLatitude != null ||
          SplashScreen.startLongitude != null)
      ? LatLng(SplashScreen.startLatitude!, SplashScreen.startLongitude!)
      : LatLng(30.1552360, 31.6128923);

  late double distance;
  late double time;
  calculateDistance() {
    setState(() {
      distance = SphericalUtil.computeDistanceBetween(
              startLocation,
              LatLng(double.parse(widget.latitude),
                  double.parse(widget.logtitude))) /
          1000.0;
      time = distance / 80;
    });

    return distance;
  }

  @override
  void initState() {
    calculateDistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h * 0.24,
        margin: EdgeInsets.all(w * 0.07),
        padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.05),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: w * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.05),
                image: const DecorationImage(
                    image: AssetImage(
                        "assets/images/274920349_387828282673748_3632245269465058172_n.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: w * 0.025,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                SizedBox(
                  width: w * 0.45,
                  child: Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo'),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: const Color(0xff3366cc),
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.2,
                      child: Text(
                        widget.city,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: const Color(0xff3366cc),
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    SizedBox(
                      width: w * 0.4,
                      child: Text(
                        distance.toStringAsFixed(2).toString() + " " + "Km",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3366cc),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: const Color(0xff3366cc),
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.015,
                    ),
                    SizedBox(
                      width: w * 0.4,
                      child: Text(
                        time.toStringAsFixed(2).toString() + " " + "Hour",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3366cc),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
