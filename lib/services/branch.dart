
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BranchService{
   Future<DateTime> fetchLastUpdateDate(String owner, String repoName) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/repos/$owner/$repoName'),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> repoData = json.decode(response.body);
      final String lastUpdateDateString = repoData['updated_at'];
      final DateTime lastUpdateDate = DateTime.parse(lastUpdateDateString);
      return lastUpdateDate;
    } else {
      throw Exception('Failed to fetch repository information');
    }
  }
   Future<List<dynamic>> fetchBranches(String owner, String repoName) async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repoName/branches'));
    if (response.statusCode == 200) {
      final List<dynamic> branchesData = json.decode(response.body);
      return branchesData;
    } else {
      throw Exception('Failed to fetch branches');
    }
  }
   Future<List<dynamic>> fetchCommitsForBranch(String owner, String repoName, String branchName) async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/$owner/$repoName/commits?sha=$branchName'));
    if (response.statusCode == 200) {
      final List<dynamic> commitsData = json.decode(response.body);
      return commitsData;
    } else {
      throw Exception('Failed to fetch commits for branch $branchName');
    }
  }
}