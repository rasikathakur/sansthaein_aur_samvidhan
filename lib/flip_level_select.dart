import 'package:flutter/material.dart';
import 'flipcardgame.dart';
import 'guess_easy.dart';
import 'guess_hard.dart';
import 'guess_medium.dart';
import 'header_ss.dart';

class FlipLevelSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        // Adding the gradient background to the entire page
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff426586), Color(0xff648aae)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(height: 50),
            CustomHeader(title: 'Select Level'),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  gameButton(context, "EASY", FlipCardGame(level: 'easy')),
                  SizedBox(height: 20),
                  gameButton(context, "MEDIUM", FlipCardGame(level: 'medium')), //GuessConstitutionPage()
                  SizedBox(height: 20),
                  gameButton(context, "HARD", FlipCardGame(level: 'hard')), //FlipCardsPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameButton(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 300,
          height: 85,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xfffafafa), // Setting background color to #fafafa
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color(0xff426586), width: 5),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xff426586), // Blue text color
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
