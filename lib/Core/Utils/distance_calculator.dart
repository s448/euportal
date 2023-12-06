import 'dart:developer';

import 'package:haversine_distance/haversine_distance.dart';

class DistanceCalculator {
  static double getDistance(Location myLocation, Location targetLocation) {
    final haversineDistance = HaversineDistance();

    final distance =
        haversineDistance.haversine(myLocation, targetLocation, Unit.KM);

    log('Distance between start and end coordinate is: $distance km.');
    return distance;
  }
}
