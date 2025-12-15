import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> hasSession();

  Future<void> clearSession();

  Future<void> saveTokens(String accessToken, String refreshToken);

  Future<Map<String, String>?> getTokens();
}

class AuthLocalDatasourcesImpl implements AuthLocalDataSource {
  final String accessTokenKey = "ACCESS_TOKEN";
  final String refreshTokenKey = "REFRESH_TOKEN";

  @override
  Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();

    final access = prefs.getString(accessTokenKey);
    final refresh = prefs.getString(refreshTokenKey);

    return access != null && refresh != null && access.isNotEmpty;
  }

  @override
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    // Remove all stored keys
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);
    // Clear all preferences to ensure complete cleanup
    await prefs.clear();
  }

  @override
  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  @override
  Future<Map<String, String>?> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString(accessTokenKey);
    final refresh = prefs.getString(refreshTokenKey);

    if (access != null && refresh != null) {
      return {'accessToken': access, 'refreshToken': refresh};
    }
    return null;
  }
}
