// ignore_for_file: use_key_in_widget_constructors, avoid_print, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guid_me/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'componnent.dart';

class MapTrackScreen extends StatefulWidget {
  final String name;
  final String city;
  final String latitude;
  final String logtitude;

  const MapTrackScreen({
    Key? key,
    required this.name,
    required this.city,
    required this.latitude,
    required this.logtitude,
  }) : super(key: key);
  @override
  _MapTrackScreenState createState() => _MapTrackScreenState();
}

class _MapTrackScreenState extends State<MapTrackScreen> {
  GoogleMapController? mapController; //contrller for Google map
  List<Polyline> myPolyline = [];
  Set<Marker> markers = {};
  LatLng startLocation = (SplashScreen.startLatitude != null ||
          SplashScreen.startLongitude != null)
      ? LatLng(SplashScreen.startLatitude!, SplashScreen.startLongitude!)
      : const LatLng(30.1552360, 31.6128923);

  String? lang;
  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String language = prefs.getString('lang') ?? 'en';
    setState(() {
      lang = language;
    });
  }

  @override
  void initState() {
    super.initState();
    createPolyline();
    getLanguage();
    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    markers.add(
      Marker(
          markerId: MarkerId(LatLng(
                  double.parse(widget.latitude), double.parse(widget.logtitude))
              .toString()),
          position: LatLng(double.parse(widget.latitude),
              double.parse(widget.logtitude)), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: widget.name,
            snippet: widget.city,
          ),
          icon: BitmapDescriptor.defaultMarker //Icon for Marker
          ),
    );
  }

  createPolyline() {
    myPolyline.add(
      Polyline(
          polylineId: const PolylineId('1'),
          color: const Color(0xff3366cc),
          width: 5,
          points: [
            LatLng(startLocation.latitude, startLocation.longitude),
            LatLng(
              double.parse(widget.latitude),
              double.parse(widget.logtitude),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Stack(
        children: [
          googleMapUI(),
          backIcon(w: w, h: h),
          LocationCard(
              city: widget.city,
              name: widget.name,
              latitude: widget.latitude,
              logtitude: widget.logtitude),
        ],
      ),
    );
  }

  backIcon({required double w, required double h}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.03),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: w * 0.1,
            height: h * 0.1,
            padding: (lang == 'en')
                ? EdgeInsets.only(
                    left: w * 0.02,
                  )
                : EdgeInsets.only(
                    right: w * 0.02,
                  ),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      spreadRadius: 3,
                      blurRadius: 3)
                ]),
            child: Center(
              child: (lang == 'en')
                  ? Icon(
                      Icons.arrow_back_ios,
                      color: const Color.fromARGB(255, 3, 24, 66),
                      size: w * 0.07,
                    )
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: const Color.fromARGB(255, 3, 24, 66),
                      size: w * 0.07,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget googleMapUI() {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.latitude),
                  double.parse(widget.logtitude)),
              zoom: 10,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) async {},
            // circles: circles,
            polylines: myPolyline.toSet(),
          ),
        ),
      ],
    );
  }

////////////////////////////////////////////////////////////////////////////////////////

}
