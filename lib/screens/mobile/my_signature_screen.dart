import 'package:electrosign/widgets/body_button.dart';
import 'package:electrosign/widgets/commonAppbar.dart';
import 'package:electrosign/widgets/header_drawer.dart';
import 'package:electrosign/widgets/signature_pad.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MobileMySignatureScreen extends StatefulWidget {
  const MobileMySignatureScreen({Key? key}) : super(key: key);

  @override
  _MobileMySignatureScreenState createState() =>
      _MobileMySignatureScreenState();
}

class _MobileMySignatureScreenState extends State<MobileMySignatureScreen> {
  String? signatureUrl;

  @override
  void initState() {
    super.initState();
    _loadSignature();
  }

  // Load the user's signature URL from Firestore
  Future<void> _loadSignature() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance
          .collection('userSignatures')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        setState(() {
          signatureUrl = doc.data()?['signatureUrl'];
          //  print('Signature URL: $signatureUrl'); // Debugging line
        });
      } else {
        print('No signature found for this user.');
      }
    } catch (e) {
      print('Error loading signature: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HeaderDrawer(),
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "My Signature",
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            if (signatureUrl != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black),
                ),
                width: 300,
                height: 300,
                child: Image.network(
                  signatureUrl!,
                  // fit: BoxFit.cover, // Commented out to maintain aspect ratio
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading image: $error'); // Debugging line
                    return const Center(
                      child: Text(
                        'Error loading image',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  },
                ),
              )
            else
              const Center(
                child: Text('No signature found'),
              ),
            const SizedBox(width: 50),
            Column(
              children: [
                const Text(
                  "Edit",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 10),
                BodyButton(
                  label: "Make Sign",
                  btnIcn: Icons.brush,
                  icnClr: Colors.white,
                  labelClr: Colors.white,
                  btnClr: Colors.deepOrangeAccent,
                  buttonfunction: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MakeSignature(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
