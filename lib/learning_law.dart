import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansthaein_samvidhan/info_list.dart';

class LearningLawPage extends StatelessWidget {
  //final VoidCallback onNavigateToInfo;

  //LearningLawPage({required this.onNavigateToInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(height: 20),
        gradientButton(context, "Executive".tr, "E"),
        SizedBox(height: 20),
        gradientButton(context, "Legislature".tr, "L"),
        SizedBox(height: 20),
        gradientButton(context, "Judiciary".tr, "J"),
      ],
    );
  }

  Widget gradientButton(BuildContext context, String title, String section) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfoListPage(section: section)),
        );
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff426586), Color(0xff648aae)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
