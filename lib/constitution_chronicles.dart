// import 'package:flutter/material.dart';
//
// class ConstitutionChroniclesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 16, bottom: 16),
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             width: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff426586), Color(0xff648aae)],
//                 begin: Alignment.center,
//                 end: Alignment.center,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Constitution Chronicles \nDrag To Win",
//                 style: TextStyle(
//                   color: Color(0xfffafafa),
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: 88,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Color(0xff648aae),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 5,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "LEVEL ${index + 1}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: List.generate(5, (starIndex) {
//                            return Icon(
//                             Icons.star,
//                             color: Colors.grey,
//                             size: 20,
//                           );
//                         }),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text("Playing Level ${index + 1}")),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Color(0xff426586),
//                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           textStyle: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         child: Text("Play"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//-----

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// class ConstitutionChroniclesPage extends StatefulWidget {
//   @override
//   _ConstitutionChroniclesPageState createState() => _ConstitutionChroniclesPageState();
// }
//
// class _ConstitutionChroniclesPageState extends State<ConstitutionChroniclesPage> {
//   List<bool> levelsEnabled = List.generate(88, (index) => false);
//   List<bool> levelsCompleted = List.generate(88, (index) => false);
//
//   @override
//   void initState() {
//     super.initState();
//     levelsEnabled[0] = true; // Only Level 1 is enabled initially
//     _fetchLevelCompletionStatus();
//   }
//
//   Future<void> _fetchLevelCompletionStatus() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('CompletedLevels').get();
//     for (var doc in snapshot.docs) {
//       int level = doc['level'];
//       if (level >= 1 && level <= 88) {
//         setState(() {
//           levelsCompleted[level - 1] = true;
//           if (level < 88) levelsEnabled[level] = true;
//         });
//       }
//     }
//   }
//
//   void _playLevel(int level) async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance
//         .collection('SS')
//         .where('Sr_No', isEqualTo: level)
//         .limit(1)
//         .get()
//         .then((snapshot) => snapshot.docs.first);
//     String title = doc['Short_Description'];
//     List<String> words = title.split(" ");
//     words.shuffle();
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => WordArrangeGame(level: level, title: title, words: words),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 16, bottom: 16),
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             width: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff426586), Color(0xff648aae)],
//                 begin: Alignment.center,
//                 end: Alignment.center,
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Constitution Chronicles \nDrag To Win",
//                 style: TextStyle(
//                   color: Color(0xfffafafa),
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: 88,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Color(0xff648aae),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 5,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "LEVEL ${index + 1}",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: List.generate(5, (starIndex) {
//                           return Icon(
//                             Icons.star,
//                             color: levelsCompleted[index] ? Colors.amber : Colors.grey,
//                             size: 20,
//                           );
//                         }),
//                       ),
//                       ElevatedButton(
//                         onPressed: levelsEnabled[index] ? () => _playLevel(index + 1) : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Color(0xff426586),
//                           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                           textStyle: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         child: Text("Play"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class WordArrangeGame extends StatefulWidget {
//   final int level;
//   final String title;
//   final List<String> words;
//
//   WordArrangeGame({required this.level, required this.title, required this.words});
//
//   @override
//   _WordArrangeGameState createState() => _WordArrangeGameState();
// }
//
// class _WordArrangeGameState extends State<WordArrangeGame> {
//   List<String> arrangedWords = [];
//   FlutterTts flutterTts = FlutterTts();
//
//   @override
//   void initState() {
//     super.initState();
//     flutterTts = FlutterTts(); // Initialize the TTS plugin
//   }
//
//   void _checkAnswer() {
//     if (arrangedWords.join(" ") == widget.title) {
//       setState(() {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success! Move to Next Level", style: TextStyle(color: Colors.green))));
//       });
//       FirebaseFirestore.instance.collection('CompletedLevels').doc('${widget.level}').set({'level': widget.level});
//       Future.delayed(Duration(seconds: 2), () {
//         Navigator.pop(context);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ohh ooo better luck next time!", style: TextStyle(color: Colors.red))));
//     }
//   }
//
//   void _listenHint() async {
//     print("Listening");
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1.0);
//     await flutterTts.speak(widget.title);
//     print("Listened");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Level ${widget.level}"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.lightbulb_outline),
//             onPressed: _listenHint,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             color: Colors.grey[300],
//             child: Wrap(
//               children: arrangedWords.map((word) => Chip(label: Text(word))).toList(),
//             ),
//           ),
//           Wrap(
//             children: widget.words.map((word) => Draggable<String>(
//               data: word,
//               child: Chip(label: Text(word)),
//               feedback: Material(child: Chip(label: Text(word))),
//               childWhenDragging: Container(),
//             )).toList(),
//           ),
//           ElevatedButton(
//             onPressed: _checkAnswer,
//             child: Text("Submit"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//----
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ConstitutionChroniclesPage extends StatefulWidget {
//   @override
//   _ConstitutionChroniclesPageState createState() => _ConstitutionChroniclesPageState();
// }
//
// class _ConstitutionChroniclesPageState extends State<ConstitutionChroniclesPage> {
//   List<bool> levelCompleted = List.filled(88, false);
//   List<bool> levelUnlocked = List.generate(88, (index) => index == 0);
//
//   Future<void> playLevel(int index) async {
//     if (!levelUnlocked[index]) return;
//
//     final doc = await FirebaseFirestore.instance.collection('levels').doc('${index + 1}').get();
//     final String title = doc['title'] ?? "";
//     final String shortDescription = doc['short_description'] ?? "";
//     List<String> words = title.split(" ");
//     words.shuffle();
//
//     bool isSuccess = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SentenceGame(
//           level: index + 1,
//           words: words,
//           correctSentence: title,
//         ),
//       ),
//     );
//
//     if (isSuccess) {
//       setState(() {
//         levelCompleted[index] = true;
//         if (index < 87) levelUnlocked[index + 1] = true;
//       });
//     }
//   }
//
//   // void playHint(int index) async {
//   //   final doc = await FirebaseFirestore.instance.collection('levels').doc('${index + 1}').get();
//   //   final String hintText = doc['short_description'] ?? "";
//   //   await http.post(
//   //     Uri.parse("http://your-fastapi-server.com/speak"),
//   //     headers: {"Content-Type": "application/json"},
//   //     body: jsonEncode({"text": hintText}),
//   //   );
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 16, bottom: 16),
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             width: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff426586), Color(0xff648aae)],
//               ),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Constitution Chronicles \nDrag To Win",
//                 style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: 88,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Color(0xff648aae),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "LEVEL ${index + 1}",
//                         style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       Row(
//                         children: List.generate(5, (starIndex) {
//                           return Icon(
//                             Icons.star,
//                             color: levelCompleted[index] ? Colors.amber : Colors.grey,
//                             size: 20,
//                           );
//                         }),
//                       ),
//
//                       ElevatedButton(
//                         onPressed: levelUnlocked[index] ? () => playLevel(index) : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: levelUnlocked[index] ? Colors.white : Colors.grey,
//                           foregroundColor: Color(0xff426586),
//                         ),
//                         child: Text("Play"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SentenceGame extends StatefulWidget {
//   final int level;
//   final List<String> words;
//   final String correctSentence;
//
//   SentenceGame({required this.level, required this.words, required this.correctSentence});
//
//   @override
//   _SentenceGameState createState() => _SentenceGameState();
// }
//
// class _SentenceGameState extends State<SentenceGame> {
//   List<String> userArrangement = [];
//
//   void checkSentence() {
//     bool isCorrect = userArrangement.join(" ") == widget.correctSentence;
//     setState(() {});
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Text(isCorrect ? "Success! Move to Next Level" : "Ohh ooo better luck next time! Please try again "),
//         backgroundColor: isCorrect ? Colors.green[100] : Colors.red[100],
//         actions: [
//           TextButton(
//             child: Text("OK"),
//             onPressed: () => Navigator.pop(context, isCorrect),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                   child: Text(userArrangement.join(" "), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 ),
//               );
//             },
//             onAccept: (word) {
//               setState(() {
//                 userArrangement.add(word);
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
//           ElevatedButton(
//             onPressed: checkSentence,
//             child: Text("Submit"),
//           ),
//         ],
//       ),
//     );
//   }
// }
//----
//---
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:sansthaein_samvidhan/word_game_play.dart';
//
// class ConstitutionChroniclesPage extends StatefulWidget {
//   @override
//   _ConstitutionChroniclesPageState createState() => _ConstitutionChroniclesPageState();
// }
//
// class _ConstitutionChroniclesPageState extends State<ConstitutionChroniclesPage> {
//   List<bool> levelCompleted = List.filled(88, false);
//   List<bool> levelUnlocked = List.generate(88, (index) => index == 0); // Only Level 1 is enabled initially
//
//   // Future<void> playLevel(int index) async {
//   //   if (!levelUnlocked[index]) return;
//   //
//   //   final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('SS').get();
//   //   final List<QueryDocumentSnapshot> docs = snapshot.docs;
//   //
//   //   if (docs.isNotEmpty) {
//   //     final docData = docs.first.data() as Map<String, dynamic>; // Ensure it's a map
//   //     final String shortDescription = (docData['Short_Description'] ?? "") as String; // Explicit casting
//   //
//   //     print(shortDescription);
//   //
//   //     List<String> words = shortDescription.split(" ");
//   //     words.shuffle();
//   //
//   //     bool isSuccess = await Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => PlayWordGamePage(
//   //           level: index + 1,
//   //           words: words,
//   //           correctSentence: shortDescription,
//   //         ),
//   //       ),
//   //     );
//   //
//   //     if (isSuccess) {
//   //       setState(() {
//   //         levelCompleted[index] = true;
//   //         if (index < 87) levelUnlocked[index + 1] = true; // Enable next level
//   //       });
//   //     }
//   //   } else {
//   //     print("No documents found");
//   //   }
//   // }
//
//   Future<void> playLevel(int index) async {
//     if (!levelUnlocked[index]) return;
//
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
//           builder: (context) => PlayWordGamePage(
//             // level: index + 1,
//             // words: words,
//             // correctSentence: shortDescription,
//           ),
//         ),
//       );
//
//       if (isSuccess) {
//         setState(() {
//           levelCompleted[index] = true;
//           if (index < 87) levelUnlocked[index + 1] = true;
//         });
//
//         // Update Firestore with completion status
//         // await FirebaseFirestore.instance.collection('users').doc('currentUser').update({
//         //   'completedLevels': FieldValue.arrayUnion([index + 1])
//         // });
//
//         // Navigate to Chronicles Page with updated progress
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => ConstitutionChroniclesPage()),
//         );
//       }
//     } else {
//       print("No documents found");
//     }
//   }
//
//
//   // Future<void> playLevel(int index) async {
//   //   if (!levelUnlocked[index]) return;
//   //
//   //   // final doc = await FirebaseFirestore.instance.collection('SS').snapshots();
//   //   // final String shortDescription = doc['Short_Description'] ?? "";
//   //   final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('SS').get();
//   //   final List<QueryDocumentSnapshot> docs = snapshot.docs;
//   //
//   //   if (docs.isNotEmpty) {
//   //     final String shortDescription = docs.first['Short_Description'] ?? "";
//   //     print(shortDescription);
//   //   } else {
//   //     print("No documents found");
//   //   }
//   //   List<String> words = shortDescription.split(" ");
//   //   words.shuffle();
//   //
//   //   bool isSuccess = await Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => PlayWordGamePage(
//   //         level: index + 1,
//   //         words: words,
//   //         correctSentence: shortDescription,
//   //       ),
//   //     ),
//   //   );
//   //
//   //   if (isSuccess) {
//   //     setState(() {
//   //       levelCompleted[index] = true;
//   //       if (index < 87) levelUnlocked[index + 1] = true; // Enable next level
//   //     });
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             margin: EdgeInsets.only(top: 16, bottom: 16),
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//             width: 300,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Constitution Chronicles \nDrag To Win",
//                 style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           Expanded(
//             child:
//             ListView.builder(
//               padding: EdgeInsets.all(12),
//               itemCount: 88,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Color(0xff648aae),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("LEVEL ${index + 1}",
//                           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                       Row(
//                         children: List.generate(5, (starIndex) {
//                           return Icon(Icons.star, color: levelCompleted[index] ? Colors.amber : Colors.grey, size: 20);
//                         }),
//                       ),
//                       ElevatedButton(
//                         onPressed: levelUnlocked[index] ? () => playLevel(index) : null,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: levelUnlocked[index] ? Colors.white : Colors.grey,
//                           foregroundColor: Color(0xff426586),
//                         ),
//                         child: Text("Play"),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sansthaein_samvidhan/word_game_play.dart';
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

  @override
  void initState() {
    super.initState();
    if (widget.completedLevel != null) {
      // Update the completed level when received from constructor
      levelCompleted[widget.completedLevel! - 1] = true;
      if (widget.completedLevel! < 88) {
        levelUnlocked[widget.completedLevel!] = true; // Unlock next level
      }
    }
  }

  Future<void> playLevel(int index) async {
    if (!levelUnlocked[index]) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayWordGamePage(
          level: index + 1,
          // words: ["sample", "words", "for", "level", "${index + 1}"],
          // correctSentence: "sample words for level ${index + 1}",
        ),
      ),
    );

    if (result != null && result == true) {
      // Level completed successfully
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConstitutionChroniclesPage(
            completedLevel: index + 1,
          ),
        ),
      );
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
                              color: levelCompleted[index] ? Colors.amber : Colors.grey,
                              size: 20);
                        }),
                      ),
                      ElevatedButton(
                        onPressed: levelUnlocked[index] ? () => playLevel(index) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: levelUnlocked[index] ? Colors.white : Colors.grey,
                          foregroundColor: Color(0xff426586),
                        ),
                        child: Text(levelCompleted[index] ? "Completed" : "Play"),
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