import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentPosition() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
      // print('Latitiude = $latitude');
      // print('Longitiude = $longitude');

      // print(position);
    } catch (e) {
      print(e);
    }
  }
}
