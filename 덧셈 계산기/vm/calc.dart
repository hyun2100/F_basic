class Calculator {
  String _expression = "";
  String _result = "0";

  String processInput(String input) {
    if (input == "=") {
      try {
        double evalResult = _evaluateExpression(_expression);
        _result = evalResult.toInt().toString(); // 소수점 제거
        _expression = _result;
      } catch (e) {
        _result = "Error";
        _expression = "";
      }
      // c를 눌렀을때 결과값 0으로 변경
    } else if (input == "C (계산 다시하기)") {
      _expression = "";
      _result = "0";
    } else {
      _expression += input;
      _result = _expression;
    }
    return _result;
  }

  double _evaluateExpression(String expression) {
    List<String> parts = expression.split('+');
    return parts
        .map((part) => double.parse(part.trim()))
        .reduce((a, b) => a + b);
  }
}
