import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';
class CustomHeader extends StatelessWidget {
  final String title;

  const CustomHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff426586),
        border: Border.all(color: Color(0xff648aae), width: 3.0),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Text(
            title.tr,
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.rule, color: Colors.white),
        ],
      ),
    );
  }
}
