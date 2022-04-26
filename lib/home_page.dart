// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/image_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int correctAnswer = 0;
  int score = 0;

  SharedPreferences? pref;

  Widget imageList(List<int> images) => Column(
      children: images
          .map((val) => ImageButton(
              correctAnswer: correctAnswer,
              val: val,
              onTap: (ans) {
                setState(() {
                  score += ans;
                  saveScore(score);
                });
              }))
          .toList());

  @override
  void initState() {
    super.initState();
    loadScore();
  }

  saveScore(int newScore) async {
    pref = await SharedPreferences.getInstance();

    if (pref != null) {
      await pref?.setInt("score", newScore);
    }
  }

  loadScore() async {
    pref = await SharedPreferences.getInstance();

    if (pref != null) {
      var myscore = pref?.getInt("score");
      if (myscore != null) {
        setState(() {
          score = myscore;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    numbers.shuffle();
    List<int> images = numbers.sublist(0, 3);
    correctAnswer = images[0];
    images.shuffle();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[200],
        title: const Text(
          'Select Number Game',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: RichText(
              text: TextSpan(
                text: 'Select the number  ',
                style: TextStyle(fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text: '$correctAnswer',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            )
                //     child: Text(
                //   'Select the number  $correctAnswer',
                //   style: TextStyle(fontSize: 14),
                // )
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageList(images),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green[300]),
              onPressed: () {
                setState(() {});
              },
              child: Text("Refresh"),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Score is $score'),
          ],
        ),
      ),
    );
  }
}
