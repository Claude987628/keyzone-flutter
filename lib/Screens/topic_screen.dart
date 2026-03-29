import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/create_topic_screen.dart';
import 'package:flutter_application_1/Screens/post_screen.dart';
import 'package:flutter_application_1/Services/topic_service.dart';

class TopicScreen extends StatefulWidget {
  final int forumId;

  const TopicScreen({super.key, required this.forumId});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  List topics = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  Future<void> loadTopics() async {
    try {
      debugPrint("forumId reçu = ${widget.forumId}");

      final data = await TopicService.getTopics(widget.forumId);

      debugPrint("topics reçus = $data");

      setState(() {
        topics = data;
        loading = false;
      });
    } catch (e) {
      debugPrint("Erreur topics: $e");
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: Text(
          "Topics forum ${widget.forumId}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFFF3ECF8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : topics.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.forum_outlined, size: 70, color: Colors.grey),
                  SizedBox(height: 12),
                  Text(
                    "Aucun topic disponible",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Ajoute un topic avec le bouton +",
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF7B5CFF),
                      child: Icon(Icons.forum, color: Colors.white),
                    ),
                    title: Text(
                      topic["title"] ?? "Sans titre",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic["content"] ?? "",
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Auteur : ${topic["author"] ?? "Utilisateur"}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${topic["replies_count"] ?? 0} réponses",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF7B5CFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0xFF7B5CFF),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostScreen(
                            topicId: topic["id"] ?? 0,
                            title: topic["title"] ?? "Topic",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7B5CFF),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateTopicScreen(forumId: widget.forumId),
            ),
          );

          if (result == true) {
            loadTopics();
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
