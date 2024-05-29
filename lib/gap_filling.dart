import 'package:flutter/material.dart';


class FillInTheBlankPage extends StatefulWidget {
  @override
  _FillInTheBlankPageState createState() => _FillInTheBlankPageState();
}

class _FillInTheBlankPageState extends State<FillInTheBlankPage> {
  String fillInTheBlank = "It's too ___";
  String correctAnswer = "good";
  String selectedOption = "";
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the Blank'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            fillInTheBlank,
            style: TextStyle(fontSize: 20, decoration: selectedOption.isNotEmpty ? TextDecoration.none : TextDecoration.underline),
          ),
          SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            children: ["good", "food", "boy", "girl"].map((option) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = option;
                      fillInTheBlank = "It's too $selectedOption";
                      isCorrect = selectedOption == correctAnswer;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == option ? Colors.grey : Colors.blue,
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = "";
                    fillInTheBlank = "It's too ___";
                  });
                },
                child: Text('取消'),
              ),
              ElevatedButton(
                onPressed: () {
                  _showResultDialog();
                },
                child: Text('确认'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isCorrect ? '回答正确' : '回答错误'),
          content: Text(isCorrect ? '恭喜，你选择了正确的答案！' : '很抱歉，你选择了错误的答案。'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('关闭'),
            ),
          ],
        );
      },
    );
  }
}