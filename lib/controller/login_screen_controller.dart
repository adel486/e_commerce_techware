import 'package:flutter/material.dart';

class LoginScreenController with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); 

    _isLoading = false;
    notifyListeners();

    return username == "admin" && password == "admin@123";
  }
}
