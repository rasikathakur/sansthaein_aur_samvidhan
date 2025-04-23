// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sansthaein_samvidhan/about_page.dart';
// import 'package:sansthaein_samvidhan/change_pass.dart';
// import 'package:sansthaein_samvidhan/game_select.dart';
// //import 'package:sansthaein_samvidhan/demo.dart';
// import 'package:sansthaein_samvidhan/language_Select.dart';
// import 'custom_switch.dart';
// import 'footer_ss.dart';
// import 'header_ss.dart';
// import 'learning_law.dart';
// import 'info_list.dart';
//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     // List of pages for navigation
//     final List<Widget> _pages = [
//       ProfileContent(),
//       LearningLawPage(
//       //     onNavigateToInfo: () {
//       //   setState(() {
//       //     _selectedIndex = 4; // Navigate to InfoListPage
//       //   });
//       // }
//       ),
//       GameSelectionPage(),
//       Center(child: Text('Progress Page Content', style: TextStyle(fontSize: 18))),
//       InfoListPage(section: 'E',), // This will be used when navigating from LearningLawPage
//     ];
//
//     final List<String> _titles = ['Profile', 'Let\'s Learn', 'Game', 'Progress', 'Information'];
//     return Scaffold(
//       backgroundColor: Color(0xFFFAFAFA),
//       body: Column(
//         children: [
//           // Constant Header
//           CustomHeader(title: _titles[_selectedIndex]),
//
//           // Dynamic Content Section
//           Expanded(child: _pages[_selectedIndex]),
//
//           // Constant Footer Navigation Bar
//           CustomFooter(onItemTapped: _onItemTapped, currentIndex: _selectedIndex),
//         ],
//       ),
//     );
//   }
// }
//
// // ---------------- Profile Content Widget ---------------- //
// class ProfileContent extends StatefulWidget {
//   @override
//   _ProfileContentState createState() => _ProfileContentState();
// }
//
// class _ProfileContentState extends State<ProfileContent> {
//   File? _image;
//   String? userEmail;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserEmail();
//   }
//
//   Future<void> _loadUserEmail() async {
//     final user = FirebaseAuth.instance.currentUser;
//     setState(() {
//       userEmail = user?.email ?? 'No email found';
//     });
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final ImagePicker _picker = ImagePicker();
//     try {
//       final pickedFile = await _picker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _image = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       print("Error picking image: $e");
//     }
//   }
//
//   void _showImagePickerOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Wrap(
//           children: <Widget>[
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('Gallery'),
//               onTap: () {
//                 _pickImage(ImageSource.gallery);
//                 Navigator.of(context).pop();
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text('Camera'),
//               onTap: () {
//                 _pickImage(ImageSource.camera);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(height: 20),
//           Center(
//             child: Stack(
//               children: [
//
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundColor: Color(0xFF648AAE),
//                   backgroundImage: _image != null ? FileImage(_image!) : null,
//                   child: _image == null
//                       ? Icon(Icons.person, size: 50, color: Colors.white)
//                       : null,
//                 ),
//                 Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: GestureDetector(
//                       onTap: () {
//                         _showImagePickerOptions(context);
//                       },
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.edit, color: Color(0xFF648AAE)),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(userEmail ?? 'Loading...',
//               style: TextStyle(fontSize: 16, color: Colors.black54)),
//           SizedBox(height: 20),
//
//           settingsSection('General Settings'),
//           settingTile(Icons.dark_mode, 'Mode', trailing: SizedBox(
//             width: 100, child: CustomSwitch(),)),
//           settingTile(Icons.language, 'Change Password',
//               trailing: Icon(Icons.arrow_forward_ios), onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ChangePasswordPage()),
//                 );
//               }),
//           settingTile(Icons.vpn_key, 'Language',
//               trailing: Icon(Icons.arrow_forward_ios), onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
//                 );
//               }),
//
//           SizedBox(height: 20),
//
//           settingsSection('Information'),
//           settingTile(Icons.info, 'About',
//               trailing: Icon(Icons.arrow_forward_ios), onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AboutPage()),
//                 );
//               }),
//           SizedBox(height: 30),
//
//           // ElevatedButton(
//           //   onPressed: () => Navigator.pushNamed(context, '/welcome'),
//           //   style: ElevatedButton.styleFrom(
//           //     primary: Color(0xff426586),
//           //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.circular(10),
//           //     ),
//           //   ),
//           //   child: Text(
//           //     'Log Out',
//           //     style: TextStyle(fontSize: 18, color: Colors.white),
//           //   ),
//           // ),
//
//           ElevatedButton(
//             onPressed: () async {
//               // Sign out from Firebase
//               await FirebaseAuth.instance.signOut();
//
//               // Sign out from Google if using Google Sign-In
//               await GoogleSignIn().signOut();
//
//               // Clear secure storage
//               final storage = FlutterSecureStorage();
//               await storage.delete(key: 'password');
//
//               // Navigate to welcome screen
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 '/welcome',
//                     (route) => false,
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Color(0xff426586),
//               padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               'Log Out',
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget settingsSection(String title) {
//     return Container(
//       width: double.infinity,
//       color: Color(0xFF648AAE),
//       padding: EdgeInsets.all(10),
//       child: Text(
//         title,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget settingTile(IconData icon, String text,
//       {Widget? trailing, VoidCallback? onTap}) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.black54),
//       title: Text(text),
//       trailing: GestureDetector(
//         onTap: onTap,
//         child: trailing,
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sansthaein_samvidhan/about_page.dart';
import 'package:sansthaein_samvidhan/change_pass.dart';
import 'package:sansthaein_samvidhan/game_select.dart';
import 'package:sansthaein_samvidhan/language_Select.dart';
import 'package:sansthaein_samvidhan/progress_page.dart';
import 'custom_switch.dart';
import 'footer_ss.dart';
import 'header_ss.dart';
import 'learning_law.dart';
import 'info_list.dart';
//import 'demo.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  bool isDarkMode = false;
  File? _image;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      ProfileContent(
        toggleDarkMode: _toggleDarkMode,
        isDarkMode: isDarkMode,
        image: _image,
        pickImage: _pickImage,
      ),
      LearningLawPage(),
      GameSelectionPage(),
      UserDashboard(),
      InfoListPage(section: 'E'),
    ];

    final List<String> _titles = ['Profile', 'Let\'s Learn', 'Game', 'Progress', 'Information'];
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Color(0xFFFAFAFA),
      body: Column(
        children: [
          CustomHeader(title: _titles[_selectedIndex]),
          Expanded(child: _pages[_selectedIndex]),
          CustomFooter(onItemTapped: _onItemTapped, currentIndex: _selectedIndex),
        ],
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  final Function(bool) toggleDarkMode;
  final bool isDarkMode;
  final File? image;
  final Future<void> Function(ImageSource source) pickImage;

  ProfileContent({
    required this.toggleDarkMode,
    required this.isDarkMode,
    required this.image,
    required this.pickImage,
  });

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userEmail = user?.email ?? 'No email found';
    });
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'.tr),
              onTap: () {
                widget.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'.tr),
              onTap: () {
                widget.pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF648AAE),
                  backgroundImage: widget.image != null ? FileImage(widget.image!) : null,
                  child: widget.image == null
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      _showImagePickerOptions(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
                      child: Icon(Icons.edit, color: Color(0xFF648AAE)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(userEmail ?? 'Loading...',
              style: TextStyle(fontSize: 16, color: widget.isDarkMode ? Colors.white : Colors.black54)),
          SizedBox(height: 20),
          settingsSection('General Settings'.tr),
          settingTile(Icons.dark_mode, 'Mode'.tr, trailing: SizedBox(
            width: 100, child: CustomSwitch(toggleDarkMode: widget.toggleDarkMode),)),
          settingTile(Icons.language, 'Change Password'.tr,
              trailing: Icon(Icons.arrow_forward_ios), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              }),
          settingTile(Icons.vpn_key, 'Language'.tr,
              trailing: Icon(Icons.arrow_forward_ios), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageSelectionPage()),
                );
              }),
          SizedBox(height: 20),
          settingsSection('Information'.tr),
          settingTile(Icons.info, 'About'.tr,
              trailing: Icon(Icons.arrow_forward_ios), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              }),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              final storage = FlutterSecureStorage();
              await storage.delete(key: 'password');
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/welcome',
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xff426586),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Log Out'.tr,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsSection(String title) {
    return Container(
      width: double.infinity,
      color: Color(0xFF648AAE),
      padding: EdgeInsets.all(10),
      child: Text(
        title.tr,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget settingTile(IconData icon, String text,
      {Widget? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: widget.isDarkMode ? Colors.white : Colors.black54),
      title: Text(text.tr, style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black)),
      trailing: GestureDetector(
        onTap: onTap,
        child: trailing,
      ),
    );
  }
}
