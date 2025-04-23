// import 'package:flutter/material.dart';
//
// class LanguageSelectionPage extends StatefulWidget {
//   @override
//   _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
// }
//
// class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
//   String selectedLanguage = "English"; // Default language
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background decoration
//           Container(
//             height: kToolbarHeight + 30, // AppBar background styling
//             decoration: BoxDecoration(
//               color: Color(0xff426586),
//               border: Border.all(color: Color(0xff648aae), width: 3.0),
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
//             ),
//           ),
//
//           Column(
//             children: [
//               // Custom AppBar
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       Expanded(
//                         child: Text(
//                           "Select Language",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Language Selection
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildLanguageOption("English", "assets/eng.jpg"),
//                       _buildLanguageOption("हिन्दी", "assets/hin.jpg"),
//                       _buildLanguageOption("मराठी", "assets/mar.png"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Confirm Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff426586), // Button color
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Selected Language: $selectedLanguage")),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//                     child: Text(
//                       "Confirm",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
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
//   Widget _buildLanguageOption(String language, String iconPath) {
//     bool isSelected = selectedLanguage == language;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedLanguage = language;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff648aae) : Colors.white,
//           border: Border.all(color: Color(0xff648aae), width: 2.0),
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: isSelected
//               ? [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))]
//               : [],
//         ),
//         child: Row(
//           children: [
//             Image.asset(iconPath, height: 30, width: 30), // Add respective icons in assets
//             SizedBox(width: 10),
//             Text(
//               language,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//---


// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
//
// class LanguageSelectionPage extends StatefulWidget {
//   @override
//   _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
// }
//
// class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
//   String selectedLanguage = "English"; // Default language
//
//   final Map<String, String> _languageLocaleMap = {
//     "English": "en_US",
//     "हिन्दी": "hi_IN",
//     "मराठी": "ma_IN",
//   };
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background decoration
//           Container(
//             height: kToolbarHeight + 30,
//             decoration: BoxDecoration(
//               color: Color(0xff426586),
//               border: Border.all(color: Color(0xff648aae), width: 3.0),
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
//             ),
//           ),
//
//           Column(
//             children: [
//               // Custom AppBar
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       Expanded(
//                         child: Text(
//                           "Select Language",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Language Selection
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildLanguageOption("English", "assets/eng.jpg"),
//                       _buildLanguageOption("हिन्दी", "assets/hin.jpg"),
//                       _buildLanguageOption("मराठी", "assets/mar.png"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Confirm Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff426586),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () async {
//                     String? locale = _languageLocaleMap[selectedLanguage];
//
//                     if (locale != null) {
//                       await changeLocale(context, locale);
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Language changed to $selectedLanguage")),
//                       );
//
//                       Navigator.pop(context); // Optional: Return to previous screen
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//                     child: Text(
//                       "Confirm",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
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
//   Widget _buildLanguageOption(String language, String iconPath) {
//     bool isSelected = selectedLanguage == language;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedLanguage = language;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff648aae) : Colors.white,
//           border: Border.all(color: Color(0xff648aae), width: 2.0),
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: isSelected
//               ? [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))]
//               : [],
//         ),
//         child: Row(
//           children: [
//             Image.asset(iconPath, height: 30, width: 30),
//             SizedBox(width: 10),
//             Text(
//               language,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_translate/flutter_translate.dart';
// import 'package:get/get.dart';
//
// class LanguageSelectionPage extends StatefulWidget {
//   @override
//   _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
// }
//
// class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
//   String selectedLanguage = "English"; // Default language
//
//   // Map for flutter_translate locale strings
//   final Map<String, String> _translateLocaleMap = {
//     "English": "en_US",
//     "हिन्दी": "hi_IN",
//     "मराठी": "mr_IN", // Note: Changed from 'ma' to 'mr' for Marathi
//   };
//
//   // Map for GetX locale objects
//   final Map<String, Locale> _getXLocaleMap = {
//     "English": Locale('en', 'US'),
//     "हिन्दी": Locale('hi', 'IN'),
//     "मराठी": Locale('mr', 'IN'),
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background decoration
//           Container(
//             height: kToolbarHeight + 30,
//             decoration: BoxDecoration(
//               color: Color(0xff426586),
//               border: Border.all(color: Color(0xff648aae), width: 3.0),
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
//             ),
//           ),
//
//           Column(
//             children: [
//               // Custom AppBar
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                       Expanded(
//                         child: Text(
//                           "Select Language",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Language Selection
//               Expanded(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildLanguageOption("English", "assets/eng.jpg"),
//                       _buildLanguageOption("हिन्दी", "assets/hin.jpg"),
//                       _buildLanguageOption("मराठी", "assets/mar.png"),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // Confirm Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff426586),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () async {
//                     String? translateLocale = _translateLocaleMap[selectedLanguage];
//                     Locale? getXLocale = _getXLocaleMap[selectedLanguage];
//
//                     if (translateLocale != null && getXLocale != null) {
//                       // Update flutter_translate locale
//                       await changeLocale(context, translateLocale);
//
//                       // Update GetX locale
//                       Get.updateLocale(getXLocale);
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Language changed to $selectedLanguage")),
//                       );
//
//                       Navigator.pop(context); // Optional: Return to previous screen
//                     }
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//                     child: Text(
//                       "Confirm",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
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
//   Widget _buildLanguageOption(String language, String iconPath) {
//     bool isSelected = selectedLanguage == language;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedLanguage = language;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff648aae) : Colors.white,
//           border: Border.all(color: Color(0xff648aae), width: 2.0),
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: isSelected
//               ? [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))]
//               : [],
//         ),
//         child: Row(
//           children: [
//             Image.asset(iconPath, height: 30, width: 30),
//             SizedBox(width: 10),
//             Text(
//               language,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//---

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguage = "English"; // Default language

  // Map for GetX locale objects
  final Map<String, Locale> _getXLocaleMap = {
    "English": Locale('en', 'US'),
    "हिन्दी": Locale('hi', 'IN'),
    "मराठी": Locale('mr', 'IN'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration
          Container(
            height: kToolbarHeight + 30,
            decoration: BoxDecoration(
              color: Color(0xff426586),
              border: Border.all(color: Color(0xff648aae), width: 3.0),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
            ),
          ),

          Column(
            children: [
              // Custom AppBar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          "Select Language".tr, // Make sure this is in your translation files
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Language Selection
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLanguageOption("English", "assets/eng.jpg"),
                      _buildLanguageOption("हिन्दी", "assets/hin.jpg"),
                      _buildLanguageOption("मराठी", "assets/mar.png"),
                    ],
                  ),
                ),
              ),

              // Confirm Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff426586),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Locale? getXLocale = _getXLocaleMap[selectedLanguage];

                    if (getXLocale != null) {
                      // Update GetX locale
                      Get.updateLocale(getXLocale);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Language changed to $selectedLanguage".tr)),
                      );

                      Navigator.pop(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      "Confirm".tr,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, String iconPath) {
    bool isSelected = selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff648aae) : Colors.white,
          border: Border.all(color: Color(0xff648aae), width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))]
              : [],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 30, width: 30),
            SizedBox(width: 10),
            Text(
              language,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}