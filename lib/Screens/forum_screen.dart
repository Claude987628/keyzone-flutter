import 'package:flutter/material.dart';
import '../services/forum_service.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  List forums = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadForums();
  }

  Future<void> loadForums() async {
    try {
      final data = await ForumService.getForums();
      setState(() {
        forums = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Keyzone Forum"),
        centerTitle: true,
        elevation: 2,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: forums.length,
              itemBuilder: (context, index) {
                final forum = forums[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.forum, color: Colors.white),
                    ),
                    title: Text(
                      forum['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(forum['description']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      print("Forum cliqué : ${forum['title']}");
                    },
                  ),
                );
              },
            ),
    );
  }
}
