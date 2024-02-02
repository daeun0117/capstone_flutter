import 'package:capstone_flutter/pages/login_pages/location_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class MapProvider extends ChangeNotifier {
  double? lat;
  double? lng;
  Location location = Location();
  final LocationService _locationService = LocationService();

  Future<void> locateMe() async {
    LocationData? locationData = await _locationService.getLocation();
    if (locationData != null) {
      lat = locationData.latitude;
      lng = locationData.longitude;
      notifyListeners();
      print('lat: $lat, long: $lng');
    } else {
      // 위치를 사용할 수 없을 때 처리
    }
  }
}
