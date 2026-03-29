import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/forum_service.dart';
import 'package:flutter_application_1/Screens/topic_screen.dart';
import 'package:flutter_application_1/theme/app_colors.dart';

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

  Future loadForums() async {
    final data = await ForumService.getForums();

    setState(() {
      forums = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Keyzone Forum"),
        centerTitle: true,
        elevation: 0,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: forums.length,

              itemBuilder: (context, index) {
                final forum = forums[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.white),
                    ),

                    title: Text(
                      forum["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    subtitle: Text(
                      forum["description"],
                      style: TextStyle(color: Colors.grey[600]),
                    ),

                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TopicScreen(forumId: forum["id"]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
