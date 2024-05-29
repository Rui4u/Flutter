import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ButtonColumn(),
      ),
    );
  }
}

class ButtonColumn extends StatefulWidget {
  @override
  _ButtonColumnState createState() => _ButtonColumnState();
}

class _ButtonColumnState extends State<ButtonColumn> {
  int _selectedIndex = 0; // 默认选中的按钮索引

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index; // 更新选中的按钮索引
      appleOne();
    });
  }

  Future<void> appleOne() async {
    MethodChannel _channel = const MethodChannel('plugin_apple');
    final result = await _channel.invokeMethod('apple_one');
    Map map = result as LinkedHashMap<Object?, Object?>;
    print("result: ${map["result"]}");
    print("code: ${map["code"]}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableButton(
              index: i,
              isSelected: _selectedIndex == i,
              onPressed: _onButtonPressed,
            ),
          ),
      ],
    );
  }
}

class SelectableButton extends StatelessWidget {
  final int index;
  final bool isSelected;
  final ValueChanged<int> onPressed;

  SelectableButton({
    required this.index,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey, // 更改背景色
      ),
      child: Text('Button ${index + 1}'),
    );
  }
}
