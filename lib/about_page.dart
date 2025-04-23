import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background decoration for the AppBar
          Container(
            height: kToolbarHeight + 30, // Adjust height for decoration
            decoration: BoxDecoration(
              color: Color(0xff426586),
              border: Border.all(color: Color(0xff648aae), width: 3.0),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
            ),
          ),

          // Page Content
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Text(
                          "About Sansthaein Aur Samvidhan",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Problem Faced"),
                      _buildText(
                          "Since the adoption of our Constitution, India's legal literacy rate has remained low."
                              " The complex language of the Constitution creates a significant barrier for citizens to comprehend its implications."
                      ),

                      _buildSectionTitle("Background"),
                      _buildText(
                          "About 70% of people in rural areas are illiterate, and even more are unaware of their legal rights."
                              " The lack of legal awareness leads to deception, exploitation, and deprivation of rights."
                      ),

                      _buildSectionTitle("Our Solution"),
                      _buildText(
                          "Imagine a digital platform where citizens can explore the Indian Constitution in an interactive way."
                              " 'Sansthaein Aur Samvidhan' is a gamified platform designed to make learning about the Constitution engaging and user-friendly."
                      ),

                      _buildSectionTitle("Features"),
                      _buildBulletPoints([
                        "Simplified explanations of the Indian Constitution",
                        "Covers Legislature, Executive, and Judiciary (Part V & Part VI)",
                        "Gamified learning with spin-the-wheel, board games, and cards",
                        "Multimedia and language translation for inclusivity",
                        "Backend database for structured constitutional concepts"
                      ]),

                      _buildSectionTitle("Outcomes"),
                      _buildBulletPoints([
                        "A functional prototype",
                        "User feedback analysis",
                        "Detailed report on development process",
                        "Empowering citizens with constitutional knowledge"
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff426586)),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletPoints(List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Padding(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("\u2022 ", style: TextStyle(fontSize: 16)),
            Expanded(child: Text(point, style: TextStyle(fontSize: 16))),
          ],
        ),
      ))
          .toList(),
    );
  }
}
