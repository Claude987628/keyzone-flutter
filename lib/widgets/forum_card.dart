import 'package:flutter/material.dart';

class ForumCard extends StatelessWidget {
  final String title;
  final String description;

  const ForumCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),

      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

        subtitle: Text(description),

        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
