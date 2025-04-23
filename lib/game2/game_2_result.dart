// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class GameResultPage extends StatefulWidget {
//   final bool isSuccess;
//   final int level;
//
//   GameResultPage({required this.isSuccess, required this.level});
//
//   @override
//   _GameResultPageState createState() => _GameResultPageState();
// }
//
// class _GameResultPageState extends State<GameResultPage> {
//   List<bool> starAnimationStates = [false, false, false, false, false];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isSuccess) {
//       _animateStars();
//     }
//   }
//
//   void _animateStars() async {
//     for (int i = 0; i < starAnimationStates.length; i++) {
//       await Future.delayed(Duration(milliseconds: 500));
//       setState(() {
//         starAnimationStates[i] = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xff426586), width: 15),
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                 margin: EdgeInsets.symmetric(vertical: 50),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Text(
//                   "Constitution Chronicles\n Drag To Win",
//                   style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(70),
//                       decoration: BoxDecoration(
//                         color: Color(0xff426586),
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Color(0xff648aae), width: 5),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(height: 30), // Space for stars
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                             decoration: BoxDecoration(
//                               color: Color(0xfffafafa),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               "Level ${widget.level}",
//                               style: TextStyle(color: Color(0xff426586), fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: widget.isSuccess ? Colors.yellow[700] : Colors.redAccent,
//                               foregroundColor: Colors.white,
//                               padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                             ),
//                             child: Text(widget.isSuccess ? "Play Next Level" : "Try Again"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(5, (index) {
//                           return Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 2),
//                             child: Icon(
//                               Icons.star,
//                               color: (widget.isSuccess && starAnimationStates[index]) ? Colors.yellow[700] : Colors.grey,
//                               size: 45,
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//---
// import 'package:flutter/material.dart';
//
// import 'constitution_chronicles.dart';
//
// class GameResultPage extends StatelessWidget {
//   final bool success;
//   final int level;
//
//   GameResultPage({required this.success, required this.level});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(success ? "Congratulations! Level $level Completed!" : "Try Again!"),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ConstitutionChroniclesPage(),
//                       ),
//                     );
//                   },
//                   child: Text(success ? "Play Next Level" : "Try Again"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//---
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sansthaein_samvidhan/word_game_play.dart';
// import 'constitution_chronicles.dart';
//
// class GameResultPage extends StatefulWidget {
//   final bool isSuccess;
//   final int level;
//
//   GameResultPage({required this.isSuccess, required this.level});
//
//   @override
//   _GameResultPageState createState() => _GameResultPageState();
// }
//
// class _GameResultPageState extends State<GameResultPage> {
//   List<bool> starAnimationStates = [false, false, false, false, false];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.isSuccess) {
//       _animateStars();
//     }
//   }
//
//   void _animateStars() async {
//     for (int i = 0; i < starAnimationStates.length; i++) {
//       await Future.delayed(Duration(milliseconds: 500));
//       setState(() {
//         starAnimationStates[i] = true;
//       });
//     }
//   }
//
//   Future<void> navigateToNextLevel() async {
//     final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('SS').get();
//     final List<QueryDocumentSnapshot> docs = snapshot.docs;
//
//     if (docs.isNotEmpty) {
//       final docData = docs.first.data() as Map<String, dynamic>;
//       final String shortDescription = (docData['Short_Description'] ?? "") as String;
//
//       List<String> words = shortDescription.split(" ");
//       words.shuffle();
//
//       bool isSuccess = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ConstitutionChroniclesPage()
//           //     PlayWordGamePage(
//           //   // level: widget.level + 1,
//           //   // words: words,
//           //   // correctSentence: shortDescription,
//           // ),
//         ),
//       );
//
//       if (isSuccess) {
//         setState(() {
//           // Logic to unlock next level
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xff426586), width: 15),
//         ),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//                 margin: EdgeInsets.symmetric(vertical: 50),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Text(
//                   "Constitution Chronicles\n Drag To Win",
//                   style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(70),
//                       decoration: BoxDecoration(
//                         color: Color(0xff426586),
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Color(0xff648aae), width: 5),
//                       ),
//                       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           SizedBox(height: 30),
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
//                             decoration: BoxDecoration(
//                               color: Color(0xfffafafa),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               "Level ${widget.level}",
//                               style: TextStyle(color: Color(0xff426586), fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: widget.isSuccess ? navigateToNextLevel : () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ConstitutionChroniclesPage(),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: widget.isSuccess ? Colors.yellow[700] : Colors.redAccent,
//                               foregroundColor: Colors.white,
//                               padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                             ),
//                             child: Text(widget.isSuccess ? "Play Next Level" : "Try Again"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(5, (index) {
//                           return Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 2),
//                             child: Icon(
//                               Icons.star,
//                               color: (widget.isSuccess && starAnimationStates[index]) ? Colors.yellow[700] : Colors.grey,
//                               size: 45,
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// game_2_result.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sansthaein_samvidhan/game2/game_level_select.dart';

class Game2ResultPage extends StatefulWidget {
  final bool isSuccess;
  final String level;

  const Game2ResultPage({required this.isSuccess, required this.level, Key? key}) : super(key: key);

  @override
  _Game2ResultPageState createState() => _Game2ResultPageState();
}

class _Game2ResultPageState extends State<Game2ResultPage> {
  List<bool> starAnimationStates = [false, false, false, false, false];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (widget.isSuccess) {
      _animateStars();
      _updateUserProgress();
    }
  }

  Future<void> _updateUserProgress() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final userActivityRef = _firestore.collection('user_activity').doc(user.uid);
      final doc = await userActivityRef.get();

      if (!doc.exists) {
        // Create new document if it doesn't exist
        await userActivityRef.set({
          'game_2_level': _getLevelChar(),
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Update existing document
        final currentLevels = doc.data()?['game_2_level'] ?? '';
        if (!currentLevels.contains(_getLevelChar())) {
          await userActivityRef.update({
            'game_2_level': currentLevels + _getLevelChar(),
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print('Error updating user progress: $e');
    }
  }

  String _getLevelChar() {
    switch (widget.level.toLowerCase()) {
      case 'easy':
        return 'E';
      case 'medium':
        return 'M';
      case 'hard':
        return 'H';
      default:
        return '';
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
                  "Guess The Constitution",
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
                              "Level : ${widget.level}",
                              style: TextStyle(color: Color(0xff426586), fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GuessLevelSelectionPage(),
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