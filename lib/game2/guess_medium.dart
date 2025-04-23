import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sansthaein_samvidhan/game2/game_2_result.dart';

class CrosswordMediumPuzzlePage extends StatefulWidget {
  @override
  _CrosswordMediumPuzzlePageState createState() => _CrosswordMediumPuzzlePageState();
}

class _CrosswordMediumPuzzlePageState extends State<CrosswordMediumPuzzlePage> {
  List<List<TextEditingController>> controllers = [];
  List<List<FocusNode>> focusNodes = [];
  List<List<bool>> enabledCells = [];
  Map<String, String> answers = {
    '1': 'composition',
    '2': 'procedure',
    '3': 'chairman',
    '4': 'seat',
    '5': 'function',
    '6': 'prime',
    '7': 'eligibility',
    '8':'jurisdiction',
    '9':'election',
    '10':'oath'
  };

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    controllers = List.generate(16, (row) => List.generate(18, (col) => TextEditingController()));
    focusNodes = List.generate(16, (row) => List.generate(18, (col) => FocusNode()));
    enabledCells = List.generate(16, (row) => List.generate(18, (col) => false));

    enabledCells[0][3] = true;
    enabledCells[1][3] = true;
    enabledCells[1][5] = true;
    enabledCells[1][14] = true;
    enabledCells[2][3] = true;
    enabledCells[2][5] = true;
    enabledCells[2][14] = true;
    enabledCells[3][3] = true;
    enabledCells[3][5] = true;
    enabledCells[3][8] = true;
    enabledCells[3][14] = true;
    enabledCells[4][3] = true;
    enabledCells[4][5] = true;
    enabledCells[4][8] = true;
    enabledCells[4][11] = true;
    enabledCells[4][14] = true;
    enabledCells[5][3] = true;
    enabledCells[5][5] = true;
    enabledCells[5][8] = true;
    enabledCells[5][11] = true;
    for(int col=13; col<=17; col++) enabledCells[5][col] = true;
    for(int col=0; col<=11; col++) enabledCells[6][col] = true;
    enabledCells[6][14] = true;
    enabledCells[6][17] = true;
    enabledCells[7][3] = true;
    enabledCells[7][5] = true;
    enabledCells[7][11] = true;
    enabledCells[7][14] = true;
    for(int row=7; row<=15; row++) enabledCells[row][17] = true;
    enabledCells[8][3] = true;
    enabledCells[8][5] = true;
    enabledCells[9][3] = true;
    enabledCells[9][5] = true;
    enabledCells[10][3] = true;
    for(int col=7; col<=14; col++) enabledCells[8][col] = true;
    enabledCells[9][11] = true;
    enabledCells[9][13] = true;
    enabledCells[10][11] = true;
    enabledCells[10][13] = true;
    enabledCells[11][11] = true;
    enabledCells[11][13] = true;
    // Define enabled white cells based on instructions
    // enabledCells[0][3] = true; // Row 1 column 11
    // for (int col = 0; col <= 11; col++) enabledCells[1][col] = true; // Row 2
    // enabledCells[1][15] = true; // Row 2 column 16
    // enabledCells[2][6] = enabledCells[2][10] = enabledCells[2][15] = true; // Row 3
    // enabledCells[3][10] = enabledCells[3][15] = enabledCells[3][17] = true; // Row 4 (removed 6,7,8)
    // enabledCells[3][6] = true; // Added back row 4 column 7 as requested
    // enabledCells[4][6] = true;
    // for (int col = 9; col <= 17; col++) enabledCells[4][col] = true; // Row 5
    // for (int row = 5; row <= 10; row++) {
    //   enabledCells[row][15] = true;
    //   enabledCells[row][17] = true;
    // }
    // enabledCells[11][15] = true;
    // enabledCells[12][15] = true;

    // Set up focus node listeners for auto-moving
    for (int row = 0; row < 16; row++) {
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
    return controllers[0][3].text.toLowerCase() +
        controllers[1][3].text.toLowerCase() +
        controllers[2][3].text.toLowerCase() +
        controllers[3][3].text.toLowerCase() +
        controllers[4][3].text.toLowerCase() +
        controllers[5][3].text.toLowerCase() +
        controllers[6][3].text.toLowerCase() +
        controllers[7][3].text.toLowerCase() +
        controllers[8][3].text.toLowerCase() +
        controllers[9][3].text.toLowerCase() +
        controllers[10][3].text.toLowerCase() ==
        answers['1'] &&
        controllers[1][5].text.toLowerCase() +
            controllers[2][5].text.toLowerCase() +
            controllers[3][5].text.toLowerCase() +
            controllers[4][5].text.toLowerCase() +
            controllers[5][5].text.toLowerCase() +
            controllers[6][5].text.toLowerCase() +
            controllers[7][5].text.toLowerCase() +
            controllers[8][5].text.toLowerCase() +
            controllers[9][5].text.toLowerCase() ==
            answers['2'] &&
        controllers[3][8].text.toLowerCase() +
            controllers[4][8].text.toLowerCase() +
            controllers[5][8].text.toLowerCase() +
            controllers[6][8].text.toLowerCase() ==
            answers['4'] &&
        controllers[4][11].text.toLowerCase() +
            controllers[5][11].text.toLowerCase() +
            controllers[6][11].text.toLowerCase() +
            controllers[7][11].text.toLowerCase() +
            controllers[8][11].text.toLowerCase() +
            controllers[9][11].text.toLowerCase() +
            controllers[10][11].text.toLowerCase() +
            controllers[11][11].text.toLowerCase() ==
            answers['5'] &&
        controllers[1][14].text.toLowerCase() +
            controllers[2][14].text.toLowerCase() +
            controllers[3][14].text.toLowerCase() +
            controllers[4][14].text.toLowerCase() +
            controllers[5][14].text.toLowerCase() +
            controllers[6][14].text.toLowerCase() +
            controllers[7][14].text.toLowerCase() +
            controllers[8][14].text.toLowerCase() ==
            answers['3'] &&
        controllers[5][17].text.toLowerCase() +
            controllers[6][17].text.toLowerCase() +
            controllers[7][17].text.toLowerCase() +
            controllers[8][17].text.toLowerCase() +
            controllers[9][17].text.toLowerCase() +
            controllers[10][17].text.toLowerCase() +
            controllers[11][17].text.toLowerCase() +
            controllers[12][17].text.toLowerCase() +
            controllers[13][17].text.toLowerCase() +
            controllers[14][17].text.toLowerCase() +
            controllers[15][17].text.toLowerCase() ==
            answers['7'] &&
        controllers[8][13].text.toLowerCase() +
            controllers[9][13].text.toLowerCase() +
            controllers[10][13].text.toLowerCase() +
            controllers[11][13].text.toLowerCase() ==
            answers['10'] &&
        controllers[6][0].text.toLowerCase() +
            controllers[6][1].text.toLowerCase() +
            controllers[6][2].text.toLowerCase() +
            controllers[6][3].text.toLowerCase() +
            controllers[6][4].text.toLowerCase() +
            controllers[6][5].text.toLowerCase() +
            controllers[6][6].text.toLowerCase() +
            controllers[6][7].text.toLowerCase() +
            controllers[6][8].text.toLowerCase() +
            controllers[6][9].text.toLowerCase() +
            controllers[6][10].text.toLowerCase() +
            controllers[6][11].text.toLowerCase() ==
            answers['8'] &&
        controllers[8][7].text.toLowerCase() +
            controllers[8][8].text.toLowerCase() +
            controllers[8][9].text.toLowerCase() +
            controllers[8][10].text.toLowerCase() +
            controllers[8][11].text.toLowerCase() +
            controllers[8][12].text.toLowerCase() +
            controllers[8][13].text.toLowerCase() +
            controllers[8][14].text.toLowerCase() ==
            answers['9'] &&
        controllers[5][13].text.toLowerCase() +
            controllers[5][14].text.toLowerCase() +
            controllers[5][15].text.toLowerCase() +
            controllers[5][16].text.toLowerCase() +
            controllers[5][17].text.toLowerCase() ==
            answers['6'];
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
    if (row == 0 && col == 3) clueNumber = '1';
    if (row == 1 && col == 5) clueNumber = '2';
    if (row == 1 && col == 14) clueNumber = '3';
    if (row == 3 && col == 8) clueNumber = '4';
    if (row == 4 && col == 11) clueNumber = '5';
    if (row == 5 && col == 13) clueNumber = '6';
    if (row == 5 && col == 17) clueNumber = '7';
    if (row == 6 && col == 0) clueNumber = '8';
    if (row == 8 && col == 7) clueNumber = '9';
    if (row == 8 && col == 13) clueNumber = '10';

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
    if (row < 15) {
      for (int r = row + 1; r < 16; r++) {
        if (enabledCells[r][col]) {
          FocusScope.of(context).requestFocus(focusNodes[r][col]);
          return;
        }
      }
    }

    // Then try to move to next available cell
    for (int r = row; r < 16; r++) {
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
                Text('Level : Medium',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xff426586))),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Color(0xff648aae), width: 2)),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: List.generate(16, (row) {
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
                              Text('6. The __________ Minister must furnish information to the President.'),
                              SizedBox(height: 8),
                              Text('8. The __________ of Supreme Court includes matters like writs and original jurisdiction.'),
                              SizedBox(height: 8,),
                              Text('9. The __________ of President follows a defined constitutional procedure.'),
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
                              Text('1. The __________ of the State Legislature includes both the Assembly and the Council.'),
                              SizedBox(height: 8),
                              Text('2. The __________ for impeachment of the President is defined under Article 61.'),
                              SizedBox(height: 8),
                              Text('3. The Vice-President acts as __________ of the Council of States.'),
                              SizedBox(height: 8),
                              Text('4. The __________ of Supreme Court is located in Delhi.'),
                              SizedBox(height: 8,),
                              Text('5. The Vice-President\'s __________ includes stepping in during presidential vacancies.'),
                              SizedBox(height: 8,),
                              Text('7. The __________ for re-election of the President is not restricted by the Constitution.'),
                              SizedBox(height: 8,),
                              Text('10. The President must take an _________ before assuming office.'),
                              SizedBox(height: 8,),
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
                          level: 'Medium',
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