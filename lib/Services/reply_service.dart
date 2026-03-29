import 'dart:convert';
import 'package:http/http.dart' as http;

class ReplyService {
  static Future<List> getReplies(int topicId) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/replies/$topicId"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  static Future<bool> createReply({
    required int topicId,
    required String content,
    required String author,
  }) async {
    final response = await http.post(
      Uri.parse("http://127.0.0.1:8000/api/replies"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "topic_id": topicId,
        "content": content,
        "author": author,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}
