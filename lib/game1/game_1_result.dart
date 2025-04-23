import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sansthaein_samvidhan/game1/constitution_chronicles.dart';

class GameResultPage extends StatefulWidget {
  final bool isSuccess;
  final int level;

  const GameResultPage({required this.isSuccess, required this.level, Key? key}) : super(key: key);

  @override
  _GameResultPageState createState() => _GameResultPageState();
}

class _GameResultPageState extends State<GameResultPage> {
  List<bool> starAnimationStates = [false, false, false, false, false];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.isSuccess) {
      _animateStars();
      _updateLevelProgress();
    }
  }

  // Future<void> _updateLevelProgress() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user == null) return;
  //
  //     // Get the user_activity document for the current user
  //     final userActivityDoc = await _firestore
  //         .collection('user_activity')
  //         .where('user_id', isEqualTo: user.uid)
  //         .get();
  //
  //     if (userActivityDoc.docs.isNotEmpty) {
  //       final docId = userActivityDoc.docs.first.id;
  //       final currentLevel = widget.level;
  //
  //       // Update the game_1_level_count only if the completed level is higher than current
  //       await _firestore.collection('user_activity').doc(docId).update({
  //         'game_1_level_count': FieldValue.increment(1),
  //       });
  //     }
  //   } catch (e) {
  //     print('Error updating level progress: $e');
  //   }
  // }

  // Modify the _updateLevelProgress method to only update if it's a new level completion
  Future<void> _updateLevelProgress() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      // Get the user_activity document for the current user
      final userActivityDoc = await _firestore
          .collection('user_activity')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (userActivityDoc.docs.isNotEmpty) {
        final docId = userActivityDoc.docs.first.id;
        final data = userActivityDoc.docs.first.data();
        final currentMaxLevel = (data['game_1_level_count'] ?? 0) + 1;

        // Only update if this is a new level completion
        if (widget.level >= currentMaxLevel) {
          await _firestore.collection('user_activity').doc(docId).update({
            'game_1_level_count': widget.level, // Set directly to avoid increment issues
          });
        }
      }
    } catch (e) {
      print('Error updating level progress: $e');
    }
  }

  void _animateStars() async {
    for (int i = 0; i < starAnimationStates.length; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        starAnimationStates[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff426586), width: 15),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                margin: EdgeInsets.symmetric(vertical: 50),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Constitution Chronicles\n Drag To Win",
                  style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(70),
                      decoration: BoxDecoration(
                        color: Color(0xff426586),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xff648aae), width: 5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                            decoration: BoxDecoration(
                              color: Color(0xfffafafa),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "Level ${widget.level}",
                              style: TextStyle(color: Color(0xff426586), fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.isSuccess
                                      ? ConstitutionChroniclesPage(completedLevel: widget.level)
                                      : ConstitutionChroniclesPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.isSuccess ? Colors.yellow[700] : Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                            ),
                            child: Text(widget.isSuccess ? "Play Next Level" : "Try Again"),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              Icons.star,
                              color: (widget.isSuccess && starAnimationStates[index])
                                  ? Colors.yellow[700]
                                  : Colors.grey,
                              size: 45,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}