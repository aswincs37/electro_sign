import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SelectAndUploadDocument extends StatefulWidget {
  const SelectAndUploadDocument({super.key});

  @override
  State<SelectAndUploadDocument> createState() =>
      _SelectAndUploadDocumentState();
}

class _SelectAndUploadDocumentState extends State<SelectAndUploadDocument> {
  FilePickerResult? result;
  UploadTask? uploadTask;
  String? downloadUrl;
  final documentNameController = TextEditingController();
  bool isUploading = false;

  Future<void> documentPicker() async {
    try {
      final pickedResult = await FilePicker.platform.pickFiles();
      if (pickedResult != null) {
        setState(() {
          result = pickedResult;
        });
      }
    } catch (e) {
      print("Error picking document: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking document: $e')),
      );
    }
  }

  Future<void> uploadFile() async {
    if (result != null && documentNameController.text.trim().isNotEmpty) {
      setState(() {
        isUploading = true;
      });

      try {
        final fileName = documentNameController.text.trim();
        final path =
            'userDocuments/${FirebaseAuth.instance.currentUser!.uid}/$fileName';

        if (kIsWeb) {
          final fileBytes = result!.files.single.bytes!;
          final ref = FirebaseStorage.instance.ref().child(path);
          uploadTask = ref.putData(fileBytes);
        } else {
          final filePath = result!.files.single.path!;
          final file = File(filePath);
          final ref = FirebaseStorage.instance.ref().child(path);
          uploadTask = ref.putFile(file);
        }

        final snapshot = await uploadTask!.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();

        setState(() {
          downloadUrl = urlDownload;
          isUploading = false;
        });

        print('Downloaded URL: $urlDownload');
        await FirebaseFirestore.instance
            .collection('userDocuments')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('documents')
            .doc(fileName)
            .set({'documentUrl': urlDownload}, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'File uploaded successfully!',
                style: TextStyle(color: Colors.white),
              )),
        );
        Navigator.of(context).pop();
      } catch (e) {
        setState(() {
          isUploading = false;
        });
        print("Error uploading file: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Failed to upload file: $e',
                style: TextStyle(color: Colors.white),
              )),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected or document name is empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select and Upload Document'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (result != null)
              if (kIsWeb && result!.files.single.bytes != null)
                CircleAvatar(
                  radius: 100,
                  backgroundImage: MemoryImage(result!.files.single.bytes!),
                )
              else if (result!.files.single.path != null)
                CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(File(result!.files.single.path!)),
                )
              else
                CircleAvatar(
                  radius: 100,
                  child: Icon(
                    Icons.upload_file,
                    size: 50,
                  ),
                ),
            if (result != null)
              TextFormField(
                controller: documentNameController,
                decoration: InputDecoration(
                  hintText: "Enter document name",
                ),
              ),
            const SizedBox(height: 20),
            if (result == null)
              ElevatedButton(
                onPressed: documentPicker,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Select Document"),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isUploading ? null : uploadFile,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: isUploading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text("Upload Document"),
            ),
            if (isUploading) const SizedBox(height: 20),
            if (isUploading) const Text("Uploading..."),
          ],
        ),
      ),
    );
  }
}
