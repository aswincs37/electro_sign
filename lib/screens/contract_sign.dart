import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrosign/screens/manage_contracts_screens.dart';
import 'package:electrosign/screens/mobile/mobile_manage_contracts_screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContractSign extends StatefulWidget {
  final String documentUrl;
  final String docName;

  const ContractSign({
    required this.documentUrl,
    required this.docName,
    super.key,
  });

  @override
  State<ContractSign> createState() => _ContractSignState();
}

class _ContractSignState extends State<ContractSign> {
  bool isUploading = false;
  Uint8List? exportedImage;
  String? signatureUrl;
  String? documentUrl;
  bool showSignedDocument = false;
  DateTime dateTimeNow = DateTime.now();
  final GlobalKey _globalKey = GlobalKey();

  bool addDateAndSign = false;
  int selectedPosition = 1; // 1 for left bottom, 2 for right bottom

  @override
  void initState() {
    super.initState();
    loadSelectedDocument();
    loadSignature();
  }

  Future<void> loadSelectedDocument() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance
          .collection('userDocuments')
          .doc(user!.uid)
          .collection('documents')
          .doc(widget.docName)
          .get();

      if (doc.exists) {
        setState(() {
          documentUrl = doc.data()?['documentUrl'];
        });
      } else {
        print('No document found for this user.');
      }
    } catch (e) {
      print('Error loading document: $e');
    }
  }

  Future<void> loadSignature() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final doc = await FirebaseFirestore.instance
          .collection('userSignatures')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        setState(() {
          signatureUrl = doc.data()?['signatureUrl'];
        });
      } else {
        print('No signature found for this user.');
      }
    } catch (e) {
      print('Error loading signature: $e');
    }
  }

  Future<void> captureAndNavigate() async {
    try {
      setState(() {
        isUploading = true;
      });
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      setState(() {
        exportedImage = pngBytes;
      });

      final user = FirebaseAuth.instance.currentUser;
      final fileName = 'signed_document${DateTime.now()}.png';
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('signedDocuments/${user!.uid}/$fileName');

      final uploadTask = storageRef.putData(exportedImage!);

      await uploadTask;

      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Store to Firestore
      await FirebaseFirestore.instance
          .collection('signedDocument')
          .doc(user.uid)
          .collection('signedDocuments')
          .doc(fileName)
          .set(
        {'signedDocumentUrl': downloadUrl},
        SetOptions(merge: true),
      );

      setState(() {
        isUploading = false;
      });

      // Navigate to the my contracts page
      final screenWidth = MediaQuery.of(context).size.width;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => screenWidth > 1000
              ? const ManageContractScreen()
              : const MobileManageContractScreen(),
        ),
      );
    } catch (e) {
      print('Error capturing image: $e');
      setState(() {
        isUploading = false;
      });
    }
  }

  Future<void> downloadDocument(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the document'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 1, 39, 70),
        title: const Text(
          "Sign To Contract",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (!showSignedDocument)
                Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.network(
                        "https://lottie.host/47cc2ce6-4fbf-43ea-b68a-2491ff00b00b/8DA1yD5Hev.json",
                      ),
                    ),
                    Text(
                      "Click on the button for ElectroSign\n to the selected document!",
                      style: GoogleFonts.rubikMarkerHatch(
                        fontSize: 25,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Add date and sign"),
                        Checkbox(
                          value: addDateAndSign,
                          onChanged: (value) {
                            setState(() {
                              addDateAndSign = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sign on left bottom"),
                        Radio(
                          value: 1,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = value as int;
                            });
                          },
                        ),
                        const Text("Sign on right bottom"),
                        Radio(
                          value: 2,
                          groupValue: selectedPosition,
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = value as int;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber),
                        ),
                        onPressed: () {
                          setState(() {
                            showSignedDocument = true;
                          });
                        },
                        child: Text(
                          "Generate Signed Document",
                          style: GoogleFonts.langar(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (showSignedDocument)
                Center(
                  child: isUploading
                      ? const SizedBox(
                          height: 250,
                        )
                      : RepaintBoundary(
                          key: _globalKey,
                          child: selectedPosition == 1
                              ? Stack(
                                  children: [
                                    if (documentUrl != null)
                                      Image.network(documentUrl!),
                                    if (signatureUrl != null)
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Container(
                                          color: Colors.white,
                                          height: 55,
                                          width: 200,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 200,
                                                child: Image.network(
                                                    signatureUrl!),
                                              ),
                                              if (addDateAndSign)
                                                Text(
                                                  "${dateTimeNow.toLocal()}"
                                                      .split(' ')[0],
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    if (documentUrl != null)
                                      Image.network(documentUrl!),
                                    if (signatureUrl != null)
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: Container(
                                          color: Colors.white,
                                          height: 55,
                                          width: 200,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 200,
                                                child: Image.network(
                                                    signatureUrl!),
                                              ),
                                              if (addDateAndSign)
                                                Text(
                                                  "${dateTimeNow.toLocal()}"
                                                      .split(' ')[0],
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                ),
              if (showSignedDocument)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: isUploading
                      ? const CircularProgressIndicator(
                          strokeAlign: 1.5,
                          strokeWidth: 50,
                          color: Colors.red,
                          backgroundColor: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green[900]),
                                ),
                                onPressed: captureAndNavigate,
                                child: const Text(
                                  "Save File",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            SizedBox(
                              width: 150,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red[900]),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showSignedDocument = false;
                                  });
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
