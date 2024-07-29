import 'dart:ui';

import 'package:electrosign/screens/login_screen.dart';
import 'package:electrosign/screens/register_screen.dart';
import 'package:electrosign/section/body/footer_body.dart';
import 'package:electrosign/section/body/header_body.dart';
import 'package:electrosign/section/body/first_middle_body.dart';
import 'package:electrosign/section/body/second_middle_body.dart';
import 'package:electrosign/widgets/floatingactionbutton.dart';
import 'package:electrosign/widgets/header_buttons.dart';
import 'package:electrosign/widgets/header_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});
  Future logOut(BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MobileHomeScreen(),
        ),
        (route) => false,
      );
    } catch (e) {
      showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: const Text("Logout failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      drawer: const HeaderDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 1, 39, 70),
              // elevation: 50,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              title: Row(
                children: [
                  // Container(
                  //   height: 50,
                  //   width: 50,
                  //   decoration: const BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage("assets/images/logo.png"))),
                  // ),
                  Text(
                    "ElectroSign",
                    style: GoogleFonts.concertOne(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                if (user == null) ...[
                  StylishTextButton(
                    text: "Login",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const LoginScreen();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  StylishTextButton(
                    text: "Register",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RegisterScreen();
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                ] else ...[
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Logout",
                      style: GoogleFonts.chakraPetch(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      logOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ]),
          const SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header_body(),
                  SizedBox(
                    height: 20,
                  ),
                  FirstMiddleBody(),
                  SizedBox(
                    height: 20,
                  ),
                  SecondMiddleBody(),
                  SizedBox(
                    height: 10,
                  ),
                  FooterBody()
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingactionButton(),
    );
  }
}
