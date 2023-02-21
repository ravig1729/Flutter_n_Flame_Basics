import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  //final keyword denotes the questionText will not chnage redeclare this in future.
  final String questionText;

  Question(
    this.questionText,
  ); // Question is a constructor and it has the value has stored in String questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
    width:double.infinity,
    margin: EdgeInsets.all(15),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
