import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  GoogleMapsPage({required this.latitude, required this.longitude});

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  // final LatLng _kMapCenter =
  // LatLng(19.018255973653343, 72.84793849278007);

  @override
  Widget build(BuildContext context) {
    // final CameraPosition _kInitialPosition =
    // CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              37.7749, -122.4194), // Default to San Francisco coordinates
          zoom: 12.0,
        ),
      ),
    );
  }
}
