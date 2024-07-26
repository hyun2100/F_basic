import 'package:flutter/material.dart';
import '../vm/calc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Calculator _calculator = Calculator();
  String _output = "0";

  void _onButtonPressed(String buttonText) {
    setState(() {
      _output = _calculator.processInput(buttonText);
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10), // 버튼 간격
        child: OutlinedButton(
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),
          ),
          onPressed: () => _onButtonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' 덧셈 계산기 '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _output,
                      style: const TextStyle(
                          fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // 상하 간격을 좁히기 위해 시작점에 정렬
                children: [
                  Row(children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3")
                  ]),
                  Row(children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6")
                  ]),
                  Row(children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9")
                  ]),
                  Row(children: [
                    _buildButton("0"),
                    _buildButton("+"),
                    _buildButton("=")
                  ]),
                  Row(children: [_buildButton("C (계산 다시하기)")]),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
