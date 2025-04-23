import 'package:flutter/material.dart';

import 'game2/game_level_select.dart';
//import 'game_level_select.dart';

class Game3ResultPage extends StatefulWidget {
  final bool isSuccess;
  final String level;
  final Duration completionTime; // New parameter for completion time

  const Game3ResultPage({
    required this.isSuccess,
    required this.level,
    required this.completionTime, // Added completion time parameter
    Key? key
  }) : super(key: key);

  @override
  _Game3ResultPageState createState() => _Game3ResultPageState();
}

class _Game3ResultPageState extends State<Game3ResultPage> {
  List<bool> starAnimationStates = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();
    if (widget.isSuccess) {
      _animateStars();
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

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
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
                          SizedBox(height: 10),
                          // New blue box for completion time
                          if (widget.isSuccess) ...[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                              decoration: BoxDecoration(
                                color: Color(0xff648aae),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Time: ${_formatTime(widget.completionTime)}",
                                style: TextStyle(
                                    color: Color(0xfffafafa),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
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