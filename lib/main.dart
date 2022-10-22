import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String equation = "0";
  String result = "";
  String expression = "";
  double equationFountSize = 38;
  double resultFountSize = 48;

  buttonPress(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "";
        equationFountSize = 38;
        resultFountSize = 48;
      } else if (buttonText == "⌫") {
        equationFountSize = 48;
        resultFountSize = 38;
        equation = equation.substring(0, equation.length - 1);

        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFountSize = 38;
        resultFountSize = 48;

        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFountSize = 48;
        resultFountSize = 38;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.black,
          )),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFountSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: resultFountSize,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      _button("C", 1, Colors.orange),
                      _button("⌫", 1, Colors.orange),
                      _button("÷", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      _button("7", 1, Colors.grey),
                      _button("8", 1, Colors.grey),
                      _button("9", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      _button("4", 1, Colors.grey),
                      _button("5", 1, Colors.grey),
                      _button("6", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      _button("1", 1, Colors.grey),
                      _button("2", 1, Colors.grey),
                      _button("3", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      _button(".", 1, Colors.grey),
                      _button("0", 1, Colors.grey),
                      _button("00", 1, Colors.grey),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      _button("x", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      _button("-", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      _button("+", 1, Colors.orange),
                    ]),
                    TableRow(children: [
                      _button("=", 2, Colors.orange),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _button(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
          ),
          padding: const EdgeInsets.all(16),
          onPressed: () => buttonPress(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          )),
    );
  }
}
