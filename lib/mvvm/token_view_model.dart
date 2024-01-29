import 'package:capstone_flutter/model/token.dart';
import 'package:flutter/material.dart';

class TokenViewModel extends ChangeNotifier {
  late Tokens _token;

  TokenViewModel() {
    _token = Tokens();
  }

  String get accessToken => _token.accessTokenAct;

  String get refreshToken => _token.refreshTokenAct;

  void update() {
    notifyListeners();
  }

  void updateAccessToken(String accessToken) {
    _token.updateAccessToken(accessToken);
    update();
  }

  void updateRefreshToken(String refreshToken) {
    _token.updateRefreshToken(refreshToken);
    update();
  }
}
