import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget operatorButton(String txtop, double sizeF) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 0)),
        child: SizedBox(
          width: 105,
          height: 105,
          child: ElevatedButton(
            onPressed: () {
              calculation(txtop);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey[200])),
            child: Card(
                elevation: 0,
                color: Colors.grey[200],
                child: Align(
                  child: Text(
                    txtop,
                    style: TextStyle(color: Colors.orange, fontSize: sizeF),
                  ),
                )),
          ),
        ));
  }

  Widget numberButton(String txtop, double sizeF) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 0)),
        child: SizedBox(
          width: 105,
          height: 105,
          child: ElevatedButton(
            onPressed: () {
              calculation(txtop);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white)),
            child: Card(
                elevation: 0,
                color: Colors.white,
                child: Align(
                  child: Text(
                    txtop,
                    style: TextStyle(color: Colors.black, fontSize: sizeF),
                  ),
                )),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.orange,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.orange,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ],
        title: Text(
          'Calculator',
          style: TextStyle(
              color: Colors.orange, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.black, fontSize: 35),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberButton('C', 40),
                numberButton('+/-', 40),
                numberButton('%', 40),
                numberButton('DEL', 35),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberButton('7', 40),
                numberButton('8', 40),
                numberButton('9', 40),
                operatorButton('/', 40),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberButton('4', 40),
                numberButton('5', 40),
                numberButton('6', 40),
                operatorButton('x', 40),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberButton('1', 40),
                numberButton('2', 40),
                numberButton('3', 40),
                operatorButton('-', 75),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numberButton('0', 40),
                numberButton('.', 50),
                Container(
                    decoration: BoxDecoration(border: Border.all(width: 0)),
                    child: SizedBox(
                      width: 105,
                      height: 105,
                      child: ElevatedButton(
                        onPressed: () {
                          calculation('=');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                        ),
                        child: Card(
                            elevation: 0,
                            color: Colors.orange,
                            child: Align(
                              child: Text(
                                '=',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                            )),
                      ),
                    )),
                operatorButton('+', 45),
              ],
            )
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';

  dynamic result = '';
  dynamic finalResult = '';
  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      result = '';
      finalResult = '0';
    } else if (btnText == '=') {
      var f = text.replaceAll(RegExp(r'x'), '*');
      Parser math = Parser();
      Expression exp = math.parse(f);
      String yes = exp.evaluate(EvaluationType.REAL, null).toString();
      if (yes.contains('.')) {
        List<String> splitDecimal = yes.split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          finalResult = splitDecimal[0].toString();
        } else {
          finalResult = yes;
        }
      }
      text = '0';
      result = '';
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }
}
