import 'package:electrosign/screens/manage_contracts_screens.dart';
import 'package:electrosign/screens/my_documents_screen.dart';
import 'package:electrosign/screens/my_signature_screen.dart';
import 'package:electrosign/screens/upload_screen.dart';
import 'package:flutter/material.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Add your onTap code here!
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
              // Add your onTap code here!
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
              // Add your onTap code here!
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
              // Add your onTap code here!
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
              // Add your onTap code here!
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyDocumentScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
