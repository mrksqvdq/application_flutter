import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _username = '';
  String _userRole = '';

  bool get isAuthenticated => _isAuthenticated;
  String get username => _username;
  String get userRole => _userRole;

  void login(String username, String password, String role) {
    // In a real app, this would validate against a backend
    _isAuthenticated = true;
    _username = username;
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _username = '';
    _userRole = '';
    notifyListeners();
  }
}
