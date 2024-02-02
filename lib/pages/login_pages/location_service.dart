import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();
  Future<LocationData?> getLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null; //서비스의 활성화 여부를 확인해줌.
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null; //서비스를 허용하지 않은 경우
      }
    }
    try {
      return await _location.getLocation();
    } catch (e) {
      //print('위치 가져오기 오류: $e');
      return null;
    }
  }
}
