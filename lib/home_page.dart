import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/buttons.dart';
import 'history.dart';
import 'package:math_expressions/math_expressions.dart';
import 'history_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var userQuestion = '';
var userAnswer = '';

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'HIS',
    '=',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.deepPurple[100],
              appBar:
              AppBar(
                backgroundColor: Colors.deepPurple[400],
                title: Text(
                  'Calculator',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text(userQuestion, style: TextStyle(fontSize: 30),)),
                        Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.centerRight,
                            child: Text(userAnswer, style: TextStyle(fontSize: 30)))
                      ],
                    ),
                  )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: GridView.builder(
                          itemCount: buttons.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                                mainAxisExtent: 88,
                                crossAxisSpacing: 3,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            //clear button
                            if (index == 0) {
                              return MyButton(
                                buttonTapped: (){
                                  setState(() {
                                    userQuestion ='';
                                    userAnswer = '';
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.green,
                                textColor: Colors.white,
                              );
                            }
                            // delete button
                            else if (index == 1) {
                              return MyButton(
                                buttonTapped: (){
                                  setState(() {
                                    userQuestion = userQuestion.substring(0,userQuestion.length-1);
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.red,
                                textColor: Colors.white,
                              );
                            }

                            //equals button
                            else if (index == buttons.length-1) {
                              return MyButton(
                                buttonTapped: (){
                                  setState(() {
                                    equalPressed();
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.deepPurple,
                                textColor: Colors.white,
                              );
                            }
                            //history button
                            else if (index == buttons.length-2) {
                              return MyButton(
                                buttonTapped: (){
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => History())
                                  );
                                },
                                buttonText: buttons[index],
                                color: Colors.white,
                                textColor: Colors.deepPurple,
                              );
                            }
                            //equal button
                            else
                              return MyButton(
                                buttonTapped: (){
                                  setState(() {
                                    userQuestion += buttons[index];
                                  });
                                },
                                buttonText: buttons[index],
                                color: isOperator(buttons[index])
                                    ? Colors.deepPurple
                                    : Colors.deepPurple[50],
                                textColor: isOperator(buttons[index])
                                    ? Colors.white
                                    : Colors.deepPurple,
                              );
                          }),
                    ),
                  ),
                ],
              ),
            );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
    Provider.of<HistoryModel>(context, listen : false).addToHistory('$userQuestion = $userAnswer');
  }

}
