import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String message;
  final String date;

  const PostCard({
    super.key,
    required this.username,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(date, style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const SizedBox(height: 10),

            Text(message),
          ],
        ),
      ),
    );
  }
}
