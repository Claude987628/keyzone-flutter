import 'dart:convert';
import 'package:http/http.dart' as http;

class ForumService {
  static const String url = "http://localhost:8000/api/forums";

  static Future<List> getForums() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erreur API");
    }
  }
}
