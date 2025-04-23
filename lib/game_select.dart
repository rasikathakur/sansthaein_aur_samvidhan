import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansthaein_samvidhan/game3/flip_level_select.dart';
import 'package:sansthaein_samvidhan/game1/constitution_chronicles.dart';
import 'package:sansthaein_samvidhan/game2/game_level_select.dart';

class GameSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          gameButton(context, "Constitution Chronicles Drag to Win".tr, ConstitutionChroniclesPage()),
          SizedBox(height: 20),
          gameButton(context, "Guess the Constitution".tr, GuessLevelSelectionPage()), //GuessConstitutionPage()
          SizedBox(height: 20),
          gameButton(context, "Flip Cards".tr, FlipLevelSelectionPage()), //FlipCardsPage()
        ],
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
              gradient: LinearGradient(
                colors: [Color(0xff426586), Color(0xff648aae)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(
              title.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),)
    );
  }
}
