import 'dart:developer';

import 'package:eup/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsPage extends StatefulWidget {
  // final double latitude;
  // final double longitude;
  // final LatLng source;
  // = LatLng(37.7749, -122.4194);
  final LatLng destination;
  //  = LatLng(37.7749, -122.4194);

  const GoogleMapsPage({super.key, required this.destination});

  @override
  GoogleMapsPageState createState() => GoogleMapsPageState();
}

class GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    try {
      LocationData locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void getPolypoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult polylineResult =
          await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyD5lVph6oxgfNAel4axaf_4vbWiz_-BYu0',
        PointLatLng(currentLocation?.latitude ?? 0.0,
            currentLocation?.longitude ?? 0.0),
        PointLatLng(widget.destination.latitude, widget.destination.longitude),
      );

      if (polylineResult.points.isNotEmpty) {
        setState(() {
          polylineCoordinates = polylineResult.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getPolypoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاتجاهات"),
      ),
      body: currentLocation == null
          ? const Center(
              child: Text("..برجاء الانتظار"),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude!,
                  currentLocation!.longitude!,
                ),
                zoom: 12.0,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  width: 5,
                  color: ColorManager.primaryC,
                )
              },
              markers: {
                Marker(
                  markerId: const MarkerId('my location'),
                  position: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: widget.destination,
                ),
              },
            ),
    );
  }
}
