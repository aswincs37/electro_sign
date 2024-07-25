import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MakeSignature extends StatefulWidget {
  const MakeSignature({Key? key}) : super(key: key);

  @override
  State<MakeSignature> createState() => _MakeSignatureState();
}

class _MakeSignatureState extends State<MakeSignature> {
  Uint8List? exportedImage;
  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> saveSignature() async {
    if (exportedImage != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final fileName =
            'signature_${DateTime.now().millisecondsSinceEpoch}.png';
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('signatures/${user!.uid}/$fileName');

        // Upload the signature image
        final uploadTask = storageRef.putData(exportedImage!);
        await uploadTask;

        // Get the download URL
        final downloadUrl = await storageRef.getDownloadURL();

        // Update the URL in Firestore
        await FirebaseFirestore.instance
            .collection('userSignatures')
            .doc(user.uid)
            .set({'signatureUrl': downloadUrl}, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             backgroundColor: Colors.green,
            content: Text(
              'Signature saved successfully!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        print("Error saving signature: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.white,
              content: Text('Failed to save signature: $e',style: TextStyle(color: Colors.red),)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Signature Pad"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Signature(
              controller: controller,
              width: 350,
              height: 200,
              backgroundColor: Colors.lightBlue[100]!,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () async {
                          exportedImage = await controller.toPngBytes();
                          await saveSignature();
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black)))))),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.clear();
                    },
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
