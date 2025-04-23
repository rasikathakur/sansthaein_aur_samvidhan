import 'package:flutter/material.dart';

class ThreeDText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double letterSpacing;
  final Color primaryColor;
  final Color shadowColor;
  final Color highlightColor;
  final double shadowOffset;
  final double highlightOffset;

  const ThreeDText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.letterSpacing = 2,
    this.primaryColor = const Color(0xfffafafa),
    this.shadowColor = const Color(0xff426586),
    this.highlightColor = Colors.white,
    this.shadowOffset = 2,
    this.highlightOffset = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background shadow (multiple layers for depth)
        Transform.translate(
          offset: Offset(shadowOffset + 2, shadowOffset + 2),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: shadowColor.withOpacity(0.2),
              letterSpacing: letterSpacing,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(shadowOffset + 1, shadowOffset + 1),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: shadowColor.withOpacity(0.3),
              letterSpacing: letterSpacing,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(shadowOffset, shadowOffset),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: shadowColor.withOpacity(0.4),
              letterSpacing: letterSpacing,
            ),
          ),
        ),

        // Main 3D text with gradient
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Color(0xff648aae), // Lighter blue
              Color(0xff426586), // Darker blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Stack(
            children: [
              // Bottom shadow part
              Transform.translate(
                offset: Offset(shadowOffset, shadowOffset),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: shadowColor.withOpacity(0.7),
                    letterSpacing: letterSpacing,
                  ),
                ),
              ),
              // Main text
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  letterSpacing: letterSpacing,
                ),
              ),
            ],
          ),
        ),

        // Highlight effect
        Transform.translate(
          offset: Offset(-highlightOffset, -highlightOffset),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: highlightColor.withOpacity(0.2),
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ],
    );
  }
}

// // Updated usage example:
// class DashboardHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xff426586).withOpacity(0.1),
//             Color(0xff648aae).withOpacity(0.1),
//           ],
//         ),
//       ),
//       child: ThreeDText(
//         text: 'DASHBOARD', fontSize: 48,
//         // Customize any of these optional parameters:
//         // fontSize: 52,
//         // letterSpacing: 3,
//         // primaryColor: Colors.white,
//         // shadowColor: Color(0xff20336a),
//         // highlightColor: Colors.white70,
//         // shadowOffset: 3,
//         // highlightOffset: 2,
//       ),
//     );
//   }
// }