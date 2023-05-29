import 'package:flutter/material.dart';

class GitHubProvider with ChangeNotifier {
  String _accessToken = '';

  String get accessToken => _accessToken;

  setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }
}