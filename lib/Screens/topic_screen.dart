import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  final int forumId;

  const TopicScreen({super.key, required this.forumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(title: const Text("Topics"), centerTitle: true),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                "Elden Ring bug",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Posté par utilisateur • 12 réponses"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),

          const SizedBox(height: 10),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text(
                "Cyberpunk conseils",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Posté par utilisateur • 5 réponses"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Créer un nouveau sujet");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
