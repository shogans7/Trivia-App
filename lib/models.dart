/*
{
	"response_code":0,
	"results": [ { 
 		"category": "Entertainment: Books",
 		"type": "boolean",
		"difficulty": "easy",
		"question":"&quot;Elementary, my dear Watson&quot; is a phrase that is never truly said within the Conan Doyle books of Sherlock Holmes.",
		"correct_answer":"True",
		"incorrect_answers":["False"]
	} ]
}
*/

class QuestionInfo {
  final String? question;
  final String? correctAnswer;

  QuestionInfo({this.question, this.correctAnswer});

  factory QuestionInfo.fromJson(Map<String, dynamic> json) {
    // Sometimes the json response from the question returns jumbles of characters in place of qoutation marks or apostrophes, so just brute forced a cleanup
    String replace6LongAt({String? oldString, int? index, String? newChar}) {
      return oldString!.substring(0, index) +
          newChar! +
          oldString.substring(index! + 6);
    }

    String replace7LongAt({String? oldString, int? index, String? newChar}) {
      return oldString!.substring(0, index) +
          newChar! +
          oldString.substring(index! + 7);
    }

    String question = json['question'];

    // choose to use three different while loops rather than one with three conditions to avoid a mess of if statements
    while (question.contains("&quot;")) {
      int index = question.indexOf("&quot;");
      question =
          replace6LongAt(oldString: question, index: index, newChar: "\"");
    }
    while (question.contains("&#039;")) {
      int index = question.indexOf("&#039;");
      question =
          replace6LongAt(oldString: question, index: index, newChar: "'");
    }
    while (question.contains("&rsquo;")) {
      int index = question.indexOf("&rsquo;");
      question =
          replace7LongAt(oldString: question, index: index, newChar: "'");
    }

    final correctAnswer = json['correct_answer'];

    print(question);
    print(correctAnswer);

    return QuestionInfo(question: question, correctAnswer: correctAnswer);
  }
}

class QuestionResponse {
  final QuestionInfo? questionInfo;

  QuestionResponse({this.questionInfo});

  factory QuestionResponse.fromJson(Map<String, dynamic> json) {
    final questionInfoJson = json['results'][0];
    print(questionInfoJson.toString());
    final questionInfo = QuestionInfo.fromJson(questionInfoJson);

    return QuestionResponse(questionInfo: questionInfo);
  }
}
