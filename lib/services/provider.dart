import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'branch.dart';

class GitHubProvider with ChangeNotifier {
  String _accessToken = '';
  Map<String, List<dynamic>> _commitsByBranch = {};

  List<dynamic>? _branches;
  DateTime? _lastUpdate;
   List<dynamic> _organizations = [];
  final BranchService _branchService;
  DateTime? get lastUpdate => _lastUpdate;
  String get accessToken => _accessToken;
  List<dynamic>? get branches => _branches;
  Map<String, List<dynamic>> get commitsByBranch => _commitsByBranch;
  List<dynamic> get organizations => _organizations;
  
  GitHubProvider(this._branchService);

  Future<void> fetchLastUpdate(String owner, String repoName) async {
    try {
      final DateTime lastUpdateDate =
          await _branchService.fetchLastUpdateDate(owner, repoName);
      _lastUpdate = lastUpdateDate;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
Future<void> fetchGitHubOrganizations() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.github.com/user/orgs'),
        headers: {
          'Authorization': 'Bearer $_accessToken',
          'Accept': 'application/vnd.github+json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> organizationsData = json.decode(response.body);
        _organizations = organizationsData;
        notifyListeners();
      } else {
        throw Exception('Failed to fetch organizations');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> fetchBranches(String owner, String repoName) async {
    try {
      final List<dynamic> branchesData =
          await _branchService.fetchBranches(owner, repoName);
      _branches = branchesData;
      notifyListeners();
      for (var branch in branchesData) {
        final branchName = branch['name'];
        await fetchCommitsForBranch(owner, repoName, branchName);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCommitsForBranch(
      String owner, String repoName, String branchName) async {
    try {
      final List<dynamic> commitsData = await _branchService
          .fetchCommitsForBranch(owner, repoName, branchName);
      _commitsByBranch[branchName] = commitsData;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }
    void logout() {
  
    _accessToken = '';
    
    
    notifyListeners();
  }

 

}
