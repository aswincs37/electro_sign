import 'package:electrosign/screens/main_home_screen.dart';
import 'package:electrosign/screens/manage_contracts_screens.dart';
import 'package:electrosign/screens/mobile/mobile_upload_screen.dart';
import 'package:electrosign/screens/my_documents_screen.dart';
import 'package:electrosign/screens/my_signature_screen.dart';
import 'package:electrosign/screens/upload_screen.dart';
import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color whiteClr = Colors.white;
    return Container(
      width: 200,
      color: const Color.fromARGB(255, 1, 39, 70),
      child: ListView(
        children: [
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const ManageContractScreen(),
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MySignatureScreen(),
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MyDocumentScreen(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
