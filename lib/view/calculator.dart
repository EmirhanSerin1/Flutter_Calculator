import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child:
                Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize)),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton("C", 1, Colors.redAccent.shade700, context),
                      buildButton("⌫", 1, Colors.redAccent.shade700, context),
                      buildButton("/", 1, Colors.blue, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton("7", 1, Colors.grey.shade700, context),
                      buildButton("8", 1, Colors.grey.shade700, context),
                      buildButton("9", 1, Colors.grey.shade700, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton("4", 1, Colors.grey.shade700, context),
                      buildButton("5", 1, Colors.grey.shade700, context),
                      buildButton("6", 1, Colors.grey.shade700, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton("1", 1, Colors.grey.shade700, context),
                      buildButton("2", 1, Colors.grey.shade700, context),
                      buildButton("3", 1, Colors.grey.shade700, context),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton(".", 1, Colors.grey.shade700, context),
                      buildButton("0", 1, Colors.grey.shade700, context),
                      buildButton("00", 1, Colors.grey.shade700, context),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  buildButton("x", 1, Colors.blue, context),
                  buildButton("-", 1, Colors.blue, context),
                  buildButton("+", 1, Colors.blue, context),
                  buildButton("=", 2, Colors.green.shade700, context)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor,
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(32),
        ),
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        width: MediaQuery.of(context).size.width / 4.17,
        child: TextButton(
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == "⌫") {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          return "Error";
        }
      } else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == buttonText) {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}
