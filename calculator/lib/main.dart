import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

var myInput = '';
var myOutput = '';

class _MyHomePageState extends State<MyHomePage> {
  final List<String> buttons = [
    'AC',
    '+',
    '-',
    '%',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'X',
    '1',
    '2',
    '3',
    '=',
    '0',
    '.',
    'del',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Text(
                    myOutput,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  alignment: Alignment.topRight,
                ),
                Container(
                  child: Text(
                    myInput,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  alignment: FractionalOffset.bottomRight,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Button(
                      buttonPressed: () {
                        setState(() {
                          myInput = '';
                          myOutput = '';
                        });
                      },
                      text: buttons[index],
                      color: isButton(buttons[index])
                          ? Colors.orange
                          : Colors.grey,
                      textColor: Colors.white,
                    ),
                  );
                } else if (index == buttons.length - 4) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Button(
                      buttonPressed: () {
                        setState(() {
                          allOutput();
                        });
                      },
                      text: buttons[index],
                      color: isButton(buttons[index])
                          ? Colors.orange
                          : Colors.grey,
                      textColor: Colors.white,
                    ),
                  );
                } else if (index == buttons.length - 1) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Button(
                      buttonPressed: () {
                        setState(() {
                          myInput = myInput.substring(0, myInput.length - 1);
                        });
                      },
                      text: buttons[index],
                      color: isButton(buttons[index])
                          ? Colors.orange
                          : Colors.grey,
                      textColor: Colors.white,
                    ),
                  );
                } else
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Button(
                      buttonPressed: () {
                        setState(() {
                          myInput = myInput + buttons[index];
                        });
                      },
                      text: buttons[index],
                      color: isButton(buttons[index])
                          ? Colors.orange
                          : Colors.grey,
                      textColor: Colors.white,
                    ),
                  );
              },
            )),
          ),
        ],
      ),
    );
  }

  bool isButton(String x) {
    if (x == '/' || x == 'X' || x == '-' || x == '=' || x == '+' || x == '%') {
      return true;
    }
    return false;
  }

  void allOutput() {
    String finalOutput = myInput;
    finalOutput = finalOutput.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalOutput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    myOutput = eval.toStringAsFixed(2);
  }
}
