import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_mobile/styles/styles.dart';
// import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../pages.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
final storage = FlutterSecureStorage();
void _signInWithGitHub(BuildContext context) async {
  try {
    final appAuth = FlutterAppAuth();
    final state = _generateRandomState(); // Generate a random state value

    final result = await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        'b2c95f389e7453a79adb',
        'com.example.git_mobile://gitmobile-a680d.firebaseapp.com/__/auth/handler?state=$state',
        serviceConfiguration: AuthorizationServiceConfiguration(
          
           authorizationEndpoint: 'https://github.com/login/oauth/authorize', tokenEndpoint: 'https://github.com/login/oauth/access_token',
        ),
        scopes: ['user', 'repo'],
      ),
    );

    final credential = GithubAuthProvider.credential(result!.idToken!);

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    
    if (authResult.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
    
    }
  } catch (e) {
    print('GitHub authentication failed: $e');
  
  }
}

String _generateRandomState() {
  final random = Random();
  return random.nextInt(999999).toString();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/logo.png',
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/Group.svg',
                  ),
                  Text(
                    'Lets built from here ...',
                    style: TextFonts.ternaryText,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Our platform drives innovation with tools that boost developer velocity',
                    textAlign: TextAlign.center,
                    style: TextFonts.secondaryText,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
    //  _signInWithGitHub(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  backgroundColor: const Color.fromARGB(
                    255,
                    112,
                    108,
                    255,
                  ),
                ),
                child: const Text(
                  'Sign in with Github',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }



}
