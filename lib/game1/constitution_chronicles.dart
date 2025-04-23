import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sansthaein_samvidhan/game1/word_game_play.dart';
import 'package:sansthaein_samvidhan/demo.dart';

class ConstitutionChroniclesPage extends StatefulWidget {
  final int? completedLevel;

  const ConstitutionChroniclesPage({this.completedLevel, Key? key}) : super(key: key);

  @override
  _ConstitutionChroniclesPageState createState() => _ConstitutionChroniclesPageState();
}

class _ConstitutionChroniclesPageState extends State<ConstitutionChroniclesPage> {
  List<bool> levelCompleted = List.filled(88, false);
  List<bool> levelUnlocked = List.generate(88, (index) => index == 0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentMaxLevel = 1;

  @override
  void initState() {
    super.initState();
    _fetchUserProgress();
    if (widget.completedLevel != null) {
      _updateLocalProgress(widget.completedLevel!);
    }
  }
  Color getButtonColor(bool isCompleted, bool isUnlocked) {
    if (isCompleted) return Colors.white; // White for completed
    if (isUnlocked) return Colors.white;  // White for unlocked but not completed
    return Colors.grey;                   // Grey for locked
  }


  Future<void> _fetchUserProgress() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final userActivityDoc = await _firestore
          .collection('user_activity')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (userActivityDoc.docs.isNotEmpty) {
        final data = userActivityDoc.docs.first.data();
        final completedLevels = data['game_1_level_count'] ?? 0;

        setState(() {
          _currentMaxLevel = completedLevels + 1; // +1 because levels start at 1
          // Mark all levels up to completedLevels as completed
          for (int i = 0; i < completedLevels; i++) {
            levelCompleted[i] = true;
          }
          // Unlock the next level after the last completed one
          if (completedLevels < 88) {
            levelUnlocked[completedLevels] = true;
          }
        });
      }
    } catch (e) {
      print('Error fetching user progress: $e');
    }
  }

  void _updateLocalProgress(int completedLevel) {
    setState(() {
      // Mark the completed level as completed
      levelCompleted[completedLevel - 1] = true;
      // Unlock the next level if it exists
      if (completedLevel < 88) {
        levelUnlocked[completedLevel] = true;
      }
    });
  }

  Future<void> playLevel(int index) async {
    if (!levelUnlocked[index]) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayWordGamePage(
          level: index + 1,
        ),
      ),
    );

    if (result != null && result == true) {
      _updateLocalProgress(index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            width: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Constitution Chronicles \nDrag To Win",
                style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: 88,
              itemBuilder: (context, index) {
                final isCompleted = levelCompleted[index];
                final isUnlocked = levelUnlocked[index];
                final isCurrentLevel = index + 1 == _currentMaxLevel;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xff648aae),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("LEVEL ${index + 1}",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(Icons.star,
                              color: isCompleted ? Colors.amber : Colors.grey,
                              size: 20);
                        }),
                      ),
                      // ElevatedButton(
                      //   onPressed: isUnlocked ? () => playLevel(index) : null,
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: isUnlocked ? Colors.white : Colors.grey,
                      //     foregroundColor: Color(0xff426586),
                      //   ),
                      //   child: Text(
                      //     isCompleted ? "Completed" :
                      //     isCurrentLevel ? "Play" : "Locked",
                      //   ),
                      // ),
                      // Update the ElevatedButton style in the ListView.builder
                      // ElevatedButton(
                      //   onPressed: isUnlocked ? () => playLevel(index) : null,
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: isCompleted ? Colors.white : // White for completed
                      //     isUnlocked ? Colors.white : Colors.grey, // White for unlocked
                      //     foregroundColor: Color(0xff426586),
                      //   ),
                      //   child: Text(
                      //     isCompleted ? "Completed" :
                      //     isCurrentLevel ? "Play" : "Locked",
                      //   ),
                      // ),
                      // Update the ElevatedButton style in the ListView.builder
                      ElevatedButton(
                        onPressed: (isCompleted || isUnlocked) ? () => playLevel(index) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: getButtonColor(isCompleted, isUnlocked),
                          foregroundColor: Color(0xff426586),
                        ),
                        child: Text(
                          isCompleted ? "Completed" :
                          isCurrentLevel ? "Play" : "Locked",
                        ),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}