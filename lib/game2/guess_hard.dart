import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sansthaein_samvidhan/game2/game_2_result.dart';

class CrosswordHardPuzzlePage extends StatefulWidget {
  @override
  _CrosswordHardPuzzlePageState createState() => _CrosswordHardPuzzlePageState();
}

class _CrosswordHardPuzzlePageState extends State<CrosswordHardPuzzlePage> {
  List<List<TextEditingController>> controllers = [];
  List<List<FocusNode>> focusNodes = [];
  List<List<bool>> enabledCells = [];
  Map<String, String> answers = {
    '1': 'nominated',
    '2': 'supreme',
    '3': 'decision',
    '4': 'pardons',
    '5': 'power',
    '6': 'moneybills',
    '7': 'procedure',
    '8d':'court',
    '8a': 'certificate',
    '9': 'ancillary',
    '10': 'salaries',
    '11': 'bills',
    '12': 'attendance',
    '13': 'legislature',
    '14': 'vacation',
    '15': 'consult'
  };

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  void _initializeGrid() {
    controllers = List.generate(20, (row) => List.generate(22, (col) => TextEditingController()));
    focusNodes = List.generate(20, (row) => List.generate(22, (col) => FocusNode()));
    enabledCells = List.generate(20, (row) => List.generate(22, (col) => false));

    for(int row=0; row<=8; row++) enabledCells[row][17] = true; //1
    for(int row=1; row<=7; row++) enabledCells[row][21] = true; //2
    for(int row=4; row<=11; row++) enabledCells[row][9] = true; //3
    for(int row=5; row<=9; row++) enabledCells[row][7] = true; //5
    for(int row=6; row<=15; row++) enabledCells[row][15] = true; //6
    for(int row=9; row<=13; row++) enabledCells[row][5] = true; //8d
    for(int row=11; row<=19; row++) enabledCells[row][11] = true; //9
    for(int row=12; row<=19; row++) enabledCells[row][3] = true; //10

    for(int col=12; col<=18; col++) enabledCells[4][col] = true; //4
    for(int col=13; col<=21; col++) enabledCells[7][col] = true; //7
    for(int col=5; col<=15; col++) enabledCells[9][col] = true; //8a
    for(int col=14; col<=18; col++) enabledCells[12][col] = true; //11
    for(int col=3; col<=12; col++) enabledCells[13][col] = true; //12
    for(int col=11; col<=21; col++) enabledCells[15][col] = true; //13
    for(int col=10; col<=17; col++) enabledCells[17][col] = true; //14
    for(int col=0; col<=6; col++) enabledCells[19][col] = true; //15

    // Set up focus node listeners for auto-moving
    for (int row = 0; row < 20; row++) {
      for (int col = 0; col < 22; col++) {
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
    return controllers[0][17].text.toLowerCase() +
        controllers[1][17].text.toLowerCase() +
        controllers[2][17].text.toLowerCase() +
        controllers[3][17].text.toLowerCase() +
        controllers[4][17].text.toLowerCase() +
        controllers[5][17].text.toLowerCase() +
        controllers[6][17].text.toLowerCase() +
        controllers[7][17].text.toLowerCase() +
        controllers[8][17].text.toLowerCase() ==
        answers['1'] &&
        controllers[1][21].text.toLowerCase() +
            controllers[2][21].text.toLowerCase() +
            controllers[3][21].text.toLowerCase() +
            controllers[4][21].text.toLowerCase() +
            controllers[5][21].text.toLowerCase() +
            controllers[6][21].text.toLowerCase() +
            controllers[7][21].text.toLowerCase() ==
            answers['2'] &&
        controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() +
            controllers[4][9].text.toLowerCase() ==
            answers['3'] &&
        controllers[5][7].text.toLowerCase() +
            controllers[6][7].text.toLowerCase() +
            controllers[7][7].text.toLowerCase() +
            controllers[8][7].text.toLowerCase() +
            controllers[9][7].text.toLowerCase() ==
            answers['5'] &&
        controllers[6][15].text.toLowerCase() +
            controllers[7][15].text.toLowerCase() +
            controllers[8][15].text.toLowerCase() +
            controllers[9][15].text.toLowerCase() +
            controllers[10][15].text.toLowerCase() +
            controllers[11][15].text.toLowerCase() +
            controllers[12][15].text.toLowerCase() +
            controllers[13][15].text.toLowerCase() +
            controllers[14][15].text.toLowerCase() +
            controllers[15][15].text.toLowerCase() ==
            answers['6'] &&
        controllers[9][5].text.toLowerCase() +
            controllers[10][5].text.toLowerCase() +
            controllers[11][5].text.toLowerCase() +
            controllers[12][5].text.toLowerCase() +
            controllers[13][5].text.toLowerCase() ==
            answers['8d'] &&
        controllers[11][11].text.toLowerCase() +
            controllers[12][11].text.toLowerCase() +
            controllers[13][11].text.toLowerCase() +
            controllers[14][11].text.toLowerCase() +
            controllers[15][11].text.toLowerCase() +
            controllers[16][11].text.toLowerCase() +
            controllers[17][11].text.toLowerCase() +
            controllers[18][11].text.toLowerCase() +
            controllers[19][11].text.toLowerCase() ==
            answers['9'] &&
        controllers[12][3].text.toLowerCase() +
            controllers[13][3].text.toLowerCase() +
            controllers[14][3].text.toLowerCase() +
            controllers[15][3].text.toLowerCase() +
            controllers[16][3].text.toLowerCase() +
            controllers[17][3].text.toLowerCase() +
            controllers[18][3].text.toLowerCase() +
            controllers[19][3].text.toLowerCase() ==
            answers['10'] &&
        controllers[4][12].text.toLowerCase() +
            controllers[4][13].text.toLowerCase() +
            controllers[4][14].text.toLowerCase() +
            controllers[4][15].text.toLowerCase() +
            controllers[4][16].text.toLowerCase() +
            controllers[4][17].text.toLowerCase() +
            controllers[4][18].text.toLowerCase() ==
            answers['4'] &&
        controllers[7][13].text.toLowerCase() +
            controllers[7][14].text.toLowerCase() +
            controllers[7][15].text.toLowerCase() +
            controllers[7][16].text.toLowerCase() +
            controllers[7][17].text.toLowerCase() +
            controllers[7][18].text.toLowerCase() +
            controllers[7][19].text.toLowerCase() +
            controllers[7][20].text.toLowerCase() +
            controllers[7][21].text.toLowerCase() ==
            answers['7'] &&
        controllers[9][5].text.toLowerCase() +
            controllers[9][6].text.toLowerCase() +
            controllers[9][7].text.toLowerCase() +
            controllers[9][8].text.toLowerCase() +
            controllers[9][9].text.toLowerCase() +
            controllers[9][10].text.toLowerCase() +
            controllers[9][11].text.toLowerCase() +
            controllers[9][12].text.toLowerCase() +
            controllers[9][13].text.toLowerCase() +
            controllers[9][14].text.toLowerCase() +
            controllers[9][15].text.toLowerCase() ==
            answers['8a']  &&
        controllers[12][14].text.toLowerCase() +
            controllers[12][15].text.toLowerCase() +
            controllers[12][16].text.toLowerCase() +
            controllers[12][17].text.toLowerCase() +
            controllers[12][18].text.toLowerCase() ==
            answers['11'] &&
        controllers[13][3].text.toLowerCase() +
            controllers[13][4].text.toLowerCase() +
            controllers[13][5].text.toLowerCase() +
            controllers[13][6].text.toLowerCase() +
            controllers[13][7].text.toLowerCase() +
            controllers[13][8].text.toLowerCase() +
            controllers[13][9].text.toLowerCase() +
            controllers[13][10].text.toLowerCase() +
            controllers[13][11].text.toLowerCase() +
            controllers[13][12].text.toLowerCase() ==
            answers['12'] &&
        controllers[15][11].text.toLowerCase() +
            controllers[15][12].text.toLowerCase() +
            controllers[15][13].text.toLowerCase() +
            controllers[15][14].text.toLowerCase() +
            controllers[15][15].text.toLowerCase() +
            controllers[15][16].text.toLowerCase() +
            controllers[15][17].text.toLowerCase() +
            controllers[15][18].text.toLowerCase() +
            controllers[15][19].text.toLowerCase() +
            controllers[15][20].text.toLowerCase() +
            controllers[15][21].text.toLowerCase() ==
            answers['13'] &&
        controllers[17][10].text.toLowerCase() +
            controllers[17][11].text.toLowerCase() +
            controllers[17][12].text.toLowerCase() +
            controllers[17][13].text.toLowerCase() +
            controllers[17][14].text.toLowerCase() +
            controllers[17][15].text.toLowerCase() +
            controllers[17][16].text.toLowerCase() +
            controllers[17][17].text.toLowerCase() ==
            answers['14'] &&
        controllers[19][0].text.toLowerCase() +
            controllers[19][1].text.toLowerCase() +
            controllers[19][2].text.toLowerCase() +
            controllers[19][3].text.toLowerCase() +
            controllers[19][4].text.toLowerCase() +
            controllers[19][5].text.toLowerCase() +
            controllers[19][6].text.toLowerCase()==
            answers['15'];
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
    if (row == 0 && col == 17) clueNumber = '1';
    if (row == 1 && col == 21) clueNumber = '2';
    if (row == 4 && col == 9) clueNumber = '3';
    if (row == 4 && col == 12) clueNumber = '4';
    if (row == 5 && col == 7) clueNumber = '5';
    if (row == 6 && col == 15) clueNumber = '6';
    if (row == 7 && col == 13) clueNumber = '7';
    if (row == 9 && col == 5) clueNumber = '8';
    if (row == 11 && col == 11) clueNumber = '9';
    if (row == 12 && col == 3) clueNumber = '10';
    if (row == 12 && col == 14) clueNumber = '11';
    if (row == 13 && col == 3) clueNumber = '12';
    if (row == 15 && col == 11) clueNumber = '13';
    if (row == 17 && col == 10) clueNumber = '14';
    if (row == 19 && col == 0) clueNumber = '15';

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
    if (row < 19) {
      for (int r = row + 1; r < 20; r++) {
        if (enabledCells[r][col]) {
          FocusScope.of(context).requestFocus(focusNodes[r][col]);
          return;
        }
      }
    }

    // Then try to move to next available cell
    for (int r = row; r < 20; r++) {
      int startCol = (r == row) ? col + 1 : 0;
      for (int c = startCol; c < 22; c++) {
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
                    children: List.generate(20, (row) {
                      return TableRow(
                        children: List.generate(22, (col) => _buildCell(row, col)),
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
                              Text('4. The President’s power includes issuing __________ and commuting sentences. '),
                              SizedBox(height: 8),
                              Text('7. The __________ for removal of the VicePresident is laid out in Article 67. '),
                              SizedBox(height: 8,),
                              Text('8. The __________ for appeal to the Supreme Court must be certified by a High Court.'),
                              SizedBox(height: 8,),
                              Text('11. The procedure for introduction and passage of __________ varies for Money Bills.'),
                              SizedBox(height: 8,),
                              Text('12. The __________ of retired judges at Supreme Court sittings is permitted under Article 128.'),
                              SizedBox(height: 8,),
                              Text('13. The duration of State __________ extends for five years unless dissolved sooner.'),
                              SizedBox(height: 8,),
                              Text('14. The __________ and resignation of the Speaker is covered in Article 179.'),
                              SizedBox(height: 8,),
                              Text('15. The President can __________ the Supreme Court for advice under Article 143.'),
                              SizedBox(height: 8,),
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
                              Text('1. The composition of Parliament includes both elected and __________ members.'),
                              SizedBox(height: 8),
                              Text('2. The __________ Court is the highest constitutional court in India.'),
                              SizedBox(height: 8),
                              Text('3. The __________ of disqualification questions is decided by the President under Article 103.'),
                              SizedBox(height: 8),
                              Text('5. The __________ of Parliament to make laws is given under Article 245.'),
                              SizedBox(height: 8,),
                              Text('6. The introduction of __________ requires the recommendation of the President.'),
                              SizedBox(height: 8,),
                              Text('8. The Supreme Court is a __________ of record, as per Article 129.'),
                              SizedBox(height: 8,),
                              Text('9. The Supreme Court’s __________ powers are used to issue writs for enforcement of rights.'),
                              SizedBox(height: 8,),
                              Text('10. The __________ and allowances of the Chairman and Speaker are prescribed by Parliament.'),
                              SizedBox(height: 8,)
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
                          level: 'Hard',
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