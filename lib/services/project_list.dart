import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProjectList{
Future<List<dynamic>> fetchGitHubProjects(BuildContext context,String accessToken) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/user'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/vnd.github+json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> userData = json.decode(response.body);
    final String username = userData['login'];
    // Use the obtained username to fetch projects
    final projects = await fetchProjectsByUsername(accessToken, username);
    return projects;
  } else {
    throw Exception('Failed to fetch user data');
  }
}

Future<List<dynamic>> fetchProjectsByUsername(String accessToken, String username) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$username/repos'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/vnd.github+json',
    },
  );

  if (response.statusCode == 200) {
   
    final List<dynamic> projects = json.decode(response.body);
    return projects;
  } else {
    throw Exception('Failed to fetch projects');
  }
}


}