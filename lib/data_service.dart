import 'dart:convert';
import 'package:trivia_questions/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<QuestionResponse?> getQuestion() async {
    const url = "https://opentdb.com/api.php?amount=1&type=boolean";

    final response = await http.get(Uri.parse(url));

    print(response.body);
    final json = jsonDecode(response.body);
    return QuestionResponse.fromJson(json);
  }
}
