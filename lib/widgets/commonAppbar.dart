import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrosign/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  Future<String?> gettingUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      return doc.data()?['name'];
    } else {
      debugPrint('No user document found.');
      return null;
    }
  }

  Future<void> logOut(BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
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
    final screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 1, 39, 70),
      elevation: 50,
      title: Row(
        children: [
        screenWidth>1000?  Container(
            height: 50,   
            width: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
          ):const SizedBox(),
          const SizedBox(width: 10),
          Text(
            "ElectroSign",
            style: GoogleFonts.concertOne(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 60),
          screenWidth > 1000
              ? FutureBuilder<String?>(
                  future: gettingUserName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        "Error",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    } else {
                      final userName = snapshot.data;
                      return Text(
                        "Hello, $userName !",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    }
                  },
                )
              : const SizedBox()
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
            await logOut(context);
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
