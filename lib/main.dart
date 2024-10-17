import 'package:firebase/AddHackathon.dart';
import 'package:firebase/AddWorkShop.dart';
import 'package:firebase/ShowMaterialScreen.dart';
import 'package:firebase/add_project_screen.dart';
import 'package:firebase/home_page.dart';
import 'package:firebase/mentoring.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HackathonScreen.dart';
import 'ProfilePage.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}
