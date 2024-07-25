import 'package:electrosign/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCnhF97eTnmiVgFkWzBd9t64qc6yypEwp0",
      authDomain: "electrosign-877ff.firebaseapp.com",
      projectId: "electrosign-877ff",
      storageBucket: "electrosign-877ff.appspot.com",
      messagingSenderId: "44570150142",
      appId: "1:44570150142:web:030d8fc66eb04c5b0d11af",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.habibiTextTheme(),
      ),
      home: HomeScreen(),
    );
  }
}
