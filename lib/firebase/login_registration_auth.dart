import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrosign/screens/main_home_screen.dart';
import 'package:electrosign/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//LOGIN
//Sign in with email and pasword firebase authentication
Future<void> signIn(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());

    // Show success message and navigate to MainHomeScreen
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MainHomeScreen(),
      ),
      (route) => false,
    );
  } on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Login failed"),
          content: Text(e.message ?? ''),
        );
      },
    );
  }
}

//REGISTRATION
Future<void> signUp(
    TextEditingController emailContoller,
    TextEditingController passwordContoller,
    TextEditingController phoneContoller,
    TextEditingController nameContoller,
    BuildContext context) async {
  try {
    // Create user
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailContoller.text.trim(),
            password: passwordContoller.text.trim());

    // Add user details
    await addUserDetails(nameContoller.text.trim(),
        int.parse(phoneContoller.text.trim()), userCredential.user?.uid);

    // Show success message and navigate to another screen if needed
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Successfully registered!"),
        );
      },
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const UploadScreen(),
        ),
        (route) => false);
  } on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Registration failed"),
            content: Text(e.message ?? ''));
      },
    );
  }
}

Future<void> addUserDetails(String name, int phoneNumber, String? uid) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'name': name,
    'phone': phoneNumber,
  });
}
