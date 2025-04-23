import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

import 'game_3_result.dart';

class FlipCardGame extends StatefulWidget {
  final String level;

  const FlipCardGame({Key? key, required this.level}) : super(key: key);

  @override
  _FlipCardGameState createState() => _FlipCardGameState();
}

class _FlipCardGameState extends State<FlipCardGame> {

  final Map<String, Map<String, String>> gameData = {
    'easy': {
      'E_Section_I': 'The President of India',
      'E_Section_II': 'Executive power of the Union',
      'E_Section_III': 'Election of President',
      'E_Section_IV': 'Manner of election of President',
      // 'E_Section_V': 'Term of office of President',
      // 'J_Section_XXI': 'Transfer of certain cases',
      // 'J_Section_XXII': 'Ancillary powers of the Supreme Court',
      // 'J_Section_XXIII': 'Law declared by Supreme Court to be binding on all courts',
    },

    'medium': {
      'Eligibility for re-election': 'A person who holds, or who has held, office as President shall, subject to the other provisions of this Constitution, be eligible for re-election to that office.',
      'Qualifications for election as President': '(1) No person shall be eligible for election as President unless he— (a) is a citizen of India, (b) has completed the age of thirty-five years, and (c) is qualified for election as a member of the House of the People. (2) A person shall not be eligible for election as President if he holds any office of profit under the Government of India or the Government of any State or under any local or other authority subject to the control of any of the said Governments.',
      'Conditions of President\'s office': '(1) The President shall not be a member of either House of Parliament or of a House of the Legislature of any State. (2) The President shall not hold any other office of profit. (3) The President shall be entitled without payment of rent to the use of his official residences. (4) The emoluments and allowances of the President shall not be diminished during his term of office.',
      'Oath or affirmation by the President': 'Every President shall make and subscribe in the presence of the Chief Justice of India an oath or affirmation in the following form: "I, A.B., do swear in the name of God that I will faithfully execute the office of President..."',
      'Procedure for impeachment of the President': '(1) When a President is to be impeached for violation of the Constitution, the charge shall be preferred by either House of Parliament. (2) No such charge shall be preferred unless certain conditions are met. (3) The other House shall investigate the charge. (4) If resolution is passed by majority, President shall be removed.',
      'Duties of Prime Minister': 'It shall be the duty of the Prime Minister to communicate to the President all decisions of the Council of Ministers relating to the administration of the affairs of the Union and proposals for legislation.',
      'Constitution of Parliament': 'There shall be a Parliament for the Union which shall consist of the President and two Houses to be known respectively as the Council of States and the House of the People.',
      'Composition of the Council of States': '(1) The Council of States shall consist of— (a) twelve members to be nominated by the President and (b) representatives of the States. (2) The allocation of seats shall be in accordance with the provisions in the Fourth Schedule.',
      'Composition of the House of the People': '(1) The House of the People shall consist of members chosen by direct election from territorial constituencies in the States and members to represent the Union territories. (2) For allotment of seats, population ratio shall be maintained.',
      'Establishment and constitution of the Supreme Court': '(1) There shall be a Supreme Court of India consisting of a Chief Justice and other Judges. (2) Every Judge shall be appointed by the President and shall hold office until age 65. (3) Qualifications for appointment as Judge.',
    },
    'hard': {
      'E_Section_XIV': '(1) In the event of vacancy in office of President, the Vice-President shall act as President until new President enters office. (2) When President is unable to discharge functions, Vice-President shall discharge them. (3) Vice-President shall have all powers of President during this period.',
      'E_Section_XV': '(1) The Vice-President shall be elected by members of both Houses of Parliament. (2) Vice-President shall not be member of either House. (3) Qualifications for election as Vice-President. (4) No office of profit condition.',
      'E_Section_XVI': 'The Vice-President shall hold office for five years: (a) may resign, (b) may be removed by resolution, (c) continues until successor enters office.',
      'E_Section_XVII': '(1) Election to fill vacancy by expiration of term shall be completed before term ends. (2) Election for vacancy by death/resignation shall be held as soon as possible.',
      'E_Section_XVIII': 'Every Vice-President shall make and subscribe before the President an oath or affirmation: "I, A.B., do swear in the name of God that I will bear true faith and allegiance to the Constitution..."',
      'J_Section_XIII': '(1) Appeal shall lie to Supreme Court from High Court if case involves substantial question of law. (2) Ground of wrongly decided constitutional question may be urged. (3) No appeal from single Judge unless Parliament provides.',
      'J_Section_XIV': '(1) Appeal shall lie to Supreme Court from High Court in criminal proceeding if (a) acquittal reversed to death sentence, or (b) case withdrawn and death sentence given, or (c) High Court certifies fit for appeal. (2) Parliament may confer further powers.',
      'J_Section_XV': 'Every High Court passing judgment in certain cases may determine whether certificate for appeal to Supreme Court may be given.',
      'J_Section_XVI': 'Until Parliament otherwise provides, Supreme Court shall have jurisdiction in matters where articles 133/134 don\'t apply but Federal Court had jurisdiction.',
      'J_Section_XVII': '(1) Supreme Court may grant special leave to appeal from any court/tribunal in India. (2) Doesn\'t apply to Armed Forces courts.',
      'L_Section_XVI': 'Speaker/Deputy Speaker: (a) vacates if ceases to be member, (b) may resign, (c) may be removed by resolution with 14 days notice. Speaker continues until first meeting after dissolution.',
      'L_Section_XVII': '(1) If Speaker vacant, Deputy Speaker performs duties. If both vacant, Governor appoints. (2) During absence, Deputy Speaker or determined person acts as Speaker.',
      'L_Section_XVIII': '(1) During removal resolution, Speaker/Deputy Speaker shall not preside. (2) Speaker has right to speak/vote on removal resolution.',
      'L_Section_XIX': 'Legislative Council shall choose Chairman and Deputy Chairman, and fill vacancies.',
      'L_Section_XX': 'Chairman/Deputy Chairman: (a) vacates if ceases to be member, (b) may resign, (c) may be removed by resolution with 14 days notice.',
      'J_Section_XXIV': 'Enforcement of decrees and orders of the Supreme Court and orders as to discovery, etc.',
      'J_Section_XXV': 'Power of the President to consult the Supreme Court',
      'L_Section_XXVI': 'Voting in Houses, power of Houses to act notwithstanding vacancies and quorum',
      'L_Section_XXVII': 'Vacation of seats',
      'L_Section_XXVIII': 'Disqualifications for membership',
      'L_Section_XXIX': 'Decision on questions as to disqualifications of members',
      'L_Section_XXX': 'Penalty for sitting and voting before making oath or affirmation under article 188 or when not qualified or when disqualified',

    },
  };
  // Game data for different levels
  // final Map<String, Map<String, String>> gameData = {
  //   'easy': {
  //     'E_Section_I': 'The President of India',
  //     'E_Section_II': 'Executive power of the Union',
  //     'E_Section_III': 'Election of President',
  //     'E_Section_IV': 'Manner of election of President',
  //     'E_Section_V': 'Term of office of President',
  //     'J_Section_XXI': 'Transfer of certain cases',
  //     'J_Section_XXII': 'Ancillary powers of the Supreme Court',
  //     'J_Section_XXIII': 'Law declared by Supreme Court to be binding on all courts',
  //     'J_Section_XXIV': 'Enforcement of decrees and orders of the Supreme Court',
  //     'J_Section_XXV': 'Power of the President to consult the Supreme Court',
  //   },
  //   'medium': {
  //     'Eligibility for re-election': 'A person who holds, or who has held, office as President shall be eligible for re-election...',
  //     'Qualifications for election as President': 'No person shall be eligible for election as President unless he is a citizen of India...',
  //     'Conditions of President\'s office': 'The President shall not be a member of either House of Parliament...',
  //     'Oath or affirmation by the President': 'Every President shall make and subscribe an oath or affirmation...',
  //     'Procedure for impeachment of the President': 'When a President is to be impeached for violation of the Constitution...',
  //   },
  //   'hard': {
  //     'E_Section_XIV': 'In the event of the occurrence of any vacancy in the office of the President...',
  //     'E_Section_XV': 'The Vice-President shall be elected by the members of an electoral college...',
  //     'E_Section_XVI': 'The Vice-President shall hold office for a term of five years...',
  //     'E_Section_XVII': 'An election to fill a vacancy caused by the expiration of the term...',
  //     'E_Section_XVIII': 'Every VicePresident shall, before entering upon his office, make and subscribe an oath...',
  //   },
  // };

  List<CardModel> cards = [];
  List<int> selectedCards = [];
  int pairsFound = 0;
  bool isProcessing = false;
  Timer? _timer;
  int _timeRemaining = 0;
  Duration? _completionTime;
  bool _isGameOver = false;
  bool _isLevelCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeGame() {
    final levelData = gameData[widget.level.toLowerCase()] ?? {};
    final keys = levelData.keys.toList();
    final values = levelData.values.toList();

    // Create pairs of cards (term + definition)
    cards = [];
    for (int i = 0; i < keys.length; i++) {
      cards.add(CardModel(
        id: i * 2,
        text: keys[i],
        isTerm: true,
        isMatched: false,
        isFlipped: false,
      ));
      cards.add(CardModel(
        id: i * 2 + 1,
        text: values[i],
        isTerm: false,
        isMatched: false,
        isFlipped: false,
      ));
    }

    // Shuffle the cards
    cards.shuffle(Random());

    pairsFound = 0;
    selectedCards = [];
    isProcessing = false;
    _isGameOver = false;
    _isLevelCompleted = false;
    _completionTime = null;

    // Set time limit based on level
    switch (widget.level.toLowerCase()) {
      case 'easy':
        _timeRemaining = 2 * 60; // 2 minutes
        break;
      case 'medium':
        _timeRemaining = 3 * 60; // 3 minutes
        break;
      case 'hard':
        _timeRemaining = 3 * 60 + 30; // 3.5 minutes
        break;
    }

    // Start the timer
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0 && !_isLevelCompleted) {
        setState(() {
          _timeRemaining--;
        });
      } else if (_timeRemaining <= 0 && !_isGameOver) {
        _isGameOver = true;
        _timer?.cancel();
        _showTimeUpDialog();
      }
    });
  }

  void _handleCardTap(int index) {
    if (isProcessing || cards[index].isFlipped || cards[index].isMatched || _isGameOver) {
      return;
    }

    setState(() {
      cards[index].isFlipped = true;
      selectedCards.add(index);
    });

    if (selectedCards.length == 2) {
      _checkForMatch();
    }
  }

  void _checkForMatch() {
    isProcessing = true;
    final firstCard = cards[selectedCards[0]];
    final secondCard = cards[selectedCards[1]];

    // Check if we have a term-definition pair
    bool isMatch = false;
    if (firstCard.isTerm && !secondCard.isTerm) {
      isMatch = gameData[widget.level.toLowerCase()]?[firstCard.text] == secondCard.text;
    } else if (!firstCard.isTerm && secondCard.isTerm) {
      isMatch = gameData[widget.level.toLowerCase()]?[secondCard.text] == firstCard.text;
    }

    if (isMatch) {
      // Match found
      setState(() {
        cards[selectedCards[0]].isMatched = true;
        cards[selectedCards[1]].isMatched = true;
        pairsFound++;
      });

      // Check if game is complete
      if (pairsFound == (gameData[widget.level.toLowerCase()]?.length ?? 0)) {
        _isLevelCompleted = true;
        _completionTime = Duration(seconds: _getInitialTime() - _timeRemaining);
        _timer?.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          _navigateToResultPage(true);
        });
      }
    } else {
      // No match - flip cards back after delay
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          cards[selectedCards[0]].isFlipped = false;
          cards[selectedCards[1]].isFlipped = false;
        });
      });
    }

    // Reset selected cards after delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        selectedCards = [];
        isProcessing = false;
      });
    });
  }

  void _navigateToResultPage(bool isSuccess) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Game3ResultPage(
          isSuccess: isSuccess,
          level: widget.level,
          completionTime: _completionTime ?? Duration.zero,
        ),
      ),
    );
  }

  int _getInitialTime() {
    switch (widget.level.toLowerCase()) {
      case 'easy':
        return 2 * 60;
      case 'medium':
        return 3 * 60;
      case 'hard':
        return (3 * 60 + 30);
      default:
        return 0;
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('You have cleared the ${widget.level} level!'),
            const SizedBox(height: 10),
            Text('Completion time: ${_formatTime(_completionTime?.inSeconds ?? 0)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeGame();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time\'s Up!'),
        content: Text('You didn\'t complete the ${widget.level} level in time.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeGame();
            },
            child: const Text('Try Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _navigateToResultPage(false);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 45, bottom: 16),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            width: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "FLIP CARDS",
                style: TextStyle(color: Color(0xfffafafa), fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Time Remaining: ${_formatTime(_timeRemaining)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  if (cards[index].isMatched) {
                    return const SizedBox.shrink(); // Hide matched cards
                  }
                  return GestureDetector(
                    onTap: () => _handleCardTap(index),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: cards[index].isFlipped
                          ? _buildCardFront(cards[index])
                          : _buildCardBack(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff426586), Color(0xff648aae)]),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.help_outline, color: Colors.white, size: 40),
      ),
    );
  }

  Widget _buildCardFront(CardModel card) {
    return Container(
      decoration: BoxDecoration(
        color: card.isTerm ? Colors.orange[100] : Colors.green[100],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            card.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: card.isTerm ? 16 : 14,
              fontWeight: card.isTerm ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class CardModel {
  final int id;
  final String text;
  final bool isTerm;
  bool isMatched;
  bool isFlipped;

  CardModel({
    required this.id,
    required this.text,
    required this.isTerm,
    required this.isMatched,
    required this.isFlipped,
  });
}