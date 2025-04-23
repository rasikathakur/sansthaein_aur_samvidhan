// game_level_select.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sansthaein_samvidhan/game2/guess_easy.dart';
import 'package:sansthaein_samvidhan/game2/guess_hard.dart';
import 'package:sansthaein_samvidhan/game2/guess_medium.dart';
import 'package:sansthaein_samvidhan/header_ss.dart';

class GuessLevelSelectionPage extends StatefulWidget {
  @override
  _GuessLevelSelectionPageState createState() => _GuessLevelSelectionPageState();
}

class _GuessLevelSelectionPageState extends State<GuessLevelSelectionPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _completedLevels = '';

  @override
  void initState() {
    super.initState();
    _fetchUserProgress();
  }

  Future<void> _fetchUserProgress() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final doc = await _firestore.collection('user_activity').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          _completedLevels = doc.data()?['game_2_level'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user progress: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  gameButton(context, "EASY", CrosswordEasyPuzzlePage(), _completedLevels.contains('E')),
                  SizedBox(height: 20),
                  gameButton(context, "MEDIUM", CrosswordMediumPuzzlePage(), _completedLevels.contains('M')),
                  SizedBox(height: 20),
                  gameButton(context, "HARD", CrosswordHardPuzzlePage(), _completedLevels.contains('H')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gameButton(BuildContext context, String title, Widget page, bool isCompleted) {
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
            color: Color(0xfffafafa),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isCompleted ? Colors.green : Color(0xff426586),
              width: 5,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xff426586),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (isCompleted)
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.check_circle, color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}