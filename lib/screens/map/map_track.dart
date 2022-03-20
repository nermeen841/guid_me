// ignore_for_file: use_key_in_widget_constructors, avoid_print, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyANHFLOPg0mwSHWW1bqBx5XgOrk1SjTVEw";

  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = (SplashScreen.startLatitude != null ||
          SplashScreen.startLongitude != null)
      ? LatLng(SplashScreen.startLatitude!, SplashScreen.startLongitude!)
      : const LatLng(30.1552360, 31.6128923);
  // LatLng endLocation = const LatLng(30.0145004, 31.3817824);
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
          infoWindow: const InfoWindow(
            //popup info
            title: 'Destination Point ',
            snippet: 'Destination Marker',
          ),
          icon: BitmapDescriptor.defaultMarker //Icon for Marker
          ),
    );
    getDirections();
    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(
          double.parse(widget.latitude), double.parse(widget.logtitude)),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      patterns: <PatternItem>[PatternItem.dash(5), PatternItem.gap(5)],
      color: const Color(0xff3366cc),
      jointType: JointType.mitered,
    );

    setState(() {
      polylines[id] = polyline;
    });
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
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 16.0,
            ),
            markers: markers,
            // polygons: MapHolder.instance.mapPolygons!,
            polylines: Set<Polyline>.of(polylines.values),
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
          backIcon(w: w, h: h),
          LocationCard(
            city: widget.city,
            name: widget.name,
            latitude: widget.latitude,
            logtitude: widget.logtitude,
          ),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////////////

}
