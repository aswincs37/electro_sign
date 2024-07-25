import 'package:electrosign/widgets/commonAppbar.dart';
import 'package:electrosign/widgets/document_upload.dart';
//import 'package:electrosign/widgets/filepicker.dart';
import 'package:electrosign/widgets/side_navbar.dart';
import 'package:electrosign/widgets/signature_pad.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Upload Files",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 22,
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
                              return SelectAndUploadDocument();
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
                            builder: (context) => MakeSignature(),
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
                  GestureDetector(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 110,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload, size: 50),
                            SizedBox(height: 10),
                            Text(
                              "Upload Your \nSignature",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
