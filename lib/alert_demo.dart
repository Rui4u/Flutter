import 'package:flutter/material.dart';

class AlertDemo extends StatefulWidget {
  @override
  _AlertDemo createState() => _AlertDemo();
}

class _AlertDemo extends State<AlertDemo> {
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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isCorrect ? '回答正确' : '回答错误',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                isCorrect ? '恭喜，你选择了正确的答案！' : '很抱歉，你选择了错误的答案。',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('关闭'),
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
    );
  }
}
