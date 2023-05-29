import 'package:flutter/material.dart';
import 'package:git_mobile/pages/login_page/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:git_mobile/services/provider.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GitHubProvider(),
      child:  MaterialApp(
   debugShowCheckedModeBanner: false,
          theme: ThemeData(
   
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        )
      
    );
  }
}
