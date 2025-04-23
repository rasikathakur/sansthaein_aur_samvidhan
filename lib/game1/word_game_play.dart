import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sansthaein_samvidhan/game1/game_1_result.dart';
import 'package:sansthaein_samvidhan/demo.dart';

class PlayWordGamePage extends StatefulWidget {
  final int level;
  // final List<String> words;
  // final String correctSentence;
  //
  PlayWordGamePage({required this.level});
  @override
  _PlayWordGamePageState createState() => _PlayWordGamePageState();
}


class WordInstance {
  final String text;
  final int id;  // Unique identifier for each word instance

  WordInstance(this.text, this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is WordInstance &&
              runtimeType == other.runtimeType &&
              text == other.text &&
              id == other.id;

  @override
  int get hashCode => text.hashCode ^ id.hashCode;
}

class _PlayWordGamePageState extends State<PlayWordGamePage> {
  bool showHint = false;
  List<WordInstance> words = [];
  List<WordInstance> correctOrder = [];
  List<WordInstance> userOrder = [];
  String hintText = "";
  late Stream<QuerySnapshot> _ssStream;
  @override
  void initState() {
    super.initState();
    words.shuffle();
    _ssStream = FirebaseFirestore.instance
        .collection('SS')
        .where('Sr_No', isEqualTo: widget.level)
        .snapshots();

    fetchHint();
    //fetchHint();
    //fetchHint1(); ----
  }



  // Future<void> fetchHint() async {
  //   final response =
  //       await http.get(Uri.parse("https://your-firebase-url.com/sr_no=1"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       hintText = json.decode(response.body)['short_description'];
  //     });
  //   }
  // }

  Future<void> fetchHint() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('SS')
        .where('Sr_No', isEqualTo: widget.level)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final String shortDescription = doc['Short_Description'] ?? "";

      setState(() {
        hintText = shortDescription;
        final wordTexts = shortDescription.split(" ");
        correctOrder = wordTexts.asMap().entries.map((e) => WordInstance(e.value, e.key)).toList();
        words = List.from(correctOrder)..shuffle();

        words = List.from(correctOrder)..shuffle();
      });
    }
  }

  Future<void> fetchHint1() async {
    hintText = "Justice is ensured for all";
  }

  // void checkAnswer() {
  //   bool isCorrect = const ListEquality().equals(userOrder, correctOrder);
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         isCorrect
  //             ? "Success! Move to Next Level"
  //             : "Ohh ooo better luck next time! Please try again",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(color: Colors.white),
  //       ),
  //       backgroundColor: isCorrect ? Colors.green[800] : Colors.red[800],
  //     ),
  //   );
  // }

  void checkAnswer() {
    bool isCorrect = const ListEquality().equals(userOrder, correctOrder);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isCorrect
              ? "Success! Move to Next Level"
              : "Ohh ooo better luck next time! Please try again",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isCorrect ? Colors.green[800] : Colors.red[800],
        duration: Duration(seconds: 1), // Shorter duration for faster transition
      ),
    ).closed.then((_) {
      // This callback runs after the snackbar is closed
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameResultPage(
            isSuccess: isCorrect,
            level: widget.level,
          ),
        ),
      );
    });
  }

  void resetGame() {
    setState(() {
      words.shuffle();
      userOrder.clear();
    });

  }



  Future<void> playHint() async {
    final response =
    await http.get(Uri.parse("http://192.168.137.1:8000/tts?text=$hintText"));
    if (response.statusCode == 200) {
      final player = AudioPlayer();
      await player.play(UrlSource("http://192.168.137.1:8000/tts?text=$hintText"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff426586), width: 15), // Border added
        ),
        child: Stack(children: [
          // Hint Button
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              padding: EdgeInsets.symmetric(vertical: 50),
              icon: Icon(Icons.lightbulb, size: 30, color: Colors.yellow[700]),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setDialogState) {  // Dialog's own state update function
                        return AlertDialog(
                          title: Text("Hint"),
                          content: showHint ? Text(hintText) : null,
                          actions: [
                            TextButton(
                              onPressed: () {
                                setDialogState(() {  // This updates the dialog
                                  showHint = true;
                                });
                              },
                              child: Text("View Hint"),
                            ),
                            TextButton(
                              onPressed: playHint,
                              child: Text("Listen to Hint"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },

            ),
          ),

          SizedBox(height: 20),

          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              margin: EdgeInsets.symmetric(vertical: 150),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Level ${widget.level}",
                style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),


                // Drop Zone
                DragTarget<WordInstance>(
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: 200,
                      width: 320,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Color(0xff426586)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: userOrder.isEmpty
                            ? Text("Drop words here")
                            : Wrap(
                          spacing: 8,
                          children: userOrder.map((wordInstance) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Color(0xfffafafa), // Background color for dropped words
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                wordInstance.text,
                                style: TextStyle(
                                  color: Color(0xff648aae), // Text color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                  onAccept: (wordInstance) {
                    if (!userOrder.contains(wordInstance)) {
                      setState(() {
                        userOrder.add(wordInstance);
                      });
                    }
                  },
                ),


                SizedBox(height: 20),

                // Draggable Words
                Wrap(
                  spacing: 10,
                  children: words.where((wordInstance) => !userOrder.contains(wordInstance)).map((wordInstance) {
                    return Draggable<WordInstance>(
                      data: wordInstance,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xff648aae),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(wordInstance.text, style: TextStyle(color: Colors.white)),
                      ),
                      feedback: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff648aae).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(wordInstance.text, style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      childWhenDragging: Opacity(opacity: 0.5, child: Container()),
                    );
                  }).toList(),
                ),

                SizedBox(height: 20),

                // Buttons
                ElevatedButton(
                  onPressed: userOrder.length == correctOrder.length ? checkAnswer : null,
                  child: Text("Check Answer"),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff426586)),
                ),
                ElevatedButton(
                  onPressed: resetGame,
                  child: Text("Reset"),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff648aae)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:collection/collection.dart';
//
// class PlayWordGamePage extends StatefulWidget {
//   @override
//   _PlayWordGamePageState createState() => _PlayWordGamePageState();
// }
//
// class _PlayWordGamePageState extends State<PlayWordGamePage> {
//   bool showHint = false;
//   List<String> words = ["justice", "for", "all", "ensured", "is"];
//   List<String> correctOrder = ["justice", "is", "ensured", "for", "all"];
//   List<String> userOrder = [];
//   String hintText = "";
//
//   @override
//   void initState() {
//     super.initState();
//     words.shuffle();
//     //fetchHint();
//     fetchHint1();
//   }
//
//   // Future<void> fetchHint() async {
//   //   final response =
//   //       await http.get(Uri.parse("https://your-firebase-url.com/sr_no=1"));
//   //   if (response.statusCode == 200) {
//   //     setState(() {
//   //       hintText = json.decode(response.body)['short_description'];
//   //     });
//   //   }
//   // }
//
//   Future<void> fetchHint1() async {
//     hintText = "Justice is ensured for all";
//   }
//
//   void checkAnswer() {
//     bool isCorrect = const ListEquality().equals(userOrder, correctOrder);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           isCorrect
//               ? "Success! Move to Next Level"
//               : "Ohh ooo better luck next time! Please try again",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: isCorrect ? Colors.green[800] : Colors.red[800],
//       ),
//     );
//   }
//
//   void resetGame() {
//     setState(() {
//       words.shuffle();
//       userOrder.clear();
//     });
//   }
//
//   Future<void> playHint() async {
//     final response =
//     await http.get(Uri.parse("http://192.168.134.1:8000/tts?text=$hintText"));
//     if (response.statusCode == 200) {
//       final player = AudioPlayer();
//       await player.play(UrlSource("http://192.168.134.1:8000/tts?text=$hintText"));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       body: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Color(0xff426586), width: 15), // Border added
//         ),
//         child: Stack(children: [
//           // Hint Button
//           Align(
//             alignment: Alignment.topRight,
//             child: IconButton(
//               padding: EdgeInsets.symmetric(vertical: 50),
//               icon: Icon(Icons.lightbulb, size: 30, color: Colors.yellow[700]),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return StatefulBuilder(
//                       builder: (context, setDialogState) {  // Dialog's own state update function
//                         return AlertDialog(
//                           title: Text("Hint"),
//                           content: showHint ? Text(hintText) : null,
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 setDialogState(() {  // This updates the dialog
//                                   showHint = true;
//                                 });
//                               },
//                               child: Text("View Hint"),
//                             ),
//                             TextButton(
//                               onPressed: playHint,
//                               child: Text("Listen to Hint"),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//               margin: EdgeInsets.symmetric(vertical: 150),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Text(
//                 "Level 1",
//                 style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 40),
//
//                 // Drop Zone
//                 DragTarget<String>(
//                   builder: (context, candidateData, rejectedData) {
//                     return Container(
//                       height: 200,
//                       width: 320,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         border: Border.all(color: Color(0xff426586)),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: userOrder.isEmpty
//                             ? Text("Drop words here")
//                             : Wrap(
//                           spacing: 8,
//                           children: userOrder.map((word) {
//                             return Container(
//                               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                               decoration: BoxDecoration(
//                                 color: Color(0xfffafafa), // Background color for dropped words
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Text(
//                                 word,
//                                 style: TextStyle(
//                                   color: Color(0xff648aae), // Text color
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     );
//                   },
//                   onAccept: (word) {
//                     if (!userOrder.contains(word)) {
//                       setState(() {
//                         userOrder.add(word);
//                       });
//                     }
//                   },
//                 ),
//
//
//                 SizedBox(height: 20),
//
//                 // Draggable Words
//                 Wrap(
//                   spacing: 10,
//                   children: words.where((word) => !userOrder.contains(word)).map((word) {
//                     return Draggable<String>(
//                       data: word,
//                       child: Container(
//                         margin: EdgeInsets.all(5),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Color(0xff648aae),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(word, style: TextStyle(color: Colors.white)),
//                       ),
//                       feedback: Material(
//                         color: Colors.transparent,
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Color(0xff648aae).withOpacity(0.7),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(word, style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       childWhenDragging: Opacity(opacity: 0.5, child: Container()),
//                     );
//                   }).toList(),
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Buttons
//                 ElevatedButton(
//                   onPressed: userOrder.length == correctOrder.length ? checkAnswer : null,
//                   child: Text("Check Answer"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xff426586)),
//                 ),
//                 ElevatedButton(
//                   onPressed: resetGame,
//                   child: Text("Reset"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xff648aae)),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
//---
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:collection/collection.dart';
// import 'constitution_chronicles.dart';
//
// class PlayWordGamePage extends StatefulWidget {
//   final int level;
//   final List<String> words;
//   final String correctSentence;
//
//   PlayWordGamePage({required this.level, required this.words, required this.correctSentence});
//
//   @override
//   _PlayWordGamePageState createState() => _PlayWordGamePageState();
// }
//
// class _PlayWordGamePageState extends State<PlayWordGamePage> {
//   List<String> userOrder = [];
//
//   void checkAnswer() {
//     bool isCorrect = const ListEquality().equals(userOrder, widget.correctSentence.split(" "));
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           isCorrect ? "Success! Move to Next Level" : "Ohh ooo better luck next time! Please try again",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: isCorrect ? Colors.green[800] : Colors.red[800],
//       ),
//     );
//
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameResultPage(success: isCorrect, level: widget.level),
//         ),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       body: Column(
//         children: [
//           DragTarget<String>(
//             builder: (context, candidateData, rejectedData) {
//               return Container(
//                 padding: EdgeInsets.all(12),
//                 height: 80,
//                 width: double.infinity,
//                 color: Colors.grey[200],
//                 child: Center(
//                   child: Text(userOrder.join(" "), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ),
//               );
//             },
//             onAccept: (word) {
//               setState(() {
//                 userOrder.add(word);
//               });
//             },
//           ),
//           Wrap(
//             children: widget.words.map((word) => Draggable<String>(
//               data: word,
//               child: Container(padding: EdgeInsets.all(8), child: Text(word)),
//               feedback: Material(child: Text(word, style: TextStyle(fontSize: 16, color: Colors.blue))),
//             )).toList(),
//           ),
//           ElevatedButton(onPressed: checkAnswer, child: Text("Submit")),
//         ],
//       ),
//     );
//   }
// }
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
// import 'package:audioplayers/audioplayers.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:collection/collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'constitution_chronicles.dart';
// import 'demo.dart';
//
// class PlayWordGamePage extends StatefulWidget {
//   final int level;
//   final List<String> words;
//   final String correctSentence;
//
//   PlayWordGamePage({required this.level, required this.words, required this.correctSentence});
//
//   @override
//   _PlayWordGamePageState createState() => _PlayWordGamePageState();
// }
//
// class _PlayWordGamePageState extends State<PlayWordGamePage> {
//   List<String> userOrder = [];
//   String hintText = "";
//   bool showHint = false;
//
//   @override
//   void initState() {
//     super.initState();
//     widget.words.shuffle();
//     fetchHint();
//   }
//
//   Future<void> fetchHint() async {
//     final response = await FirebaseFirestore.instance.collection('hints').doc(widget.level.toString()).get();
//     if (response.exists) {
//       setState(() {
//         hintText = response["short_description"];
//       });
//     }
//   }
//
//   Future<void> playHint() async {
//     final response = await http.get(Uri.parse("http://192.168.134.1:8000/tts?text=$hintText"));
//     if (response.statusCode == 200) {
//       final player = AudioPlayer();
//       await player.play(UrlSource("http://192.168.134.1:8000/tts?text=$hintText"));
//     }
//   }
//
//   void checkAnswer() {
//     bool isCorrect = const ListEquality().equals(userOrder, widget.correctSentence.split(" "));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           isCorrect ? "Success! Move to Next Level" : "Ohh ooo better luck next time! Please try again",
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: isCorrect ? Colors.green[800] : Colors.red[800],
//       ),
//     );
//
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GameResultPage(isSuccess: isCorrect, level: widget.level),
//         ),
//       );
//     });
//   }
//
//   void resetGame() {
//     setState(() {
//       widget.words.shuffle();
//       userOrder.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       body: Stack(children: [
//         Align(
//           alignment: Alignment.topRight,
//           child: IconButton(
//             padding: EdgeInsets.symmetric(vertical: 50),
//             icon: Icon(Icons.lightbulb, size: 30, color: Colors.yellow[700]),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return StatefulBuilder(
//                     builder: (context, setDialogState) {
//                       return AlertDialog(
//                         title: Text("Hint"),
//                         content: showHint ? Text(hintText) : null,
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               setDialogState(() { showHint = true; });
//                             },
//                             child: Text("View Hint"),
//                           ),
//                           TextButton(
//                             onPressed: playHint,
//                             child: Text("Listen to Hint"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//
//         Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//             margin: EdgeInsets.symmetric(vertical: 150),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Text(
//               "Level ${widget.level}",
//               style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//
//         Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DragTarget<String>(
//                 builder: (context, candidateData, rejectedData) {
//                   return Container(
//                     height: 200,
//                     width: 320,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       border: Border.all(color: Color(0xff426586)),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: userOrder.isEmpty
//                           ? Text("Drop words here")
//                           : Wrap(
//                         spacing: 8,
//                         children: userOrder.map((word) {
//                           return Container(
//                             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                             decoration: BoxDecoration(
//                               color: Color(0xfffafafa),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Text(
//                               word,
//                               style: TextStyle(color: Color(0xff648aae), fontWeight: FontWeight.bold),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   );
//                 },
//                 onAccept: (word) {
//                   if (!userOrder.contains(word)) {
//                     setState(() {
//                       userOrder.add(word);
//                     });
//                   }
//                 },
//               ),
//
//               SizedBox(height: 20),
//               Wrap(
//                 spacing: 10,
//                 children: widget.words.where((word) => !userOrder.contains(word)).map((word) {
//                   return Draggable<String>(
//                     data: word,
//                     child: Container(
//                       margin: EdgeInsets.all(5),
//                       padding: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Color(0xff648aae),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(word, style: TextStyle(color: Colors.white)),
//                     ),
//                     feedback: Material(
//                       color: Colors.transparent,
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Color(0xff648aae).withOpacity(0.7),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(word, style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                     childWhenDragging: Opacity(opacity: 0.5, child: Container()),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(onPressed: userOrder.length == widget.correctSentence.split(" ").length ? checkAnswer : null, child: Text("Check Answer")),
//               ElevatedButton(onPressed: resetGame, child: Text("Reset")),
//             ],
//           ),
//         ),
//       ]),
//     );
//   }
// }
