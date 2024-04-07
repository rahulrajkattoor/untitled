import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/MACHINE%20TEST/TOTAL%20X/home%20page.dart';


import 'MACHINE TEST/TOTAL X/login page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC-ZyQFLXBsIYtGu5tqVI-XIym0U_R5uPw",
          appId: "1:105638790803:android:88fe6a84a084de9a71ef66",
          messagingSenderId: "",
          projectId: "com.example.untitled",
          storageBucket: "machinetest-5b7b9.appspot.com"
      ));

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home());
  }
}
