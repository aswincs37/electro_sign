import 'package:electrosign/screens/home_screen.dart';
import 'package:electrosign/screens/main_home_screen.dart';
import 'package:electrosign/screens/manage_contracts_screens.dart';
import 'package:electrosign/screens/mobile/mobile_manage_contracts_screens.dart';
import 'package:electrosign/screens/mobile/mobile_upload_screen.dart';
import 'package:electrosign/screens/mobile/my_documents_screen.dart';
import 'package:electrosign/screens/mobile/my_signature_screen.dart';
import 'package:electrosign/screens/my_documents_screen.dart';
import 'package:electrosign/screens/my_signature_screen.dart';
import 'package:electrosign/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electrosign/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user?.email ?? 'User';

    Color whiteClr = Colors.white;

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 1, 39, 70),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (user != null) ...[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                          Text(
                            'Hi, ${userName}!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Explore our App...!",
                            style: GoogleFonts.acme(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: whiteClr,
              ),
              title: Text(
                'Home',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const MainHomeScreen(),
                    ),
                    (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.upload,
                color: whiteClr,
              ),
              title: Text(
                'Uploads',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () {
                screenWidth > 1000
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const UploadScreen(),
                        ),
                        (route) => false)
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MobileUploadScreen(),
                        ),
                        (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.recent_actors,
                color: whiteClr,
              ),
              title: Text(
                'Manage Contracts',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () {
                screenWidth > 1000
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const ManageContractScreen(),
                        ),
                        (route) => false)
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              const MobileManageContractScreen(),
                        ),
                        (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.border_color,
                color: whiteClr,
              ),
              title: Text(
                'My Signature',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () {
                screenWidth > 1000
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MySignatureScreen(),
                        ),
                        (route) => false)
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MobileMySignatureScreen(),
                        ),
                        (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.edit_document,
                color: whiteClr,
              ),
              title: Text(
                'My Documents',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () {
                screenWidth > 1000
                    ? Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MyDocumentScreen(),
                        ),
                        (route) => false)
                    : Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MobileMyDocumentScreen(),
                        ),
                        (route) => false);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: whiteClr,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: whiteClr),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ] else ...[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Please log in to access the app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
                  },
                  child: const Text('Log In'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(50),
              height: 150,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
