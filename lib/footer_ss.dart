import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFooter extends StatelessWidget {
  final Function(int) onItemTapped;
  final int currentIndex;

  const CustomFooter({Key? key, required this.onItemTapped, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff426586),
        border: Border.all(color: Color(0xff648aae), width: 3.0),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navIcon(Icons.person, 'Profile'.tr, 0),
          _navIcon(Icons.gavel, "Law".tr, 1),
          _navIcon(Icons.sports_esports, "Game".tr, 2),
          _navIcon(Icons.bar_chart, "Progress".tr, 3),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Color(0xff648aae) : Colors.transparent,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 30),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
