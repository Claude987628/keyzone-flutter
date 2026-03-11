import 'dart:convert';
import 'package:http/http.dart' as http;

class ForumService {
  static const String url = "http://127.0.0.1:8000/api/forums";

  static Future getForums() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Erreur API");
    }
  }
}
