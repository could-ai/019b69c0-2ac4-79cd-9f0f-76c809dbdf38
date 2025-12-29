import 'package:flutter/material.dart';
import '../utils/constants.dart';

class OfflineDashboard extends StatelessWidget {
  const OfflineDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Offline Downloads"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You are offline. Practice available.",
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.file_download, color: AppColors.primary),
                    title: Text("Downloaded PDFs"),
                    subtitle: Text("0 files"),
                  ),
                  ListTile(
                    leading: Icon(Icons.video_library, color: AppColors.primary),
                    title: Text("Saved Videos"),
                    subtitle: Text("0 videos"),
                  ),
                  ListTile(
                    leading: Icon(Icons.quiz, color: AppColors.primary),
                    title: Text("Offline Practice Questions"),
                    subtitle: Text("Start Practice"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
