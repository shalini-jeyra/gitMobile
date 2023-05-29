import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:git_mobile/styles/styles.dart';
import 'package:uni_links/uni_links.dart';
import '../../services/auth_service.dart';
import '../pages.dart';
import '../secret_keys.dart' as SecretKey;
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 
  final AuthService authService = AuthService();
  late StreamSubscription _subs;
@override
void initState() {
  _initDeepLinkListener();
  super.initState();
}
@override
void dispose() {
  _disposeDeepLinkListener();
  super.dispose();
}
void _initDeepLinkListener() async {
  _subs = getLinksStream().listen((String? link) {
    _checkDeepLink(link!);
  }, cancelOnError: true);
}

void _checkDeepLink(String link) {
  String code = link.substring(link.indexOf(RegExp('code=')) + 5);
  authService.loginWithGitHub(code,context).then((firebaseUser) {
    if (firebaseUser != null) {
    print(firebaseUser);
 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage( user: firebaseUser,)),
      );
    } else {
      print("LOGIN ERROR: User is null");
    }
  }).catchError((e) {
    print("LOGIN ERROR: " + e.toString());
  });
}

void _disposeDeepLinkListener() {
  _subs.cancel();
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
                  onClickGitHubLoginButton();
    
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
void onClickGitHubLoginButton() async {
  const String authorizeUrl = 'https://github.com/login/oauth/authorize';
  final String clientId = SecretKey.GITHUB_CLIENT_ID;
  final List<String> scopes = ['public_repo', 'read:user', 'user:email', 'read:org'];

  final String url = '$authorizeUrl?client_id=$clientId&scope=${scopes.join('%20')}';

  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    print('CANNOT LAUNCH THIS URL!');
  }
}



}
