import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrosign/widgets/commonAppbar.dart';
import 'package:electrosign/widgets/header_drawer.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileManageContractScreen extends StatefulWidget {
  const MobileManageContractScreen({super.key});

  @override
  State<MobileManageContractScreen> createState() => _MobileManageContractScreenState();
}

class _MobileManageContractScreenState extends State<MobileManageContractScreen> {
   Future<List<Map<String, String>>> fetchUserDocuments() async {
    final user = FirebaseAuth.instance.currentUser;
    final documentsRef = FirebaseFirestore.instance
        .collection('signedDocument')
        .doc(user!.uid)
        .collection('signedDocuments');
    final querySnapshot = await documentsRef.get();

    List<Map<String, String>> documents = [];
    for (var doc in querySnapshot.docs) {
      final url = doc.data()['signedDocumentUrl'] as String;
      final name = doc.id;
      documents.add({'name': name, 'url': url});
    }

    return documents;
  }

  Future<void> downloadDocument(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HeaderDrawer(),
      appBar: const CommonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Contracts",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
                    child: FutureBuilder<List<Map<String, String>>>(
                      future: fetchUserDocuments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error loading documents'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No documents found'));
                        } else {
                          final documents = snapshot.data!;
                          return GridView.builder(
                            itemCount: documents.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              final document = documents[index];
                              final url = document['url']!;
                              final name = document['name']!;
                              return GestureDetector(
                                onTap: () {
                                  downloadDocument(url);

//                                 Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (context) => ContractSign(documentUrl: url,docName: name),
//   ),
// );

                                  print('Tapped on document: $name');
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.black45,
                                        child: Image.network(
                                          url,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.insert_drive_file,
                                              size: 50,
                                              color: Colors.white,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
        ],
      ),
    );
  }
}
