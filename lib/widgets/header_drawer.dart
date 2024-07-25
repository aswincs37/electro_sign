import 'package:electrosign/screens/manage_contracts_screens.dart';
import 'package:electrosign/screens/my_documents_screen.dart';
import 'package:electrosign/screens/my_signature_screen.dart';
import 'package:electrosign/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:electrosign/screens/login_screen.dart'; 

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Color whiteClr = Colors.white;

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 1, 39, 70),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          if (user != null) ...[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Icon(Icons.person),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Hi,User!",
                        // 'Hi, ${user.displayName ?? 'User'}!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                        ),
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
                Navigator.pop(context);
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UploadScreen(),
                ));
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ManageContractScreen(),
                ));
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySignatureScreen(),
                ));
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyDocumentScreen(),
                ));
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
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
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
          ],
        ],
      ),
    );
  }
}
