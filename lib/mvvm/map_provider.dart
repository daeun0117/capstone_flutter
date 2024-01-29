import 'dart:async';

import 'package:geolocator/geolocator.dart';

class NaverMapModelRepository {
  // 싱글턴 패터라고 선언하면 어디서든 언제 어디선=든

  static late double long;
  static late double lati;

  Future<dynamic> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw Exception('Location permissions are permanently denied.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle appropriately.
        throw Exception('Location permissions are denied.');
      }
    }
    // 위치 정보 가져오기 코드
    try {
      Position position = await Geolocator.getCurrentPosition();

      long = position.longitude;
      lati = position.latitude;

      // 위치 정보 사용
      print('위도 경도 값: $position');

      return position;
    } catch (e) {
      // 위치 정보를 가져오지 못한 경우 처리
      print('위치 정보를 가져오지 못했습니다: $e');
    }
  }
}
