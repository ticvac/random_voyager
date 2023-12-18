import 'package:geolocator/geolocator.dart';
import 'dart:math';

// copy pasted code, but whatever
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are '
          'permanently denied, we cannot request permissions.',
    );
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

// not sure why, but too lazy to figure out by myself
// some spherical shit
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  double latR = lat1 * pi / 180;
  double lonR = lon1 * pi / 180;
  double newLatR = lat2 * pi / 180;
  double newLonR =  lon2 * pi / 180;
  double dLatR = newLatR - latR;
  double dLonR = newLonR - lonR;
  num a = pow(sin(dLatR/2), 2)+cos(latR)*cos(newLatR)*pow(sin(dLonR/2), 2);
  double d = 6373 * 2 * atan2(sqrt(a), sqrt(1 - a));
  return d;
}