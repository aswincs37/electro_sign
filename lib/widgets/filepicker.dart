import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerPage extends StatefulWidget {
  const FilePickerPage({super.key});

  @override
  State<FilePickerPage> createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  FilePickerResult? result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Picker"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Selected Files:", style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(result?.files[index].name ?? 'No files selected');
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: result?.files.length ?? 1,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              FilePickerResult? pickedResult =
                  await FilePicker.platform.pickFiles(allowMultiple: true);
              if (pickedResult != null) {
                setState(() {
                  result = pickedResult;
                });
              }
            },
            child: const Text("Pick Files"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
