import 'dart:async';
import 'dart:collection';

import 'package:bue_university_project/presentation/resources/assets_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapScreenEight extends StatefulWidget {
  String ?busId;
  GoogleMapScreenEight({this.busId});

  @override
  _GoogleMapScreenEightState createState() => _GoogleMapScreenEightState();
}

class _GoogleMapScreenEightState extends State<GoogleMapScreenEight> {
  List<Marker> myMarkers = [];
  final Set<Polyline> polyline = {};
  List<LatLng> routeCoordinates = [];
  GoogleMapPolyline googleMapPolyline =
  GoogleMapPolyline(apiKey: 'AIzaSyA3WIL9FMt5Fm_lNmrr4yrRpiO6EDcftDI');
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};


// Starting point latitude
  final double _originLatitude = 30.013588444874035;

// Starting point longitude
  final double _originLongitude = 31.49191699033166;



// Destination latitude
  final double _destLatitude = 30.118032876014972;

// Destination Longitude
  final double _destLongitude = 31.60598500076346;

// Markers to show points on the map

  Map<MarkerId, Marker> markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  // Configure map position and zoom
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(30.22854982325609, 31.48035512612880),
    zoom: 9.4746,
  );

  @override
  void initState() {
    /// add origin marker origin marker
    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );
    _getPolyline();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Route'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        polylines: Set<Polyline>.of(polylines.values),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA3WIL9FMt5Fm_lNmrr4yrRpiO6EDcftDI",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,

    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
    // await FirebaseFirestore.instance.collection('busNumbers').doc('busId').set({
    //   'routes':polylineCoordinates,
    //   'startPoints':[30.22854982325609, 31.48035512612880],
    //   'endPoints':[30.118032876014972, 31.60598500076346],
    //
    // });
  }
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 6,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}