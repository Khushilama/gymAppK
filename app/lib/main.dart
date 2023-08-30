import 'package:app/provider/appProvider.dart';
import 'package:app/screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:app/screen/achievement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final checkuser = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
        create: (_) => AppProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: checkuser != null ? HomeScreen() : Login()));
  }
}
