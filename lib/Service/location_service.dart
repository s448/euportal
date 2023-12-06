import 'package:location/location.dart' hide PermissionStatus;
import 'package:permission_handler/permission_handler.dart';

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
}
