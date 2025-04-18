import 'package:calculator_try/button_values.dart';
import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String number1 = "";
  String operand = "";
  String number2 = "";
  double output = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0 ,top: 24),
              child: Text(
                output != 0
                  ? "$output"
                  : ("$number1$operand$number2".isEmpty ? "0" : "$number1$operand$number2"),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Wrap(
          children: Btn.buttonValues
            .map(
              (e) => SizedBox(
                width: screenSize.width/4,
                height: 60,
                child: generateButtons(e))
            )
            .toList(),
        ),
      ]),
      ),
    );
  }
  Widget generateButtons(value){
    return Padding(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
            ),
          backgroundColor: [Btn.clr, Btn.del].contains(value)
            ? Colors.red
            : [Btn.multiply,Btn.divide,Btn.add,Btn.subtract,Btn.per,Btn.calculate].contains(value)
              ? Colors.green
              : Colors.black
        ),
        onPressed: (){
          clickButton(value);
        }, 
        child: Text(value)
      ),
    );
  }

void clickButton(String value) {
  setState(() {
    if (number1.isEmpty && int.tryParse(value) != null) {
      number1 = value;
      print("number1: $number1");
    } else if (number1.isNotEmpty && int.tryParse(value) == null && value != Btn.calculate && value != Btn.clr && value != Btn.del) {
      operand = value;
      print("operand: $operand");
    } else if (number1.isNotEmpty && operand.isNotEmpty && number2.isEmpty && int.tryParse(value) != null) {
      number2 = value;
      print("number2: $number2");
    } else if (value == Btn.del || value == Btn.clr){
      number1 = "";
      operand = "";
      number2 = "";
      output = 0;
    }

    if (value == Btn.calculate && number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      double num1 = double.tryParse(number1) ?? 0;
      print("num1: $num1");
      double num2 = double.tryParse(number2) ?? 0;
      print("num2: $num2");

      if (operand == Btn.add) {
        output = num1 + num2;
      } else if (operand == Btn.subtract) {
        output = num1 - num2;
      } else if (operand == Btn.multiply) {
        output = num1 * num2;
      } else if (operand == Btn.divide) {
        output = (num2 != 0) ? num1 / num2 : 0;
      }
      print("output: $output");
    }
  });
} 
}