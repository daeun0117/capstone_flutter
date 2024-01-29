class Tokens {
  String _accessToken = "";
  String _refreshToken = "";

  String get accessTokenAct => _accessToken;

  String get refreshTokenAct => _refreshToken;

  String updateAccessToken(String accessToken) {
    _accessToken = accessToken;
    return _accessToken;
  }

  String updateRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    return _refreshToken;
  }
}
