// import 'package:flutter/material.dart';
//
// class CustomSwitch extends StatefulWidget {
//   @override
//   _CustomSwitchState createState() => _CustomSwitchState();
// }
//
// class _CustomSwitchState extends State<CustomSwitch> {
//   bool isDarkMode = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isDarkMode = !isDarkMode;
//         });
//       },
//       child: Container(
//         width: 50,
//         height: 30,
//         decoration: BoxDecoration(
//           color: isDarkMode ? Color(0xFF426586) : Color(0xFF648AAE), // Track color
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Light Mode Text (Left-aligned)
//             Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Text(
//                   "      Light",
//                   style: TextStyle(
//                     color: isDarkMode ? Colors.transparent : Colors.white, // Hide text in Dark Mode
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//             // Dark Mode Text (Right-aligned)
//             Align(
//               alignment: Alignment.center,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: Text(
//                   "Dark",
//                   style: TextStyle(
//                     color: isDarkMode ? Colors.white : Colors.transparent, // Hide text in Light Mode
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//             ),
//             // Circular Thumb
//             AnimatedPositioned(
//               duration: Duration(milliseconds: 300),
//               left: isDarkMode ? 70 : 5, // Move thumb based on mode
//               right: isDarkMode ? 5 : null,
//               child: Container(
//                 width: 28,
//                 height: 28,
//                 decoration: BoxDecoration(
//                   color: isDarkMode ? Color(0xFF648AAE) : Color(0xFF426586), // Thumb color
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Icon(
//                     isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
//                     color: Color(0xFFFAFAFA), // White icon
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Function(bool) toggleDarkMode;

  CustomSwitch({required this.toggleDarkMode});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
          widget.toggleDarkMode(isDarkMode);
        });
      },
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xFF426586) : Color(0xFF648AAE),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "      Light",
                  style: TextStyle(
                    color: isDarkMode ? Colors.transparent : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "Dark",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.transparent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: isDarkMode ? 70 : 5,
              right: isDarkMode ? 5 : null,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xFF648AAE) : Color(0xFF426586),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: Color(0xFFFAFAFA),
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
