import 'package:flutter/material.dart';
import 'package:git_mobile/pages/login_page/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:git_mobile/services/branch.dart';
import 'package:git_mobile/services/provider.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BranchService branchService = BranchService();
  runApp( MyApp(branchService: branchService));
}

class MyApp extends StatelessWidget {
   final BranchService branchService;

  const MyApp({required this.branchService});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GitHubProvider(branchService),
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
