// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'ThreeDText.dart';
// import 'demo.dart';
//
// class UserDashboard extends StatefulWidget {
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }
//
// class _UserDashboardState extends State<UserDashboard> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Map<String, dynamic>? userData;
//   List<Map<String, dynamic>> rankedUsers = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }
//
//   Future<void> _fetchUserData() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // Fetch current user data
//     final userDoc = await _firestore.collection('user_activity').doc(user.uid).get();
//     if (userDoc.exists) {
//       setState(() {
//         userData = userDoc.data();
//       });
//     }
//
//     // Fetch all users for ranking
//     final allUsersQuery = await _firestore.collection('user_activity').get();
//     final usersCollection = await _firestore.collection('users').get();
//
//     // Create a map of user IDs to usernames
//     final userNames = {
//       for (var doc in usersCollection.docs)
//         doc.id: doc.data()['username'] ?? 'User'
//     };
//
//     // Calculate progress for each user and prepare for sorting
//     List<Map<String, dynamic>> usersWithProgress = [];
//
//     for (var doc in allUsersQuery.docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       final progress = _calculateTotalProgress(data);
//       final username = userNames[doc.id] ?? 'User';
//
//       usersWithProgress.add({
//         'id': doc.id,
//         'username': username,
//         'progress': progress,
//         'data': data,
//       });
//     }
//
//     // Sort by progress (descending)
//     usersWithProgress.sort((a, b) => b['progress'].compareTo(a['progress']));
//
//     setState(() {
//       rankedUsers = usersWithProgress;
//       isLoading = false;
//     });
//   }
//
//   double _calculateTotalProgress(Map<String, dynamic> data) {
//     final eCount = (data['e_count'] ?? 0).toDouble();
//     final lCount = (data['l_count'] ?? 0).toDouble();
//     final jCount = (data['j_count'] ?? 0).toDouble();
//     final game1Count = (data['game_1_level_count'] ?? 0).toDouble();
//     final game2Count = ((data['game_2_level'] ?? 'EEE').length).toDouble();
//     final game3Count = ((data['game_3_level'] ?? 'EEE').length).toDouble();
//
//     return (eCount/30 + lCount/30 + jCount/28 + game1Count/88 + game2Count/3 + game3Count/3) / 6;
//   }
//
//   Widget _buildHalfCircleProgress() {
//     if (userData == null) return SizedBox();
//
//     final eProgress = (userData!['e_count'] ?? 0) / 30;
//     final lProgress = (userData!['l_count'] ?? 0) / 30;
//     final jProgress = (userData!['j_count'] ?? 0) / 28;
//     final game1Progress = (userData!['game_1_level_count'] ?? 0) / 88;
//
//     final totalProgress = (eProgress + lProgress + jProgress + game1Progress) / 4;
//
//     return SizedBox(
//       height: 150,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Background half circle (unprogressed/remaining section)
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: CustomPaint(
//               painter: _HalfCirclePainter(
//                 progress: 1.0,
//                 color: Colors.grey.withOpacity(0.3),
//               ),
//             ),
//           ),
//           // Progress segments
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: CustomPaint(
//               painter: _HalfCirclePainter(
//                 progress: eProgress,
//                 color: Color(0xff20336a),//1
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: CustomPaint(
//               painter: _HalfCirclePainter(
//                 progress: lProgress,
//                 color: Color(0xff426586),//
//                 startAngle: eProgress * 180,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: CustomPaint(
//               painter: _HalfCirclePainter(
//                 progress: jProgress,
//                 color: Color(0xff648aae),//1
//                 startAngle: (eProgress + lProgress) * 180,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 300,
//             height: 200,
//             child: CustomPaint(
//               painter: _HalfCirclePainter(
//                 progress: game1Progress,
//                 color: Colors.green,
//                 startAngle: (eProgress + lProgress + jProgress) * 180,
//               ),
//             ),
//           ),
//           // Center text
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '${(totalProgress * 100).toStringAsFixed(1)}%',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff426586),
//                 ),
//               ),
//               Text(
//                 'Overall Progress',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xff648aae),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//
//   }
//
//   Widget _buildCircularProgress(String title, int count, int total, Color color) {
//     final progress = count / total;
//
//     return Column(
//       children: [
//         SizedBox(
//           width: 80,
//           height: 80,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: CircularProgressIndicator(
//                   value: progress,
//                   strokeWidth: 8,
//                   backgroundColor: color.withOpacity(0.2),
//                   valueColor: AlwaysStoppedAnimation<Color>(color),
//                 ),
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff426586),
//                     ),
//                   ),
//                   Text(
//                     '$count',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff648aae),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildGameProgressBar(String gameName, double progress, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             gameName,
//             style: TextStyle(
//               color: Color(0xff426586),
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 8),
//           Stack(
//             children: [
//               Container(
//                 height: 20,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               FractionallySizedBox(
//                 widthFactor: progress,
//                 child: Container(
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//
//               Positioned(
//                 right: 10,
//                 child: Text(
//                   '${(progress * 100).toStringAsFixed(0)}%',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildGamesProgress() {
//     if (userData == null) return SizedBox();
//
//     final game1Count = userData!['game_1_level_count'] ?? 0;
//     final game1Progress = game1Count / 88;
//
//     final game2Levels = (userData!['game_2_level'] ?? 'EEE').toString();
//     final game2Progress = game2Levels.length / 3;
//
//     final game3Levels = (userData!['game_3_level'] ?? 'EEE').toString();
//     final game3Progress = game3Levels.length / 3;
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ThreeDText(text: 'GAMES PROGRESS', fontSize: 30,),
//           SizedBox(height: 20),
//           _buildGameProgressBar(
//             'Constitution Chronicles Drag To Win',
//             game1Progress,
//             //'Level $game1Count/88',
//             Color(0xff426586),
//           ),
//           _buildGameProgressBar(
//             'Guess the Constitution',
//             game2Progress,
//             //'Completed: ${game2Levels.replaceAll('E', 'Easy ').replaceAll('M', 'Medium ').replaceAll('H', 'Hard ').trim()}',
//             Color(0xff648aae),
//           ),
//           _buildGameProgressBar(
//             'Flip Cards',
//             game3Progress,
//             //'Completed: ${game3Levels.replaceAll('E', 'Easy ').replaceAll('M', 'Medium ').replaceAll('H', 'Hard ').trim()}',
//             Color(0xff5a8bb8),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildUserRanking() {
//     if (isLoading) return Center(child: CircularProgressIndicator());
//
//     final currentUserId = _auth.currentUser?.uid;
//     int currentUserRank = rankedUsers.indexWhere((user) => user['id'] == currentUserId) + 1;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ThreeDText(text: 'Your Rank: $currentUserRank/${rankedUsers.length}', fontSize: 35),
//         Container(
//           height: 300,
//           child: ListView.builder(
//             itemCount: rankedUsers.length,
//             itemBuilder: (context, index) {
//               final user = rankedUsers[index];
//               final rank = index + 1;
//               final totalProgress = user['progress'] * 100;
//               final isCurrentUser = user['id'] == currentUserId;
//
//               Color medalColor;
//               if (rank == 1) medalColor = Colors.amber;
//               else if (rank == 2) medalColor = Colors.grey;
//               else if (rank == 3) medalColor = Color(0xffcd7f32);
//               else medalColor = Color(0xff648aae);
//
//               return Container(
//                 margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Color(0xff426586),
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: isCurrentUser ? Colors.green : Color(0xff648aae),
//                     width: 2,
//                   ),
//                 ),
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: medalColor,
//                     child: Text(
//                       '$rank',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   title: Text(
//                     user['username'],
//                     style: TextStyle(
//                       color: Color(0xfffafafa),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   trailing: Icon(
//                     rank == 1 ? Icons.emoji_events : Icons.shield,
//                     color: medalColor,
//                   ),
//                   subtitle: Text(
//                     '${totalProgress.toStringAsFixed(1)}% Complete',
//                     style: TextStyle(color: Color(0xfffafafa).withOpacity(0.8)),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     return Scaffold(
//       backgroundColor: Color(0xfffafafa),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 50),
//             ThreeDText(text: 'DASHBOARD', fontSize: 48),
//             SizedBox(height: 100),
//             _buildHalfCircleProgress(),
//             SizedBox(height: 100),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildCircularProgress(
//                   'Executive',
//                   userData?['e_count'] ?? 0,
//                   30,
//                   Color(0xff426586),
//                 ),
//                 _buildCircularProgress(
//                   'Legislature',
//                   userData?['l_count'] ?? 0,
//                   30,
//                   Color(0xff648aae),
//                 ),
//                 _buildCircularProgress(
//                   'Judiciary',
//                   userData?['j_count'] ?? 0,
//                   28,
//                   Color(0xff5a8bb8),
//                 ),
//               ],
//             ),
//             SizedBox(height: 130),
//             _buildGamesProgress(),
//             SizedBox(height: 150),
//             _buildUserRanking(),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class _HalfCirclePainter extends CustomPainter {
// //   final double progress;
// //   final Color color;
// //   final double startAngle;
// //
// //   _HalfCirclePainter({
// //     required this.progress,
// //     required this.color,
// //     this.startAngle = 0.0,
// //   });
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
// //     final paint = Paint()
// //       ..color = color
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 8.0
// //       ..strokeCap = StrokeCap.round;
// //
// //     final sweepAngle = progress * 180;
// //     canvas.drawArc(
// //       rect,
// //       (startAngle * 3.14 / 180) + 3.14,
// //       sweepAngle * 3.14 / 180,
// //       false,
// //       paint,
// //     );
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// // }
//

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ThreeDText.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PageController _pageController = PageController();
  Map<String, dynamic>? userData;
  List<Map<String, dynamic>> rankedUsers = [];
  bool isLoading = true;
  int _currentPage = 0;
  bool _isUpdatingProgress = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final userDoc = await _firestore.collection('user_activity').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data();
        });
      }

      await _updateAllUsersProgress();
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateAllUsersProgress() async {
    setState(() {
      _isUpdatingProgress = true;
    });

    try {
      final allUsersQuery = await _firestore.collection('user_activity').get();
      final usersCollection = await _firestore.collection('users').get();

      final userNames = {
        for (var doc in usersCollection.docs)
          doc.id: doc.data()['username'] ?? 'User'
      };

      List<Map<String, dynamic>> usersWithProgress = [];

      for (var doc in allUsersQuery.docs) {
        final data = doc.data();
        final progress = _calculateTotalProgress(data);
        final progressPercentage = (progress * 100).toStringAsFixed(2); // Store as percentage with 2 decimal places

        await doc.reference.update({
          'progress_total': double.parse(progressPercentage),
          'last_updated': FieldValue.serverTimestamp(),
        });

        usersWithProgress.add({
          'id': doc.id,
          'username': userNames[doc.id] ?? 'User',
          'progress': double.parse(progressPercentage),
          'data': data,
        });
      }

      usersWithProgress.sort((a, b) => b['progress'].compareTo(a['progress']));

      setState(() {
        rankedUsers = usersWithProgress;
        isLoading = false;
        _isUpdatingProgress = false;
      });
    } catch (e) {
      print('Error updating user progress: $e');
      setState(() {
        isLoading = false;
        _isUpdatingProgress = false;
      });
    }
  }

  double _calculateTotalProgress(Map<String, dynamic> data) {
    final eCount = (data['e_count'] ?? 0).toDouble();
    final lCount = (data['l_count'] ?? 0).toDouble();
    final jCount = (data['j_count'] ?? 0).toDouble();
    final game1Count = (data['game_1_level_count'] ?? 0).toDouble();
    final game2Count = ((data['game_2_level'] ?? 'EEE').toString().length).toDouble();
    final game3Count = ((data['game_3_level'] ?? 'EEE').toString().length).toDouble();

    double executiveWeight = eCount / 30;
    double legislatureWeight = lCount / 30;
    double judiciaryWeight = jCount / 28;
    double game1Weight = game1Count / 88;
    double game2Weight = game2Count / 3;
    double game3Weight = game3Count / 3;

    double totalProgress = (executiveWeight + legislatureWeight + judiciaryWeight +
        game1Weight + game2Weight + game3Weight) / 6;

    return totalProgress.clamp(0.0, 1.0);
  }

  Widget _buildSectionOne() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          ThreeDText(text: 'DASHBOARD', fontSize: 48),
          SizedBox(height: 100),
          _buildHalfCircleProgress(),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularProgress(
                'Executive',
                userData?['e_count'] ?? 0,
                30,
                Color(0xff426586),
              ),
              _buildCircularProgress(
                'Legislature',
                userData?['l_count'] ?? 0,
                30,
                Color(0xff648aae),
              ),
              _buildCircularProgress(
                'Judiciary',
                userData?['j_count'] ?? 0,
                28,
                Color(0xff5a8bb8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTwo() {
    return SingleChildScrollView(child: _buildGamesProgress());
  }

  Widget _buildSectionThree() {
    return _buildUserRanking();
  }

  Widget _buildCircularProgress(String title, int count, int total, Color color) {
    final progress = count / total;

    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff426586),
                    ),
                  ),
                  Text(
                    '$count',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff648aae),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGameProgressBar(String gameName, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gameName,
            style: TextStyle(
              color: Color(0xff426586),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGamesProgress() {
    if (userData == null) return SizedBox();

    final game1Count = userData!['game_1_level_count'] ?? 0;
    final game1Progress = game1Count / 88;

    final game2Levels = (userData!['game_2_level'] ?? 'EEE').toString();
    final game2Progress = game2Levels.length / 3;

    final game3Levels = (userData!['game_3_level'] ?? 'EEE').toString();
    final game3Progress = game3Levels.length / 3;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 180),
          ThreeDText(text: 'GAMES PROGRESS', fontSize: 30),
          SizedBox(height: 20),
          _buildGameProgressBar(
            'Constitution Chronicles Drag To Win',
            game1Progress,
            Color(0xff426586),
          ),
          _buildGameProgressBar(
            'Guess the Constitution',
            game2Progress,
            Color(0xff648aae),
          ),
          _buildGameProgressBar(
            'Flip Cards',
            game3Progress,
            Color(0xff5a8bb8),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUserRanking() {
    if (isLoading || _isUpdatingProgress) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            if (_isUpdatingProgress)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Updating progress for all users...'),
              ),
          ],
        ),
      );
    }

    final currentUserId = _auth.currentUser?.uid;
    int currentUserRank = rankedUsers.indexWhere((user) => user['id'] == currentUserId) + 1;

    return Column(
      children: [
        SizedBox(height: 40),
        ThreeDText(
          text: 'Your Rank: $currentUserRank/${rankedUsers.length}',
          fontSize: 35,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _updateAllUsersProgress,
          child: Text('Refresh Rankings'),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff426586),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: rankedUsers.length,
            itemBuilder: (context, index) {
              final user = rankedUsers[index];
              final rank = index + 1;
              final totalProgress = user['progress'] ?? 0.0; // Already stored as percentage
              final isCurrentUser = user['id'] == currentUserId;

              Color medalColor;
              if (rank == 1)
                medalColor = Colors.amber;
              else if (rank == 2)
                medalColor = Colors.grey;
              else if (rank == 3)
                medalColor = Color(0xffcd7f32);
              else
                medalColor = Color(0xff648aae);

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xff426586),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isCurrentUser ? Colors.green : Color(0xff648aae),
                    width: 2,
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: medalColor,
                    child: Text(
                      '$rank',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user['username'],
                    style: TextStyle(
                      color: Color(0xfffafafa),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(
                    rank == 1 ? Icons.emoji_events : Icons.shield,
                    color: medalColor,
                  ),
                  subtitle: Text(
                    '${totalProgress.toStringAsFixed(1)}% Complete',
                    style: TextStyle(color: Color(0xfffafafa).withOpacity(0.8)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xfffafafa),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
          if (page == 2) {
            _updateAllUsersProgress();
          }
        },
        scrollDirection: Axis.vertical,
        children: [
          _buildSectionOne(),
          _buildSectionTwo(),
          _buildSectionThree(),
        ],
      ),
      floatingActionButton: _currentPage != 0
          ? FloatingActionButton(
        backgroundColor: Color(0xff426586),
        child: Icon(Icons.arrow_upward, color: Colors.white),
        onPressed: () {
          _pageController.previousPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
      )
          : null,
    );
  }

  Widget _buildHalfCircleProgress() {
    if (userData == null) return SizedBox();

    final eProgress = (userData!['e_count'] ?? 0) / 30;
    final lProgress = (userData!['l_count'] ?? 0) / 30;
    final jProgress = (userData!['j_count'] ?? 0) / 28;
    final game1Progress = (userData!['game_1_level_count'] ?? 0) / 88;

    final totalProgress = (eProgress + lProgress + jProgress + game1Progress) / 4;

    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: _HalfCirclePainter(
                progress: 1.0,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: _HalfCirclePainter(
                progress: eProgress,
                color: Color(0xff20336a),
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: _HalfCirclePainter(
                progress: lProgress,
                color: Color(0xff426586),
                startAngle: eProgress * 180,
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: _HalfCirclePainter(
                progress: jProgress,
                color: Color(0xff648aae),
                startAngle: (eProgress + lProgress) * 180,
              ),
            ),
          ),
          SizedBox(
            width: 300,
            height: 200,
            child: CustomPaint(
              painter: _HalfCirclePainter(
                progress: game1Progress,
                color: Colors.green,
                startAngle: (eProgress + lProgress + jProgress) * 180,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${(totalProgress * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff426586),
                ),
              ),
              Text(
                'Overall Progress',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff648aae),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HalfCirclePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double startAngle;

  _HalfCirclePainter({
    required this.progress,
    required this.color,
    this.startAngle = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height * 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final sweepAngle = progress * 180;
    canvas.drawArc(
      rect,
      (startAngle * 3.14 / 180) + 3.14,
      sweepAngle * 3.14 / 180,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}