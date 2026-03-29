import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/topic_service.dart';

class CreateTopicScreen extends StatefulWidget {
  final int forumId;

  const CreateTopicScreen({super.key, required this.forumId});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  bool loading = false;

  Future<void> createTopic() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Remplis le titre et le message")),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    final success = await TopicService.createTopic(
      forumId: widget.forumId,
      title: title,
      content: content,
      author: "Jean",
    );

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de la création du topic")),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3ECF8),
        elevation: 0,
        title: const Text(
          "Créer un topic",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Titre du topic"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Message"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : createTopic,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Créer"),
            ),
          ],
        ),
      ),
    );
  }
}
