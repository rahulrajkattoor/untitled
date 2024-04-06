import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'MACHINE TEST/TOTAL X/login page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey:  "AIzaSyCbVrHtUFMJ4qzgeOWhyVWxyklj3NSaz2Q",
          appId: "1:243447360191:android:2f1d402008e8d8f2efb40a",
          messagingSenderId: "",
          projectId: "com.example.untitled",
          storageBucket: "mockstore-a975a.appspot.com"
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
        home: Login());
  }
}
