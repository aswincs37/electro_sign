import 'package:electrosign/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});
  Future logOut(BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
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
    String userName = user?.email ?? 'User';
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 1, 39, 70),
      elevation: 50,
      title: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ),
          const SizedBox(
              width: 10), // Add some space between the logo and the text
          Text(
            "ElectroSign",
            style: GoogleFonts.concertOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            width: 60,
          ),
          Text(
            "Hello, $userName",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
      actions: [
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
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
