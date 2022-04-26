// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

typedef ImageButtonOnTap = void Function(int score);

class ImageButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  ImageButton(
      {required this.correctAnswer, required this.val, required this.onTap});

  int correctAnswer = 0;
  int val = 0;
  ImageButtonOnTap onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          var message = "Your answer is wrong";
          var ansColors = Colors.red;
          var score = 0;
          if (correctAnswer == val) {
            message = "Your answer is correct";
            ansColors = Colors.green;
            score = 10;
          }
          onTap(score);

          final snackBar = SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 1),
            backgroundColor: ansColors,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Ink(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('/images/$val.png'),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
