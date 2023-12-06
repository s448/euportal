import 'dart:developer';

import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart' hide Location;

class LocationService {
  Future<LocationData?> getLocation() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      Location location = Location();
      try {
        return await location.getLocation();
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String> getLocationAddress(double lat, double long) async {
    try {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(lat, long, localeIdentifier: "loc");

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks[0];
          return '${placemark.street!}, ${placemark.locality!}, ${placemark.administrativeArea!} ${placemark.postalCode!}';
        } else {
          return 'No address available';
        }
      } catch (e) {
        log('Error getting address: $e');
      }
    } catch (e) {
      log(e.toString());
    }
    return "";
  }
}
