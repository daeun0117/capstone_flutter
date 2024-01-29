import 'package:flutter/material.dart';

import '../mvvm/map_provider.dart';

class MapProvider extends ChangeNotifier {
  late NaverMapModelRepository _naverMapModelRepository;

  double? longitude;

  double? latitude;

  void update() {
    notifyListeners();
  }

  void getLocation() {
    update();
  }
}
