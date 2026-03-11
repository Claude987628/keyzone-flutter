import 'package:flutter/material.dart';
import 'screens/forum_screen.dart';

void main() {
  runApp(const KeyzoneApp());
}

class KeyzoneApp extends StatelessWidget {
  const KeyzoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Keyzone Forum",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ForumScreen(),
    );
  }
}
