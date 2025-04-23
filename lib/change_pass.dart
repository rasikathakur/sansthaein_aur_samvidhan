// import 'package:flutter/material.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   @override
//   _ChangePasswordPageState createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   bool _isObscured = true;
//
//   void _changePassword() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Password successfully changed!")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: kToolbarHeight + 30,
//             decoration: BoxDecoration(
//               color: Color(0xff426586),
//               border: Border.all(color: Color(0xff648aae), width: 3.0),
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
//             ),
//           ),
//           Column(
//             children: [
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
//                           "Change Password",
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
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildPasswordField("Old Password", _oldPasswordController),
//                         SizedBox(height: 10),
//                         _buildPasswordField("New Password", _newPasswordController),
//                         SizedBox(height: 10),
//                         _buildPasswordField("Confirm Password", _confirmPasswordController),
//                         SizedBox(height: 20),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xff426586),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           onPressed: _changePassword,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//                             child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
//                           ),
//                         ),
//                       ],
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
//   Widget _buildPasswordField(String label, TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       obscureText: _isObscured,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(),
//         suffixIcon: IconButton(
//           icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
//           onPressed: () {
//             setState(() {
//               _isObscured = !_isObscured;
//             });
//           },
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return "$label cannot be empty";
//         }
//         if (label == "Confirm Password" && value != _newPasswordController.text) {
//           return "Passwords do not match";
//         }
//         return null;
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isObscured = true;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Create a credential with the old password
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: _oldPasswordController.text,
          );

          // Reauthenticate the user with the old password
          await user.reauthenticateWithCredential(credential);

          // Update the password
          await user.updatePassword(_newPasswordController.text);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password successfully changed!")),
          );

          // Clear the text fields
          _oldPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.message}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                          "Change Password",
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPasswordField("Old Password", _oldPasswordController),
                        SizedBox(height: 10),
                        _buildPasswordField("New Password", _newPasswordController),
                        SizedBox(height: 10),
                        _buildPasswordField("Confirm Password", _confirmPasswordController),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff426586),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _changePassword,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                            child: Text("Submit", style: TextStyle(fontSize: 18, color: Colors.white)),
                          ),
                        ),
                      ],
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

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: _isObscured,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label cannot be empty";
        }
        if (label == "Confirm Password" && value != _newPasswordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }
}
