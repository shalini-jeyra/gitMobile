import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:git_mobile/services/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/github_login_response.dart';
import '../pages/secret_keys.dart' as SecretKey;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService{
final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
Future<auth.User> loginWithGitHub(String code,BuildContext context) async {
   
    final response = await http.post(
     Uri.parse("https://github.com/login/oauth/access_token") ,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: SecretKey.GITHUB_CLIENT_ID,
        clientSecret: SecretKey.GITHUB_CLIENT_SECRET,
        code: code,
      )),
    );

GitHubLoginResponse loginResponse = GitHubLoginResponse.fromJson(json.decode(response.body));


    final auth.AuthCredential credential = auth.GithubAuthProvider.credential(loginResponse.accessToken);
    
    final auth.User? user = (await _firebaseAuth.signInWithCredential(credential)).user;
   Provider.of<GitHubProvider>(context, listen: false).setAccessToken(loginResponse.accessToken);
   fetchGitHubOrganizations(loginResponse.accessToken);
    return user!;
  }

Future<List<dynamic>> fetchGitHubOrganizations(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/user/orgs'),
    headers: {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/vnd.github+json',
    },
  );

  if (response.statusCode == 200) {
    print('res ------------------${response.body}');
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch organizations');
  }
}
}