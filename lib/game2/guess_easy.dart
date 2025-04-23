// import 'package:flutter/material.dart';
//
//
// class CrosswordPuzzlePage extends StatefulWidget {
//   @override
//   _CrosswordPuzzlePageState createState() => _CrosswordPuzzlePageState();
// }
//
// class _CrosswordPuzzlePageState extends State<CrosswordPuzzlePage> {
//   List<List<TextEditingController>> controllers = [];
//   bool isCompleted = false;
//   bool showResult = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeControllers();
//   }
//
//   void _initializeControllers() {
//     // Initialize controllers for the crossword grid
//     controllers = List.generate(9, (row) {
//       return List.generate(12, (col) {
//         return TextEditingController();
//       });
//     });
//
//     // Set some cells as disabled (black)
//     // For example, in row 1, columns 1-5 are disabled in your screenshot
//     // You'll need to adjust this based on your actual puzzle layout
//   }
//
//   bool _checkSolution() {
//     // Check if all words are correctly filled
//     // This is a simplified check - you'll need to implement the actual solution checking
//     // based on your puzzle's correct answers
//
//     // Check "constitution" (first row)
//     for (int i = 0; i < 12; i++) {
//       if (controllers[0][i].text.toLowerCase() != "constitution"[i]) {
//         return false;
//       }
//     }
//
//     // Check other words similarly...
//     // This is just a placeholder - implement full solution checking
//
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               Center(
//                 child: Text(
//                   'Level : Easy',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xff426586),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Crossword Grid
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const Color(0xff648aae),
//                       width: 2,
//                     ),
//                   ),
//                   child: Table(
//                     border: TableBorder.all(
//                       color: const Color(0xff648aae),
//                       width: 1,
//                     ),
//                     children: List.generate(9, (row) {
//                       return TableRow(
//                         children: List.generate(12, (col) {
//                           // Check if this cell should be disabled (black)
//                           bool isDisabled = false;
//                           // Add logic to determine disabled cells based on your puzzle
//
//                           return Container(
//                             color: isDisabled ? Colors.black : Colors.white,
//                             height: 40,
//                             width: 40,
//                             child: isDisabled
//                                 ? SizedBox.shrink()
//                                 : Center(
//                               child: TextField(
//                                 controller: controllers[row][col],
//                                 textAlign: TextAlign.center,
//                                 maxLength: 1,
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 decoration: InputDecoration(
//                                   counterText: '',
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.zero,
//                                 ),
//                                 onChanged: (value) {
//                                   if (value.length == 1) {
//                                     // Move to next cell
//                                     FocusScope.of(context).nextFocus();
//                                   }
//                                 },
//                               ),
//                             ),
//                           );
//                         }),
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               // Clues Section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Across clues
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Across',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xff426586),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '2. The __________ of Parliament includes both\nthe Lok Sabha and the Rajya Sabha.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '6. The __________ of India is the head of the\nUnion Executive.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Down clues
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Down',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xff426586),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '1. The President has the __________ to grant\npardons, suspend, remit or commute sentences.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '3. The __________ of Vice-President is for a\nterm of five years.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '4. The __________ of the Supreme Court is\nresponsible for presiding over its functions.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           '5. The _________-General for India is the chief\nlegal advisor to the Government.',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//
//               // Submit Button
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: const Color(0xff648aae),
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isCompleted = _checkSolution();
//                       showResult = true;
//                     });
//
//                     // Show result dialog
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text(isCompleted ? 'Success!' : 'Failed'),
//                         content: Text(isCompleted
//                             ? 'Congratulations! You solved the puzzle correctly!'
//                             : 'Some answers are incorrect. Please try again.'),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: Text('OK'),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//
//               if (showResult)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Center(
//                     child: Text(
//                       isCompleted ? 'Successful!' : 'Failed',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: isCompleted ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers
//     for (var row in controllers) {
//       for (var controller in row) {
//         controller.dispose();
//       }
//     }
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sansthaein_samvidhan/game2/game_2_result.dart';

class CrosswordEasyPuzzlePage extends StatefulWidget {
  @override
  _CrosswordEasyPuzzlePageState createState() => _CrosswordEasyPuzzlePageState();
}

class _CrosswordEasyPuzzlePageState extends State<CrosswordEasyPuzzlePage> {
  List<List<TextEditingController>> controllers = [];
  List<List<FocusNode>> focusNodes = [];
  List<List<bool>> enabledCells = [];
  Map<String, String> answers = {
    '2': 'constitution',
    '6': 'president',
    '1': 'power',
    '3': 'term',
    '4': 'chiefjustice',
    '5': 'attorney'
  };

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    controllers = List.generate(13, (row) => List.generate(18, (col) => TextEditingController()));
    focusNodes = List.generate(13, (row) => List.generate(18, (col) => FocusNode()));
    enabledCells = List.generate(13, (row) => List.generate(18, (col) => false));

    // Define enabled white cells based on instructions
    enabledCells[0][10] = true; // Row 1 column 11
    for (int col = 0; col <= 11; col++) enabledCells[1][col] = true; // Row 2
    enabledCells[1][15] = true; // Row 2 column 16
    enabledCells[2][6] = enabledCells[2][10] = enabledCells[2][15] = true; // Row 3
    enabledCells[3][10] = enabledCells[3][15] = enabledCells[3][17] = true; // Row 4 (removed 6,7,8)
    enabledCells[3][6] = true; // Added back row 4 column 7 as requested
    enabledCells[4][6] = true;
    for (int col = 9; col <= 17; col++) enabledCells[4][col] = true; // Row 5
    for (int row = 5; row <= 10; row++) {
      enabledCells[row][15] = true;
      enabledCells[row][17] = true;
    }
    enabledCells[11][15] = true;
    enabledCells[12][15] = true;

    // Set up focus node listeners for auto-moving
    for (int row = 0; row < 13; row++) {
      for (int col = 0; col < 18; col++) {
        if (enabledCells[row][col]) {
          focusNodes[row][col].addListener(() {
            if (!focusNodes[row][col].hasFocus && controllers[row][col].text.isEmpty) {
              controllers[row][col].text = ' ';
            }
          });
        }
      }
    }
  }

  bool _checkSolution() {
    return controllers[1][0].text.toLowerCase() +
        controllers[1][1].text.toLowerCase() +
        controllers[1][2].text.toLowerCase() +
        controllers[1][3].text.toLowerCase() +
        controllers[1][4].text.toLowerCase() +
        controllers[1][5].text.toLowerCase() +
        controllers[1][6].text.toLowerCase() +
        controllers[1][7].text.toLowerCase() +
        controllers[1][8].text.toLowerCase() +
        controllers[1][9].text.toLowerCase() +
        controllers[1][10].text.toLowerCase() +
        controllers[1][11].text.toLowerCase() ==
        answers['2'] &&
        controllers[4][9].text.toLowerCase() +
            controllers[4][10].text.toLowerCase() +
            controllers[4][11].text.toLowerCase() +
            controllers[4][12].text.toLowerCase() +
            controllers[4][13].text.toLowerCase() +
            controllers[4][14].text.toLowerCase() +
            controllers[4][15].text.toLowerCase() +
            controllers[4][16].text.toLowerCase() +
            controllers[4][17].text.toLowerCase() ==
            answers['6'] &&
        controllers[0][10].text.toLowerCase() +
            controllers[1][10].text.toLowerCase() +
            controllers[2][10].text.toLowerCase() +
            controllers[3][10].text.toLowerCase() +
            controllers[4][10].text.toLowerCase() ==
            answers['1'] &&
        controllers[1][6].text.toLowerCase() +
            controllers[2][6].text.toLowerCase() +
            controllers[3][6].text.toLowerCase() +
            controllers[4][6].text.toLowerCase() ==
            answers['3'] &&
        controllers[1][15].text.toLowerCase() +
            controllers[2][15].text.toLowerCase() +
            controllers[3][15].text.toLowerCase() +
            controllers[4][15].text.toLowerCase() +
            controllers[5][15].text.toLowerCase() +
            controllers[6][15].text.toLowerCase() +
            controllers[7][15].text.toLowerCase() +
            controllers[8][15].text.toLowerCase() +
            controllers[9][15].text.toLowerCase() +
            controllers[10][15].text.toLowerCase() +
            controllers[11][15].text.toLowerCase() +
            controllers[12][15].text.toLowerCase() ==
            answers['4'] &&
        controllers[3][17].text.toLowerCase() +
            controllers[4][17].text.toLowerCase() +
            controllers[5][17].text.toLowerCase() +
            controllers[6][17].text.toLowerCase() +
            controllers[7][17].text.toLowerCase() +
            controllers[8][17].text.toLowerCase() +
            controllers[9][17].text.toLowerCase() +
            controllers[10][17].text.toLowerCase() ==
            answers['5'];
  }

  // Widget _buildCell(int row, int col) {
  //   bool enabled = enabledCells[row][col];
  //   bool hasClue =
  //       (row == 1 && col == 0) || (row == 4 && col == 9) || (row == 0 && col == 10) || (row == 1 && col == 6) || (row == 1 && col == 15) || (row == 3 && col == 17);
  //   String clueNumber = '';
  //   if (row == 1 && col == 0) clueNumber = '2';
  //   if (row == 4 && col == 9) clueNumber = '6';
  //   if (row == 0 && col == 10) clueNumber = '1';
  //   if (row == 1 && col == 6) clueNumber = '3';
  //   if (row == 1 && col == 15) clueNumber = '4';
  //   if (row == 3 && col == 17) clueNumber = '5';
  //
  //   return Container(
  //       decoration: BoxDecoration(
  //       border: Border.all(color: const Color(0xff426586),
  //
  //   ),
  //     color: enabled ? const Color(0xfffafafa) : const Color(0xff426586),),
  //     width: 30,
  //     height: 30,
  //     child: Stack(
  //       children: [
  //     if (enabled)
  //       TextField(
  //         controller: controllers[row][col],
  //         focusNode: focusNodes[row][col],
  //         maxLength: 1,
  //         textAlign: TextAlign.center,
  //         decoration: InputDecoration(
  //         counterText: '',
  //         border: InputBorder.none,
  //     ),
  //   style: TextStyle(fontWeight: FontWeight.bold),
  //   onChanged: (value) {
  //     if (value.length == 1) {
  //       // Move to next cell
  //       _moveToNextCell(row, col);
  //     }
  //   },
  //   ),
  //     if (hasClue)
  //       Positioned(
  //         top: 1,
  //         left: 2,
  //         child: Text(
  //         clueNumber,
  //         style: TextStyle(fontSize: 10, color: Colors.black),
  //         ),
  //     ),
  //   ],
  //   ),
  //   );
  // }
  Widget _buildCell(int row, int col) {
    bool enabled = enabledCells[row][col];
    bool hasClue =
        (row == 1 && col == 0) || (row == 4 && col == 9) || (row == 0 && col == 10) || (row == 1 && col == 6) || (row == 1 && col == 15) || (row == 3 && col == 17);
    String clueNumber = '';
    if (row == 1 && col == 0) clueNumber = '2';
    if (row == 4 && col == 9) clueNumber = '6';
    if (row == 0 && col == 10) clueNumber = '1';
    if (row == 1 && col == 6) clueNumber = '3';
    if (row == 1 && col == 15) clueNumber = '4';
    if (row == 3 && col == 17) clueNumber = '5';

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff426586)),
        color: enabled ? const Color(0xfffafafa) : const Color(0xff426586),
      ),
      child: Stack(
        children: [
          if (enabled)
            Center(
              child: TextField(
                controller: controllers[row][col],
                focusNode: focusNodes[row][col],
                maxLength: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
                decoration: const InputDecoration(
                  counterText: '',
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Allow only letters
                ],
                onChanged: (value) {
                  if (value.length == 1) {
                    _moveToNextCell(row, col);
                  }
                },
              ),
            ),
          if (hasClue)
            Positioned(
              top: 2,
              left: 2,
              child: Text(
                clueNumber, // You can change this to `clueNumber` if needed
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }


  void _moveToNextCell(int row, int col) {
    // Try to move right first
    if (col < 17 && enabledCells[row][col + 1]) {
      FocusScope.of(context).requestFocus(focusNodes[row][col + 1]);
      return;
    }

    // Then try to move down
    if (row < 12) {
      for (int r = row + 1; r < 13; r++) {
        if (enabledCells[r][col]) {
          FocusScope.of(context).requestFocus(focusNodes[r][col]);
          return;
        }
      }
    }

    // Then try to move to next available cell
    for (int r = row; r < 13; r++) {
      int startCol = (r == row) ? col + 1 : 0;
      for (int c = startCol; c < 18; c++) {
        if (enabledCells[r][c]) {
          FocusScope.of(context).requestFocus(focusNodes[r][c]);
          return;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Level : Easy',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff426586))),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Color(0xff648aae), width: 2)),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(13, (row) {
                      return TableRow(
                        children: List.generate(18, (col) => _buildCell(row, col)),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity, // Full width
                  height: 180,
                  child: SingleChildScrollView(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Across',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff426586))),
                              SizedBox(height: 8),
                              Text('2. The __________ of Parliament includes both the Lok Sabha and the Rajya Sabha.'),
                              SizedBox(height: 8),
                              Text('6. The __________ of India is the head of the Union Executive.'),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Down',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff426586))),
                              SizedBox(height: 8),
                              Text('1. The President has the __________ to grant pardons, suspend, remit or commute sentences.'),
                              SizedBox(height: 8),
                              Text('3. The __________ of Vice-President is for a term of five years.'),
                              SizedBox(height: 8),
                              Text('4. The __________ of the Supreme Court is responsible for presiding over its functions.'),
                              SizedBox(height: 8),
                              Text('5. The _________-General for India is the chief legal advisor to the Government.'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    bool isCorrect = _checkSolution();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Game2ResultPage(
                          isSuccess: isCorrect,
                          level: 'Easy',
                        ),
                      ),
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (_) => AlertDialog(
                    //     title: Text(isCorrect ? 'Success' : 'Failed'),
                    //     content: Text(isCorrect ? 'All answers are correct!' : 'Some answers are incorrect.'),
                    //     actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff648aae),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    for (var row in focusNodes) {
      for (var focusNode in row) {
        focusNode.dispose();
      }
    }
    super.dispose();
  }
}