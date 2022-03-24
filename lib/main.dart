import 'package:trivia_questions/data_service.dart';
import 'package:flutter/material.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _dataService = DataService();

  QuestionResponse? _response;
  bool _showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.quiz_outlined, size: 80),
                const SizedBox(
                  height: 50,
                ),
                if (_response != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        textDisplayBox(
                            _response!.questionInfo!.question.toString()),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: _toggleShowAnswer,
                            child: const Text('Show Answer'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black87,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                        if (_showAnswer)
                          textDisplayBox(
                              _response!.questionInfo!.correctAnswer.toString())
                      ],
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 100,
                  ),
                ),
                ElevatedButton(
                    onPressed: _newQuestion,
                    child: const Text('New Question'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ))
              ],
            ),
          ),
        ));
  }

  void _newQuestion() async {
    final response = await _dataService.getQuestion();
    setState(() => _response = response);
    setState(() => _showAnswer = false);
  }

  void _toggleShowAnswer() {
    setState(() => _showAnswer = true);
  }

  Widget textDisplayBox(String question) {
    return ListTile(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          color: Color(0xffB3ABAB),
          width: 1.0,
        ),
      ),
      tileColor: Colors.white,
      title: Text(question),
    );
  }
}
