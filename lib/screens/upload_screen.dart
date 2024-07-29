import 'package:electrosign/widgets/commonAppbar.dart';
import 'package:electrosign/widgets/document_upload.dart';
import 'package:electrosign/widgets/header_drawer.dart';
import 'package:electrosign/widgets/side_navbar.dart';
import 'package:electrosign/widgets/signature_pad.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HeaderDrawer(),
      appBar: const CommonAppBar(),
      body: Row(
        children: [
          const SizedBox(
            width: 200,
            child: SideNavBar(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Uploads",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SelectAndUploadDocument();
                            },
                          );
                        },
                        child: const CircleAvatar(
                          radius: 110,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, size: 50),
                                SizedBox(height: 10),
                                Text(
                                  "Upload Document",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 80),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MakeSignature(),
                          ));
                        },
                        child: const CircleAvatar(
                          radius: 110,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.brush, size: 50),
                                SizedBox(height: 10),
                                Text(
                                  "Create Your ElectroSign",
                                  style: TextStyle(fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
