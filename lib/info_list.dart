import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoListPage extends StatefulWidget {
  final String section;
  InfoListPage({required this.section});

  @override
  _InfoListPageState createState() => _InfoListPageState();
}

class _InfoListPageState extends State<InfoListPage> {
  late Stream<QuerySnapshot> _ssStream;
  int _selectedIndex = 1;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Set<String> _viewedContentIds = {}; // To track viewed content

  @override
  void initState() {
    super.initState();
    _ssStream = _firestore
        .collection('SS')
        .where('Section', isEqualTo: widget.section)
        .orderBy("Sr_No")
        .snapshots();
  }

  Future<void> _updateUserActivity(String contentId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Check if this content has already been viewed
    if (_viewedContentIds.contains(contentId)) return;

    _viewedContentIds.add(contentId); // Mark as viewed

    // Get the user's activity document
    final userActivityRef = _firestore.collection('user_activity').doc(user.uid);

    // Determine which count field to update based on the section
    String fieldToUpdate;
    switch (widget.section) {
      case 'E':
        fieldToUpdate = 'e_count';
        break;
      case 'J':
        fieldToUpdate = 'j_count';
        break;
      case 'L':
        fieldToUpdate = 'l_count';
        break;
      default:
        return;
    }

    // Atomically increment the count
    await userActivityRef.update({
      fieldToUpdate: FieldValue.increment(1),
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showDescriptionPopup(String shortDesc, String detailedDesc, String contentId) {
    String formattedDetailDesc = detailedDesc.replaceAll('. ', '.\n');

    // Update user activity when description is viewed
    _updateUserActivity(contentId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF648AAE),
          contentPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFFFAFAFA), width: 2),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  shortDesc,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFAFAFA),
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 1,
                        color: Color(0xFF426586),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey),
                Text(
                  formattedDetailDesc,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFAFAFA),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close", style: TextStyle(color: Colors.white)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _openVideo(String videoLink, String contentId) {
    // Update user activity when video is viewed
    _updateUserActivity(contentId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        WebViewController controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(videoLink));

        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return WillPopScope(
          onWillPop: () async {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
            return true;
          },
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.all(20),
            child: Container(
              height: 600,
              width: 400,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: WebViewWidget(controller: controller),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight,
                        ]);
                        Navigator.pop(context);
                      },
                      child: Text("Close", style: TextStyle(color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            width: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff426586), Color(0xff648aae)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              child: Text(
                widget.section == "E" ? "Executive" : widget.section == "L" ? "Legislature" : "Judiciary",
                style: TextStyle(
                  color: Color(0xfffafafa),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _ssStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No records found"));
                }

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: snapshot.data!.docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    String contentId = doc.id; // Get the document ID as content identifier

                    return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                        color: Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xff648aae)),),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            data['Title'] ?? '',
                            style: TextStyle(
                            color: Color(0xff648aae),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                           ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            data['Short_Description'] ?? '',
                            style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                           ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                            mainAxisSize: MainAxisSize.min,
                          children: [
                          GestureDetector(
                            onTap: () {
                            _openVideo(data['Video_Link'] ?? '', contentId);
                            },
                            child: Icon(Icons.ondemand_video_outlined, color: Colors.black54, size: 25),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                            _showDescriptionPopup(
                            data['Short_Description'] ?? '',
                            data['Detailed_Description'] ?? '',
                            contentId,
                          );
                          },
                            child: Icon(Icons.insert_drive_file_outlined, color: Colors.black54, size: 25),
                                  ),
                                ],
                              ),
                            ),
                          ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}