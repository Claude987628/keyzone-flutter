import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/reply_service.dart';

class PostScreen extends StatefulWidget {
  final int topicId;
  final String title;

  const PostScreen({super.key, required this.topicId, required this.title});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List replies = [];
  bool loading = true;
  bool sending = false;

  final TextEditingController replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadReplies();
  }

  Future<void> loadReplies() async {
    try {
      final data = await ReplyService.getReplies(widget.topicId);

      setState(() {
        replies = data;
        loading = false;
      });
    } catch (e) {
      debugPrint("Erreur replies: $e");
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> addReply() async {
    final content = replyController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      sending = true;
    });

    final success = await ReplyService.createReply(
      topicId: widget.topicId,
      content: content,
      author: "Jean",
    );

    if (!mounted) return;

    setState(() {
      sending = false;
    });

    if (success) {
      replyController.clear();
      loadReplies();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'envoi de la réponse")),
      );
    }
  }

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3ECF8),
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : replies.isEmpty
                ? const Center(child: Text("Aucune réponse pour ce topic"))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: replies.length,
                    itemBuilder: (context, index) {
                      final reply = replies[index];

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
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            reply["author"] ?? "Utilisateur",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              reply["content"] ?? "",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: replyController,
                    decoration: InputDecoration(
                      hintText: "Écrire une réponse...",
                      filled: true,
                      fillColor: const Color(0xFFF5F5F7),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF7B5CFF),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: sending
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send, color: Colors.white),
                    onPressed: sending ? null : addReply,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
